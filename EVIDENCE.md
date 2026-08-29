# Evidence manifest

Every artifact cited in this repository is hashed and timestamped so it
can be verified independently and shown to be unaltered since collection.
Raw sensitive material is not republished here - its hash and archive
link prove existence and integrity without redistribution.

## On-chain evidence

| Artifact | SHA256 | Collected (UTC) |
| --- | --- | --- |
| `real/crypto/evidence/` package (SHA256SUMS.txt) | `525a8b53f6b3d2a3508c39bcb9893568487e2f333dadcdc6c810185bcb8b0222` | 2026-08-29 |

Solana data is public and re-pullable. The package holds the
raw pulls plus a per-file SHA256 manifest; regenerate any time.

## Media artifacts

| Artifact | File | SHA256 | Source |
| --- | --- | --- | --- |
| Profile picture (AI / Grok, C2PA intact) | `copycat/pfp-metadata/pfp.jpg` | `30997f019d5b943a81517c63425892766f6b8adbbe0495d26bb2c3228f6bf66f` | ipfs://bafkreibqtf7qdhk3sq5icul4mnbfretwn5vyvw56ask5e25symri627wn4 |
| Browser fingerprint screenshot | `copycat/browser/browser.png` | `9911ae29557b338305251105a03ffff4b0161e6ff2d0faed43353775d95ea4d8` | Telegram post /24, archive.ph/I0X9X |
| Browser chrome (zoom of the above) | `copycat/browser/browser-chrome-zoom.png` | `71e1c2cbb69a3d61f6eaf1b70c7c62a1bd3a467e3b1249ccaeb31a032526d954` | crop of copycat/browser/browser.png |
| Chrome Appearance panel (Citron reference) | `copycat/browser/browser-appearance-reference.png` | `6f0b3f7a01ffed7ffb04368f6ada7f9f16898b2931ddbf33d929fd0a45d22293` | reference: Chrome Settings > Appearance |
| CyberLeek homepage | `assets/cyber-leek-home.png` | `4a83ca85bc459fabcc8bbd6428100e4bb8e0dc273e652b8521a9301274a5a83c` | cyber-leek.com, archive.ph/cpbHi |
| X account @cyberleeksreal | `assets/x-account.png` | `43848aacf98e125a11d968fcbb071e607efdcaaebe3683ec858c95fde2aff818` | x.com/cyberleeksreal |
| CYBERLEEKS token mint (Solscan) | `assets/crypto-token-solscan.png` | `e0951a06bde449cd0c5ed2a547ca93a5af734014e0a56bbd5185146d45f28280` | solscan.io/token/2hRg6...bKpump |
| CYBERLEEK live market (DexScreener) | `assets/crypto-token-dexscreener.png` | `94982d580ca7cd44c4b332a218a092cfe35031a6fe8889bd2c9869bb10546466` | dexscreener.com/solana/ApZux..., 2026-08-28 |
| Poll: prologue with Lucia | `assets/crypto-poll-lucia.png` | `0c46f0012d2470750fb01104c2c3aee355e5b7d5ca87878a14c93c85fd26ab11` | cyber-leek.com poll, archive.ph/A4zKG |
| Poll: next GTA 6 video | `assets/crypto-poll-nextvideo.png` | `0f5bbf4d35ecc85570e4c59de44fcdea61d13675ebbf4125471640b78042a005` | cyber-leek.com poll (full homepage capture), archive.ph/cpbHi |
| Telegram "good morning" post /33 | `copycat/posting-pattern/tg-good-morning.png` | `0fca459dbe5b9a4e319b4c8312d2caa9befab3b9470b78071dd7cc60f57a896b` | t.me/cyberleeksreal/33, archive.ph/zkVZh |
| Telegram hashtags post /24 | `copycat/writing-style/tg-hashtags.png` | `4cb4928efcfa9d66da92152fefb8a03a75f1fa7885ce9e96627413ad8077d824` | t.me/cyberleeksreal/24, archive.ph/I0X9X |
| Telegram broken-English post /31 | `copycat/writing-style/tg-broken-english.png` | `630d28c7af6d27cb3f32f9028d4f76d3e738f9b5fa69815c097a4007414736fd` | t.me/cyberleeksreal/31, archive.ph/9J4OI |

## Infrastructure recon

| Artifact | File | SHA256 | Collected (UTC) |
| --- | --- | --- | --- |
| Operation recon (real cyber-leek.com; registrar Cloudflare, reg 2026-08-22) | `real/infrastructure/recon/operation-recon-2026-08-29.txt` | `eabab98964abbf9ee64ebd034e96b37b0f3646f29086914e9a2bc0b84eb59d86` | 2026-08-29 |
| Copycat recon (cyberleeks.fun; registrar Hostinger, reg 2026-08-25) | `real/infrastructure/recon/copycat-recon-2026-08-29.txt` | `b0510aaf22c6a90a2076eaedd1cc29f33e5d8a4b5d7f34de95efaaf87df0b031` | 2026-08-29 |

## Archived pages (archive.ph)

| Page / artifact | Snapshot |
| --- | --- |
| cyber-leek.com | https://archive.ph/cpbHi |
| cyberleeks.fun | https://archive.ph/rYIMI |
| Telegram channel (t.me/cyberleeksreal) | https://archive.ph/vA8cN |
| Telegram channel (writing-style source) | https://archive.ph/OnLUN |
| Telegram post /24 (hashtags + browser screenshot) | https://archive.ph/I0X9X |
| Telegram post /31 (broken English) | https://archive.ph/9J4OI |
| Google tag JS (gtag) | https://archive.ph/oPlW4 |

## Verify

```bash
# on-chain package
cd real/crypto/evidence && sha256sum -c SHA256SUMS.txt

# media artifacts
sha256sum copycat/pfp-metadata/pfp.jpg copycat/browser/browser.png
```
