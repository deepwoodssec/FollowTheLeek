#!/usr/bin/env bash
# THE REAL CYBER-LEEK OPERATION - passive infrastructure recon.
# Targets: cyber-leek.com and media.cyber-leek.com (the money operation).
# Passive only (public DNS / RDAP / TLS / CT / HTTP). Run in Terminal:  bash recon-operation.sh
# Writes operation-recon-<UTC-date>.txt beside this script and prints its SHA256.
set -u
DOMAINS=(cyber-leek.com media.cyber-leek.com)
REGDOMAIN=cyber-leek.com
OUT="operation-recon-$(date -u +%Y-%m-%d).txt"
GTAG="AW-18404896621"
sha(){ command -v shasum >/dev/null 2>&1 && shasum -a 256 "$1" || sha256sum "$1"; }
registrar(){ curl -sL -m 25 "https://rdap.org/domain/$1" | python3 -c '
import sys,json
try: j=json.load(sys.stdin)
except Exception: print("  (RDAP unavailable)"); sys.exit()
def walk(ents):
    for e in ents or []:
        if "registrar" in (e.get("roles") or []):
            fn=None
            for it in (e.get("vcardArray",[None,[]])[1] or []):
                if it and it[0]=="fn": fn=it[3]
            print("  registrar:", fn or e.get("handle","?"))
            for pid in e.get("publicIds",[]) or []: print("  registrar IANA id:", pid.get("identifier"))
        walk(e.get("entities"))
walk(j.get("entities"))
for x in j.get("events",[]) or []:
    if x.get("eventAction") in ("registration","expiration","last changed"):
        print("  "+x["eventAction"]+":", x.get("eventDate"))
if j.get("status"): print("  status:", ", ".join(j["status"]))
'; }
{
echo "CyberLeek OPERATION recon (the real cyber-leek.com) - passive"
echo "Collected (UTC): $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "======================================================"
echo; echo "== DOMAIN REGISTRAR (RDAP: $REGDOMAIN) =="
registrar "$REGDOMAIN"
echo; echo "== DOMAIN REGISTRAR (whois fallback) =="
command -v whois >/dev/null 2>&1 && whois "$REGDOMAIN" 2>/dev/null | grep -iE "registrar:|creation date|created|updated date|registry expiry|domain status|name server" | sed 's/^/  /' || echo "  (whois not installed; RDAP above is authoritative)"
echo; echo "== DNS A RECORDS =="
for d in "${DOMAINS[@]}"; do echo "  $d -> $(dig +short A "$d" | tr '\n' ' ' || echo '<none>')"; done
echo; echo "== NAMESERVERS =="
for d in "${DOMAINS[@]}"; do echo "  $d -> $(dig +short NS "$d" | tr '\n' ' ' || echo '<none>')"; done
echo; echo "== IP OWNERSHIP + REVERSE DNS =="
for d in "${DOMAINS[@]}"; do ip=$(dig +short A "$d" | head -1); [ -n "$ip" ] && { echo "  $d ($ip):"; curl -s -m 12 "https://ipinfo.io/${ip}/json"; echo "  rDNS: $(dig +short -x "$ip" | tr '\n' ' ')"; }; done
echo; echo "== HTTP STATUS =="
for d in "${DOMAINS[@]}"; do code=$(curl -s -m 12 -o /dev/null -w "%{http_code}" -A "Mozilla/5.0" "https://$d" 2>/dev/null); [ "$code" = "000" ] && code="000 (no response / down)"; echo "  https://$d -> HTTP $code"; done
echo; echo "== TLS CERT =="
for d in "${DOMAINS[@]}"; do echo "  -- $d --"; echo | openssl s_client -servername "$d" -connect "$d:443" 2>/dev/null | openssl x509 -noout -issuer -subject -dates 2>/dev/null | sed 's/^/    /' || echo "    (no TLS response)"; done
echo; echo "== CERTIFICATE TRANSPARENCY (crt.sh $REGDOMAIN) =="
curl -s -m 20 "https://crt.sh/?q=${REGDOMAIN}&output=json" | python3 -c '
import sys,json
try: rows=json.load(sys.stdin)
except Exception: rows=[]
seen=set()
for r in rows:
    k=(r.get("issuer_name",""),r.get("not_before",""))
    if k in seen: continue
    seen.add(k); print("   ",r.get("not_before",""),"|",r.get("common_name",""),"|",r.get("issuer_name","")[:50])
' 2>/dev/null | head -12 || echo "  (crt.sh unavailable)"
echo; echo "== GOOGLE ADS TAG ($GTAG) =="
body=$(curl -s -m 12 -A "Mozilla/5.0" "https://cyber-leek.com" 2>/dev/null)
echo "$body" | grep -q "$GTAG" && echo "  cyber-leek.com : $GTAG FOUND in page source" || echo "  cyber-leek.com : $GTAG not found (changed, blocked, or site down)"
} > "$OUT" 2>&1
echo "Wrote $OUT"; sha "$OUT"
