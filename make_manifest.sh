#!/usr/bin/env bash
# Generate a SHA256 manifest for evidence artifacts, recording the
# ACQUISITION time live (the moment this runs), not filesystem mtime.
#
# mtime is filesystem metadata: it changes on copy, git operations, and
# edits, so it is NOT a reliable acquisition timestamp. Capture time must
# be recorded at collection, alongside the source. This script stamps the
# run time (UTC) as the acquisition time for the files it hashes; for the
# most rigorous chain of custody, record source + UTC time at the moment
# you first obtain each artifact.
#
# Usage:  bash make_manifest.sh /path/to/artifacts
set -euo pipefail
DIR="${1:-.}"; cd "$DIR"
if command -v sha256sum >/dev/null 2>&1; then HASH="sha256sum"; else HASH="shasum -a 256"; fi
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)

echo "# manifest generated (acquisition/verification time, UTC): $NOW"
echo "# NOTE: the time column is when THIS manifest was generated, not file mtime."
echo "| Artifact | SHA256 | Manifest time (UTC) | Source (fill in) | archive.ph |"
echo "|----------|--------|---------------------|------------------|------------|"
: > SHA256SUMS
for f in *; do
  [ -f "$f" ] || continue
  [ "$f" = "SHA256SUMS" ] && continue
  sum=$($HASH "$f" | awk '{print $1}')
  echo "$sum  $f" >> SHA256SUMS
  echo "| $f | \`$sum\` | $NOW | TODO | TODO |"
done
echo
echo "SHA256SUMS written in: $(pwd)  (generated $NOW)"
echo "Verify later with:  (cd \"$DIR\" && $HASH -c SHA256SUMS)"
