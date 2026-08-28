CyberLeek cryptocurrency evidence package
Collected (UTC): 2026-08-27T19:39:53Z
Collector host : [redacted]

CONTENTS
  raw/                 Unedited JSON responses from public blockchain APIs
  summary_*.txt        Human-readable timestamp / hash / amount extracts
  collection_log.txt   Timestamped log of every fetch performed
  SHA256SUMS.txt       SHA256 of every file (integrity / chain of custody)

SOURCES
  Solana JSON-RPC (getSignaturesForAddress, getTransaction)

INTEGRITY
  To verify nothing changed after collection:
      cd evidence_20260827_193828Z && sha256sum -c SHA256SUMS.txt
  Note: SHA256SUMS.txt hashes every OTHER file. Store a copy of that
  file separately (email it to yourself) to timestamp the package.

ADDRESSES OF RECORD
  Solana token mint:             2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump
