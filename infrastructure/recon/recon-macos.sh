#!/usr/bin/env bash
# CyberLeek passive infrastructure recon (macOS).
# Re-pulls DNS, IP ownership, TLS, Certificate Transparency, HTTP status, and the
# Google Ads tag for the three domains. Passive only (public DNS/HTTP/CT lookups,
# no intrusion). Run in Terminal:  bash recon-macos.sh
# Writes infra-recon-<UTC-date>.txt beside this script and prints its SHA256.
set -u
DOMAINS=(cyber-leek.com media.cyber-leek.com cyberleeks.fun)
OUT="infra-recon-$(date -u +%Y-%m-%d).txt"
GTAG="AW-18404896621"
sha() { if command -v shasum >/dev/null 2>&1; then shasum -a 256 "$1"; else sha256sum "$1"; fi; }
{
echo "CyberLeek infrastructure recon (passive) - macOS"
echo "Collected (UTC): $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "=================================================="
echo; echo "== DNS A RECORDS =="
for d in "${DOMAINS[@]}"; do ip=$(dig +short A "$d" | tr '\n' ' '); echo "  $d -> ${ip:-<no A record>}"; done
echo; echo "== NAMESERVERS =="
for d in "${DOMAINS[@]}"; do ns=$(dig +short NS "$d" | tr '\n' ' '); echo "  $d -> ${ns:-<none>}"; done
echo; echo "== IP OWNERSHIP (ipinfo.io) =="
for d in cyber-leek.com media.cyber-leek.com; do
  ip=$(dig +short A "$d" | head -1)
  [ -n "$ip" ] && { echo "  $d ($ip):"; curl -s -m 12 "https://ipinfo.io/${ip}/json"; echo; }
done
echo; echo "== HTTP STATUS (is it serving?) =="
for d in "${DOMAINS[@]}"; do
  code=$(curl -s -m 12 -o /dev/null -w "%{http_code}" -A "Mozilla/5.0" "https://$d" 2>/dev/null)
  [ "$code" = "000" ] && code="000 (no response / down)"
  echo "  https://$d -> HTTP ${code}"
done
echo; echo "== TLS CERT (openssl) =="
for d in cyber-leek.com media.cyber-leek.com; do
  echo "  -- $d --"
  echo | openssl s_client -servername "$d" -connect "$d:443" 2>/dev/null \
    | openssl x509 -noout -issuer -subject -dates 2>/dev/null | sed 's/^/    /' || echo "    (no TLS response)"
done
echo; echo "== CERTIFICATE TRANSPARENCY (crt.sh) =="
for d in cyber-leek.com cyberleeks.fun; do
  echo "  -- crt.sh $d --"
  curl -s -m 20 "https://crt.sh/?q=${d}&output=json" | python3 -c "
import sys,json
try: rows=json.load(sys.stdin)
except Exception: rows=[]
seen=set()
for r in rows:
  k=(r.get('issuer_name',''), r.get('not_before',''))
  if k in seen: continue
  seen.add(k)
  print('   ', r.get('not_before',''),'|',r.get('common_name',''),'|',r.get('issuer_name','')[:50])
" 2>/dev/null | head -12 || echo "    (crt.sh unavailable)"
done
echo; echo "== GOOGLE ADS TAG CHECK (expecting $GTAG) =="
for d in cyber-leek.com cyberleeks.fun; do
  body=$(curl -s -m 12 -A "Mozilla/5.0" "https://$d" 2>/dev/null)
  if echo "$body" | grep -q "$GTAG"; then echo "  $d : $GTAG FOUND in page source"
  else echo "  $d : $GTAG not found (page changed, blocked, or site down)"; fi
done
} > "$OUT" 2>&1
echo "Wrote $OUT"; sha "$OUT"
