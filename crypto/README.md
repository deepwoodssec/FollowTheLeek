# Crypto: tracing the money

Passive on-chain analysis of the CyberLeek scam tokens on Solana, traced
from the token dump to where the proceeds leave Solana. Every address and
amount here is verifiable on a block explorer. Where the trail crosses a
bridge off Solana, this section says so and names the record-holder.

## How the rug pull works, in plain terms

Before the addresses and amounts, the mechanism in five steps:

1. The operator creates the token and keeps a large share for himself at zero cost (he minted it).
2. He drives real buyers in with hype: the GTA VI leak brand, a "50% free" offer, a headline market cap.
3. Buyers pay real SOL into the token's Raydium liquidity pool to get tokens. That pool fills with their money.
4. The operator sells his own free tokens into that same pool, which pulls the buyers' SOL back out into his wallets.
5. He put in nothing and walks away with real SOL. The buyers are left holding a token that craters as he sells.

That is the rug pull. The on-chain tell is a wallet that **sold a large amount
having bought nothing**: it could only have been handed those tokens at
creation. The rest of this section identifies those dump wallets and traces
where the SOL went after he pulled it out.


## The tokens

Two CyberLeek tokens exist. The one with real money is the one the site
points buyers at.

| Token | Address | What it is |
| --- | --- | --- |
| **CYBERLEEK (live)** | `ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg` | classic SPL; \~729.95M supply; 9 decimals; the CA displayed on cyber-leek.com. Trades on Raydium: \~$681K liquidity, \~$7.5M volume, 47,800+ transactions, 61,000+ holders, \~$3.1M market cap (Solscan / DexScreener, 2026-08-28). |
| CYBERLEEKS (earlier run) | `2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump` | Token-2022 (program verified on-chain), launched on pump.fun (the `pump` suffix and its pump.fun listing); 1B supply; 6 decimals; deployer `HhFaWEVRSktrUo3TnUdVrDmE6LHbkEi5rwNyR85P2GSB` (created 2026-08-25T06:33:48Z), itself funded via the Relay bridge. Stalled on the bonding curve; low activity. |

The advertised "$17M market cap" on the site is nominal (supply x price).
The real, tradeable money is the Raydium liquidity behind the live token.

The two tokens mark a progression. The earlier one was launched on **pump.fun**,
a Solana memecoin launchpad where a token starts on an automated bonding curve
and only migrates to a full exchange if it gains enough traction. It stalled
there. The operator then relaunched as the classic-SPL live token above and
advertised it as the "second run", and that is the one that caught real money on
Raydium (pump.fun/coin/2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump).

![Live CYBERLEEK/SOL market on Raydium (DexScreener)](../assets/crypto-token-dexscreener.png)

*The live CYBERLEEK/SOL market on Raydium (DexScreener, 2026-08-28 around 20:00 UTC, later than the table above). A real, high-volume market and a token selling off: market cap sliding from about $7.6M at peak to about $1.9M (24h -53.78%), with sells (13,202) outnumbering buys (11,478) and sellers (5,308) outnumbering buyers (2,777). Liquidity about $527K, 24h volume about $3.2M, 58,940 holders. This is the pool the dump wallets sold into.*

## The mechanism: free allocation, dumped

The operator holds token supply at cost basis zero (creator / team
allocation) and sells it into the pool that real buyers are filling. The
on-chain signature is unmistakable on the token's top traders: **wallets
that sold a large amount having bought nothing.**

- `7sgG1Dsk84fgia5ewkhd8RfFymk64ETBVxs72Pzc2zDW` - **sold \~$174K** (10.7M
  tokens over 62 sells), **bought $0**.
- `EfVhmasWL89KnqkNdHJ2TK3YC31aWMwU1vWR4Yb3SreE` - sold \~$93.6K, bought $0.
- A cluster of further "sold, never bought" wallets appears in the token's
  top-trader list and as connected groups on a holder bubble map,
  consistent with a coordinated bundle rather than organic sellers.

A wallet cannot sell 10.7M tokens it never bought unless it was handed them
at creation. That is the dump.

## Pay-to-vote polls: manufactured demand, paid in $CYBERLEEK

The operation also ran on-site "polls" that charge the audience to take part.
The site's own rules state the mechanism:

> "Send only $CYBERLEEK to the wallet of the choice you want to vote for.
> Each dedicated wallet is checked for the configured token mint... The
> percentage is each option wallet's detected balance divided by the poll
> total."

