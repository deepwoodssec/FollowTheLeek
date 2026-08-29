CyberLeek crypto evidence package
Source: public Solana JSON-RPC + Helius Enhanced Transactions API. All data is
public and re-pullable; every entry carries its on-chain signature.

The evidence is split by track. operation/ is the real cyber-leek.com money
operation; copycat/ is the @cyberleeksreal pump.fun persona. On-chain the two do
not connect.

operation/  (the real one, the money)
  funding_spine/        the KuCoin funding trail: funding wallet 3YLN, buffer Ec2q,
                        creator Hok9, 270M-burn wallet Cbfb, ArNS name 52yK, Arweave
                        key 667G, KuCoin processing wallet BmFd, and one raw
                        getTransaction per cited hop (vc_tx_*.json).
  live_token/           the live SPL token ApZux: raw getTokenSupply / account.
    history/            parsed Helius history of the ApZux mint.
  polls/                the three pay-to-vote option wallets (Cpj7, 78Bk, 3wFK).

copycat/  (the persona)
  deployer/             raw pulls for the pump.fun deployer HhFa (balance, sigs, txs).
    history/            parsed Helius history for HhFa.
  funding/              the Relay solver F7p3 that bridged in to seed the deployer.
  token/                the pump.fun token 2hRg6: raw getTokenSupply / account.
    history/            parsed Helius history of the 2hRg6 mint.

collection_log.txt   timestamped log of every fetch.
SHA256SUMS.txt       SHA256 of every file (chain of custody).

VERIFY
  cd . && sha256sum -c SHA256SUMS.txt
