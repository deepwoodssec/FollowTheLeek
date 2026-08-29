#!/usr/bin/env bash
# THE COPYCAT PERSONA - passive infrastructure recon.
# Target: cyberleeks.fun (the @cyberleeksreal copycat persona's domain).
# Passive only (public DNS / RDAP / TLS / CT / HTTP). Run in Terminal:  bash recon-copycat.sh
# Writes copycat-recon-<UTC-date>.txt beside this script and prints its SHA256.
set -u
DOMAIN=cyberleeks.fun
OUT="copycat-recon-$(date -u +%Y-%m-%d).txt"
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
echo "CyberLeek COPYCAT recon (cyberleeks.fun, the persona) - passive"
echo "Collected (UTC): $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "======================================================"
echo; echo "== DOMAIN REGISTRAR (RDAP: $DOMAIN) =="
registrar "$DOMAIN"
echo; echo "== DOMAIN REGISTRAR (whois fallback) =="
command -v whois >/dev/null 2>&1 && whois "$DOMAIN" 2>/dev/null | grep -iE "registrar:|creation date|created|updated date|registry expiry|domain status|name server" | sed 's/^/  /' || echo "  (whois not installed; RDAP above is authoritative)"
echo; echo "== DNS A RECORD =="
echo "  $DOMAIN -> $(dig +short A "$DOMAIN" | tr '\n' ' ' || echo '<no A record>')"
echo; echo "== NAMESERVERS =="
echo "  $DOMAIN -> $(dig +short NS "$DOMAIN" | tr '\n' ' ' || echo '<none>')"
echo; echo "== IP OWNERSHIP + REVERSE DNS (if it resolves) =="
ip=$(dig +short A "$DOMAIN" | head -1); [ -n "$ip" ] && { echo "  $DOMAIN ($ip):"; curl -s -m 12 "https://ipinfo.io/${ip}/json"; echo "  rDNS: $(dig +short -x "$ip" | tr '\n' ' ')"; } || echo "  (no A record; nothing to geolocate)"
echo; echo "== HTTP STATUS =="
code=$(curl -s -m 12 -o /dev/null -w "%{http_code}" -A "Mozilla/5.0" "https://$DOMAIN" 2>/dev/null); [ "$code" = "000" ] && code="000 (no response / down)"; echo "  https://$DOMAIN -> HTTP $code"
echo; echo "== TLS CERT (if serving) =="
echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:443" 2>/dev/null | openssl x509 -noout -issuer -subject -dates 2>/dev/null | sed 's/^/  /' || echo "  (no TLS response)"
echo; echo "== CERTIFICATE TRANSPARENCY (crt.sh $DOMAIN) =="
curl -s -m 20 "https://crt.sh/?q=${DOMAIN}&output=json" | python3 -c '
import sys,json
try: rows=json.load(sys.stdin)
except Exception: rows=[]
seen=set()
for r in rows:
    k=(r.get("issuer_name",""),r.get("not_before",""))
    if k in seen: continue
    seen.add(k); print("   ",r.get("not_before",""),"|",r.get("common_name",""),"|",r.get("issuer_name","")[:50])
' 2>/dev/null | head -12 || echo "  (crt.sh unavailable)"
} > "$OUT" 2>&1
echo "Wrote $OUT"; sha "$OUT"
