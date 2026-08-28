# Evidence manifest

Every artifact cited in this repository is hashed and timestamped so it
can be verified independently and shown to be unaltered since collection.
Raw sensitive material is not republished here - its hash and archive
link prove existence and integrity without redistribution.

## On-chain evidence

| Artifact | SHA256 | Collected (UTC) |
| --- | --- | --- |
| `crypto/evidence/` package (SHA256SUMS.txt) | `e172d5a14ee45cb0c6b68f757f3915b51fe3baedf8c5e3f2ae421e39a8b89322` | 2026-08-27T19:38Z |

Solana and Ethereum data is public and re-pullable. The package holds the
raw pulls plus a per-file SHA256 manifest; regenerate any time.

## Media artifacts

| Artifact | File | SHA256 | Source |
| --- | --- | --- | --- |
| Profile picture (AI / Grok, C2PA intact) | `pfp-metadata/pfp.jpg` | `30997f019d5b943a81517c63425892766f6b8adbbe0495d26bb2c3228f6bf66f` | ipfs://bafkreibqtf7qdhk3sq5icul4mnbfretwn5vyvw56ask5e25symri627wn4 |
| Browser fingerprint screenshot | `browser/browser.png` | `9911ae29557b338305251105a03ffff4b0161e6ff2d0faed43353775d95ea4d8` | Telegram post /24, archive.ph/I0X9X |
| CyberLeek homepage | `assets/cyber-leek-home.png` | `4a83ca85bc459fabcc8bbd6428100e4bb8e0dc273e652b8521a9301274a5a83c` | cyber-leek.com, archive.ph/cpbHi |
| X account @cyberleeksreal | `assets/x-account.png` | `43848aacf98e125a11d968fcbb071e607efdcaaebe3683ec858c95fde2aff818` | x.com/cyberleeksreal |
| CYBERLEEKS token mint (Solscan) | `assets/crypto-token-solscan.png` | `e0951a06bde449cd0c5ed2a547ca93a5af734014e0a56bbd5185146d45f28280` | solscan.io/token/2hRg6...bKpump |

## Infrastructure recon

| Artifact | File | SHA256 | Collected (UTC) |
| --- | --- | --- | --- |
| DNS + IP + TLS certificate lookups | `infrastructure/recon/dns-cert-recon.txt` | `262887dc3e90b007c9d6b74f6ff82454cf10e122c4d249542441d7f2e3f46abd` | 2026-08-27 |

## Archived pages (archive.ph)

| Page / artifact | Snapshot |
| --- | --- |
| cyber-leek.com | https://archive.ph/cpbHi |
| cyberleeks.fun | https://archive.ph/rYIMI |
| Telegram channel (t.me/cyberleeksreal) | https://archive.ph/vA8cN |
| Telegram post /24 (hashtags + browser screenshot) | https://archive.ph/I0X9X |
| Telegram post /31 (broken English) | https://archive.ph/9J4OI |
| Google tag JS (gtag) | https://archive.ph/oPlW4 |

## Verify

```bash
# on-chain package
cd crypto/evidence && sha256sum -c SHA256SUMS.txt

# media artifacts
sha256sum pfp-metadata/pfp.jpg browser/browser.png
```
