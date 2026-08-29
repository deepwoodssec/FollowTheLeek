CyberLeek crypto evidence package
Source: public Solana JSON-RPC (api.mainnet-beta.solana.com) + Helius Enhanced
Transactions API. Funding-trail re-pull 2026-08-13; token/persona re-pull through
2026-08-28. All data is public and re-pullable; every entry carries its on-chain
signature.

WHAT THIS PACKAGE PROVES (the trail that stands)
  1. Funding spine -> KuCoin. One funding wallet (3YLN) paid for the whole setup:
     the ArNS site name (52yK), the Arweave upload key (667G), and the token, via
     a buffer (Ec2q) into the creator (Hok9). That funding wallet's SOL traces back
     six hops to a KuCoin processing wallet (BmFd), a KYC exchange. One raw
     getTransaction per cited hop is in funding_spine/ (vc_tx_*.json). This trace
     was first published by GTAForums user Vice Cit and reproduced here.
  2. The 270M burn. The creator (Hok9) sent 270,000,000 dev tokens to a holding
     wallet (Cbfb) which burned them (instruction type BURN).
  3. Two tokens, one name. The live SPL token (ApZux, the operation, shown on
     cyber-leek.com) and the pump.fun Token-2022 (2hRg6, the copycat persona;
     deployer HhFa, seeded via Relay solver F7p3). On-chain the two do not connect.
     token_supply_/token_account_ files cover both mints.
  4. Pay-to-vote polls. The option wallets (Cpj7, 78Bk, 3wFK) are recycled across
     polls; their full histories are in complete_history/.

CONTENTS
  funding_spine/       the KuCoin funding trail, the burn, the creator, the ArNS
                       and Arweave keys, the KuCoin processing wallet, and one raw
                       getTransaction per cited hop (vc_tx_*.json).
  raw/                 unedited getBalance / getSignaturesForAddress /
                       getTransaction responses for the two token mints and the
                       copycat deployer (HhFa).
  complete_history/    parsed per-wallet history (Helius Enhanced API) for the two
                       mints, the copycat deployer (HhFa) and its Relay funder
                       (F7p3), and the three poll option wallets. Re-verifiable via
                       raw getTransaction.
  collection_log.txt   timestamped log of every fetch.
  SHA256SUMS.txt       SHA256 of every file (chain of custody).

VERIFY
  cd . && sha256sum -c SHA256SUMS.txt
