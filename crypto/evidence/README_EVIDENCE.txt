CyberLeek crypto evidence package (corrected trail)
Collected (UTC): 2026-08-28T15:04:05Z
Source: public Solana JSON-RPC (api.mainnet-beta.solana.com)

CONTENTS
  raw/                 unedited getBalance / getSignaturesForAddress / getTransaction responses
  collection_log.txt   timestamped log of every fetch
  SHA256SUMS.txt       SHA256 of every file (chain of custody)

TRAIL
  ApZux token (live) -> dump wallets (7sg,EfV: sold big, bought 0)
  -> relay 5kSRXuv -> Unit bridge 9SLPTL41 ("Hyperunit") -> Hyperliquid
  9SLPTL41 is shared bridge custody, not the operator. The deposit credits
  the operator's Hyperliquid account (Unit + Hyperliquid hold that record).

ADDENDUM (2026-08-29): complete re-pull
  raw/reconcile_*.json      12 canonical raw getTransaction responses that prove the
                            cash-out reconciliation (6 deposits to the relay, 6 payments
                            out to the bridge), 4,185.98 SOL in = out to the lamport.
  reconciliation_signatures.txt   the 12 signatures.
  complete_history/*.json   complete per-wallet history from the Helius Enhanced
                            Transactions API (parsed). Every entry carries its on-chain
                            signature and is re-verifiable via raw getTransaction.
                            Includes 16 examined-and-excluded top-trader "bundle" wallets.