So a "vote" is a transfer of $CYBERLEEK to an operator-controlled wallet, and
the poll decides which leak video drops next, which is what pulls the next wave
of buyers into the token. The polls are a second on-chain intake and a
demand-manufacturing device at once.

![Poll: prologue with Lucia](../assets/crypto-poll-lucia.png)

*"Do you really want to see the prologue with Lucia?", shown at 99.7 percent
Yes. Voters send $CYBERLEEK to `Cpj7...` (Yes) or `3wFK...` (No). Archived:
https://archive.ph/A4zKG*

![Poll: next GTA 6 video](../assets/crypto-poll-nextvideo.png)

*A second live poll, "Next GTA 6 Video?", on the same widget with the same
wallets carrying new option labels. Captured in the full homepage archive: https://archive.ph/cpbHi*

**The option wallets are recycled across polls, so the displayed totals are not
independent vote counts.** The same two wallets carry different, unrelated
options in the two polls above:

| Option wallet | In the "Lucia" poll | In the "Next video" poll |
| --- | --- | --- |
| `Cpj7QARnmVR39NBGe4NWppUF7WUrWMamen4WsJNmbHQy` | "Yes Please" (262,141 shown) | "Beach" (11,706 shown) |
| `3wFKU8bzomz8eSn179JFzR4oimC3esEXxhbaWtKgJ3K3` | "Fuck No" (904 shown) | "Nudist Town" (56,502 shown) |
| `78BkUe4bywGhK6SJDHj5uwfyFJZ9NDG3iQ5U7rxo7QWA` | not used | "Strip Club 2" (11,351 shown) |

A wallet that is "Yes Please" in one poll and "Beach" in another is not a
dedicated ballot box. On-chain these wallets are short-lived: active only in a
brief window, their token accounts closed to reclaim rent, then abandoned
(current balances zero), and one inbound token load to an option wallet was
authorized by the same Relay solver (`F7p3...`, shared bridge infrastructure)
that appears in the money trail above. The percentages are presentation, not a
tally of independent voters.

Verifiable here: the pay-to-vote mechanism, the option-wallet addresses, their
reuse across polls, and their short-lived operator-side on-chain footprint.
What the polls produce for the operator is engagement paid in $CYBERLEEK and a
pretext for the next drop.


## The cash-out, traced on-chain to the bridge

The dump proceeds converge through a relay and cross into Hyperliquid via
the Unit ("Hyperunit") bridge. Every hop is a plain SOL transfer, labelled
on Solscan:

```mermaid
flowchart TD
    RB["Relay bridge (value in)"] -.->|seed SOL| DU["7dU2nE / feeder wallets"]
    A7["7sg dump wallet"] -->|"1,849.73 SOL"| RELAY
    HC["Hc8yCCo4..."] -->|"950.77 SOL"| RELAY
    DU -->|"481.39 SOL"| RELAY
    RELAY["5kSRXuv relay (pass-through, ~$0.48)"] -->|"3,281.88 SOL (~$344K)"| UNIT
    UNIT["9SLPTL41 : Unit / Hyperunit bridge (shared custody)"] -->|bridge| HL["operator's Hyperliquid account (subpoena target)"]
```

- **Relay:** `5kSRXuvcdkmuDUdUbJnCakwxZithtY1SnEs6S5SpVKeA` - 16
  transactions total, holds \~$0.48. Every amount in is forwarded out
  near-instantly (e.g. in 289.68 -> out 289.67). A pass-through layering
  wallet, not a store of value.
- **Bridge:** `9SLPTL41SPsYkgdsMzdfJsxymEANKr5bYoBsQzJyKpKS` - Solscan
  labels it **"Hyperunit: Hot Wallet"**; it holds \~348,043 SOL (\~$36.5M)
  across 1,000+ transactions. This is the **Unit bridge's shared custody
  hot wallet**, the deposit endpoint that moves native SOL onto Hyperliquid.

**\~3,282 SOL (\~$344K)** moved through this single path to the Unit bridge.
The relay's inbound reconciles with its outbound to the lamport: `7sg` sent
1,849.73 SOL, `Hc8yCCo4...` 950.77 SOL, and `7dU2nE...` 481.39 SOL (3,281.89
SOL in), and the relay forwarded 3,281.88 SOL to the Unit bridge.

The inbound side runs a second bridge. The wallets were seeded through
**Relay**: its solver `F7p3dFrjRTbtRp8FRF6qHLomXbKRBzpvBLjtQcfcgmNe` funded
`7dU2nE`, the second dump wallet `EfVhmasW...`, and the token deployer. So the
operation runs value **in through Relay** and **out through Unit** into
Hyperliquid.

`EfVhmasWL89KnqkNdHJ2TK3YC31aWMwU1vWR4Yb3SreE` is a second dump wallet (sold
\~$93.6K, bought $0) funded the same way. Its full outflow is not traced here.

## Where the Solana trail ends, and the real subpoena targets

Be precise about the boundary, because it is where an outside trace has to
stop honestly:

- **`9SLPTL41` is not the operator.** Its \~$36.5M balance is the Unit
  bridge's pooled custody for all its users, exactly like a shared exchange
  hot wallet. We do not attribute it to anyone.
- **The deposit credits the operator's Hyperliquid account.** Unit records
  which account a given Solana deposit is bridged to, and Hyperliquid
  records what that account then does. Those two records tie the \~$344K to
  a specific Hyperliquid account.
- **Subpoena targets:** the **Unit bridge** (deposit-to-account mapping) and
  **Hyperliquid** (account activity and any onward withdrawal to a fiat
  exchange). Both are concrete and both are off the public Solana ledger.

The money bridged into Hyperliquid, and the record of whose account it is sits with
Unit and Hyperliquid.

## Indicators

| Type | Value |
| --- | --- |
| Live token (CYBERLEEK, SPL) | `ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg` |
| Earlier token (Token-2022) | `2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump` |
| Token-2022 deployer | `HhFaWEVRSktrUo3TnUdVrDmE6LHbkEi5rwNyR85P2GSB` |
| Dump wallet (sold big, bought $0) | `7sgG1Dsk84fgia5ewkhd8RfFymk64ETBVxs72Pzc2zDW` |
| Dump wallet (sold big, bought $0) | `EfVhmasWL89KnqkNdHJ2TK3YC31aWMwU1vWR4Yb3SreE` |
| Relay / layering wallet | `5kSRXuvcdkmuDUdUbJnCakwxZithtY1SnEs6S5SpVKeA` |
| Unit bridge hot wallet (shared infra) | `9SLPTL41SPsYkgdsMzdfJsxymEANKr5bYoBsQzJyKpKS` |
| Bridge / destination venue | Unit ("Hyperunit") -> Hyperliquid |
| Poll option wallet (pay-to-vote) | `Cpj7QARnmVR39NBGe4NWppUF7WUrWMamen4WsJNmbHQy` |
| Poll option wallet (pay-to-vote) | `3wFKU8bzomz8eSn179JFzR4oimC3esEXxhbaWtKgJ3K3` |
| Poll option wallet (pay-to-vote) | `78BkUe4bywGhK6SJDHj5uwfyFJZ9NDG3iQ5U7rxo7QWA` |

## Reproduce it

Token facts (supply, decimals, program owner):

    curl -s https://api.mainnet-beta.solana.com -X POST -H 'content-type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"getTokenSupply","params":["ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg"]}'

Follow a dump wallet's SOL to the relay and the bridge (parse `transfer`
instructions from each `getTransaction`):

    curl -s https://api.mainnet-beta.solana.com -X POST -H 'content-type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"getSignaturesForAddress","params":["5kSRXuvcdkmuDUdUbJnCakwxZithtY1SnEs6S5SpVKeA",{"limit":30}]}'

Top traders (the "sold big, bought nothing" signature) are read from the
token's Raydium market on DexScreener / Solscan.

## Confidence and limits

- **Verified on-chain / on public explorers:** the two tokens and their
  parameters; the dump-wallet signature (large sells, zero buys); the
  relay; the bridge destination and its label; and the \~3,282 SOL amount.
- **Established but off the public Solana ledger:** the identity of the
  operator's Hyperliquid account and any onward cash-out to fiat. These
  live in Unit's and Hyperliquid's records, which is why they are
  named as subpoena targets.

## Evidence files (hashed)

Raw Solana pulls for every address in this section, plus a SHA256 manifest,
are in [`evidence/`](evidence/):

- `raw/token_*.json` - supply and account info for both tokens
- `raw/dump_*.json`, `raw/relay_*.json`, `raw/paymaster_*.json`,
  `raw/feeder_*.json`, `raw/funder_*.json`, `raw/deployer_*.json`,
  `raw/bridge_*.json` - balance, signatures, and raw transactions for each
  hop in the trail
- `collection_log.txt` - timestamped log of every fetch
- `SHA256SUMS.txt` - SHA256 of every file (chain of custody)

Manifest SHA256: `929aefad99c295134d12fb03f6fa77bdc306b03901bcb0db3cc977810cecb789`

Verify:

    cd evidence && sha256sum -c SHA256SUMS.txt
