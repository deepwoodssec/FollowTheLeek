# Crypto: tracing the money

We ran passive on-chain analysis on the money behind the CyberLeek leak operation
on Solana. Two different things carry the CyberLeek name. This section covers the
one with the real money, the leak site and its live token, and keeps it apart from a
copycat token that went nowhere.

Credit: the funding-to-exchange trace was first published by GTAForums user
[Vice Cit](https://gtaforums.com/topic/994376-spoilers-gta-vi-leaks-analysis-thread-part-ii/page/314/#comment-1072766077).
Reproduced independently here; raw transactions in
[`evidence/operation/funding_spine/`](evidence/operation/funding_spine/).

## Two things called CyberLeek (do not confuse them)

| | The operation (real money) | The copycat token (went nowhere) |
| --- | --- | --- |
| Token | live SPL `ApZuxdpz…` | pump.fun Token-2022 `2hRg6…pump` |
| Front | `cyber-leek.com` + Arweave leak distribution | `@cyberleeksreal` (X / Telegram), `cyberleeks.fun` |
| Funded by | one wallet (`3YLN…`) traced back to **KuCoin** | the shared Relay bridge |
| Status | locked liquidity earning fees; ~$270K cashed out (Aug 27) | stalled on the bonding curve |

**On-chain link between the two: none found.**

The rest of this section is the operation. The copycat token, and the social
persona around it, are a separate track (documented in the persona sections of
this repo). On-chain, nothing we can find connects them to the money.

## The token, and how it actually makes money

The live token (`ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg`) is a classic SPL
token, about 729.95M supply, 9 decimals, and it is the contract address shown on
`cyber-leek.com`. It trades on a real Raydium market with tens of thousands of
transactions and holders.

This is not a smash-and-grab rug. The creator supplied all the original liquidity
(about 730M CYBERLEEK and 330 SOL) and **locked it** with Raydium's burn-and-earn.
Locked means they cannot pull it back out and dump it, but they still collect the
trading fee on every buy and every sell. So the operator earns from **volume**, not
from selling the token.

Per [Vice Cit](https://gtaforums.com/topic/994376-spoilers-gta-vi-leaks-analysis-thread-part-ii/page/314/#comment-1072766077)'s fee analysis on the public Raydium data: roughly $29,000 went into
setting this up; the coin did about $15M in volume on day one (about $30,000 in
fees); total fees so far are on the order of $40,000 to $60,000, roughly $4,400 a
day at about $2.1M daily volume, for as long as interest holds. Those are estimates
from public market data, not exact figures.

That model explains what we saw. The leaks drip out and the site runs "vote on
the next leak" polls because the point is to keep the coin **trading**, not to make
one big splash. Sustained attention is the revenue.

![CYBERLEEK live market on Raydium (DexScreener): market cap fading from about $8M toward $1.9M](../../assets/crypto-token-dexscreener.png)

*The live CYBERLEEK token (`ApZux...`) on Raydium, via DexScreener. The market cap
slid from about $8M toward $1.9M (down ~54% in 24h) as holders sold, 13,202 sells
against 11,478 buys. The liquidity is locked (about $527K, note the lock icon on
the panel), so the operator cannot pull it, yet still earns the trading fee on
every one of those sells. The price dump falls on holders, not the operator: with
the dev allocation burned and the pool locked, the operator's income is the fee on
volume, whichever way the price runs. Captured 2026-08-28.*

## The 270M burn

At creation the supply was 1,000,000,000 CYBERLEEK. 730M went into the locked pool.
The remaining **270,000,000 were sent by the creator (`Hok9…`) to a holding wallet
(`Cbfb…`), which then burned all 270,000,000** (verified on-chain, instruction type
`BURN`). That removes the dev overhang that could otherwise have crashed the price,
and it is a deliberate "this is not a rug" signal that keeps the fee machine
credible. Our token-supply reading of 729,950,775 is exactly 1B minus that burn.

## The funding spine, traced back to KuCoin

This is our identity lead. One funding wallet paid for the whole setup, and we
traced its SOL back to a regulated exchange.

```mermaid
flowchart LR
    KC["KuCoin processing wallet<br/>BmFd (KYC exchange)"] --> H1["FWbi"] --> H2["J4zo"] --> H3["26sZ"] --> H4["EjsB"] --> H5["2ZdU"] --> FUND["Funding wallet<br/>3YLN"]
    FUND -->|"1 SOL"| NAME["ArNS site name<br/>52yK"]
    FUND -->|"1 SOL"| ARW["Arweave upload key<br/>667G"]
    FUND -->|"25.06 SOL"| BUF["Buffer<br/>Ec2q"]
    BUF -->|"321.42 SOL"| CRE["Token creator<br/>Hok9"]
    CRE --> LP["Locked Raydium LP<br/>730M CYBERLEEK + 330 SOL"]
    CRE --> BURN["270M to Cbfb, then BURNED"]
```

- **One funding wallet (`3YLNDXnV9fNysDWaD39uQxwxeSaMFeAswvoQPZNvuNA4`) paid for all
  three pieces:** the ArNS website name (owner `52yKvgZK…`), the Arweave
  leak-upload key (`667GfnDu…`, a Solana key that also signs the Arweave uploads),
  and the token, funded through a buffer wallet (`Ec2qmcpC…`) into the creator
  (`Hok9nbV8…`). Amounts reproduced from our pull: `3YLN` sent the buffer 17.3542 +
  7.7084 SOL; the buffer sent the creator 10 + 311.42 SOL; the creator then made
  the locked pool.
- **The funding wallet traces back to KuCoin.** Six hops, all reproduced from our
  own pull on 2026-08-13: `BmFdpraQ…` (a KuCoin processing wallet) sent 100.202 SOL
  to `FWbi…`, then `FWbi → J4zo → 26sZ → EjsB → 2ZdU → 3YLN`.
- **Why it matters:** the account behind that deposit has a verified real-world
  identity on file. KuCoin has required a government ID from all users since
  **July 15, 2023**, and its own policy is to answer authorized law-enforcement
  requests. That is the concrete off-ledger identity target. See **What KYC is**
  below for how that door opens, including the Seychelles / MLAT nuance.

Raw proof for every hop is in [`evidence/operation/funding_spine/`](evidence/operation/funding_spine/),
one `vc_tx_*.json` file per cited transaction.

## What KYC is, and why it is the identity lead

**KYC stands for "Know Your Customer."** It is the rule that makes a regulated
exchange verify who its users actually are: your real name, a government photo ID
(passport or driver's license), often a selfie and proof of address, before you
can trade, deposit, or withdraw. The exchange keeps that identity record on file.

This is the part that decides a trace like this. A blockchain wallet is
**pseudonymous**: it is a string of characters with no name attached. The public
ledger shows *what* moved and *where* it went, in full, forever, but never *who*
is behind the keys. On-chain analysis can follow the money across dozens of
wallets and still never reach a person. KYC is the one place the chain touches the
real world. The moment money comes **out of a KYC exchange account**, that account
has a verified human identity sitting behind it. So a trail that leads *backward into* an exchange beats one that leads *out to* a
mixer or a bridge. The exchange has a verified identity behind it; a mixer or bridge does not.

For this case specifically:

- **The identity exists.** KuCoin has required identity verification with a
  government ID from **all** users since **July 15, 2023** ([KuCoin identity
  verification statement](https://www.kucoin.com/announcement/en-kyc-user-identity-authentication-statement)). The account that
  funded this operation was verified under that rule, so a real identity is on
  file with the exchange.
- **KuCoin answers law enforcement, by its own written policy.** KuCoin publishes
  a [Law Enforcement Request Process](https://www.kucoin.com/legal/law-enforcement-request-guidelines) and states it will *"respond to all
  law enforcement requests from authorized law enforcement officials with proof
  of authority,"* returning account and identity records on a subpoena, court order,
  or warrant.
- **The Seychelles nuance.** KuCoin's operating entity, **Mek Global Limited**, is
  registered in the **Seychelles** (named as the defendant entity in [*People v.
  Mek Global Limited & PhoenixFin Pte Ltd d/b/a KuCoin*](https://ag.ny.gov/sites/default/files/2023.03.09_-_memorandum_of_law_-_people_v_mek_global_limited_and_phoenixfin_pte_ltd_dba_kucoin.pdf)), so a request from a foreign authority does not
  travel as a plain domestic subpoena; it goes through a **Mutual Legal Assistance
  Treaty (MLAT)**, which [KuCoin's own guidelines](https://www.kucoin.com/legal/law-enforcement-request-guidelines) require for cross-border
  requests.
- **Why it is more reachable now.** In **March 2025 [KuCoin pleaded guilty](https://www.justice.gov/usao-sdny/pr/kucoin-pleads-guilty-unlicensed-money-transmission-charge-and-agrees-pay-penalties)** in
  U.S. federal court (SDNY) to unlicensed money transmission and paid **$297.4M**, with
  ongoing compliance obligations. That plea gives U.S. authorities real leverage
  and a cooperation posture, Seychelles registration notwithstanding.

So the funding wallet's SOL leading back six hops to a KuCoin account is not a
loose thread. It is the point where a pseudonymous money trail meets a verified,
law-enforcement-reachable identity. That is the identity lead.

## The copycat token (separate, went nowhere)

A second token carries the CyberLeek name: a Token-2022 launched on **pump.fun**
(`2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump`, deployer `HhFaWEVR…`), promoted by
the `@cyberleeksreal` Telegram/X persona and the `cyberleeks.fun` domain. It stalled
on the bonding curve and never caught real money.

On-chain, this token and its deployer **do not connect to the funding spine or the
live token** in any transaction we can find. Whether it is the same operator using
separate, siloed wallets or a copycat riding the brand, no transaction links the
loud social persona to the money. The persona itself (the Telegram, the
AI-generated profile picture, the writing style, the posting rhythm) is documented
separately in this repo as its own track, and should not be read as the identity of
the money operator.

## Pay-to-vote polls: manufactured demand, paid in $CYBERLEEK

The operation's site, `cyber-leek.com`, also ran "polls" that charge the audience
to take part. Both polls below are captured on that site: the "Lucia prologue"
poll (archived: https://archive.ph/A4zKG) and the "Next GTA 6 video" poll (in the
homepage snapshot, https://archive.ph/cpbHi). The site's own rules state the
mechanism:

> "Send only $CYBERLEEK to the wallet of the choice you want to vote for. Each
> dedicated wallet is checked for the configured token mint... The percentage is
> each option wallet's detected balance divided by the poll total."

So a "vote" is a transfer of $CYBERLEEK to an operator-controlled wallet, and the
poll decides which leak drops next, which pulls the next wave of trading. The polls
are a second on-chain intake and a demand-manufacturing device at once.

![cyber-leek.com poll: "Do you really want to see the prologue with Lucia?"](../../assets/crypto-poll-lucia.png)

*The "Lucia prologue" poll on `cyber-leek.com`. "Yes Please" collects $CYBERLEEK to
`Cpj7QARn...`, "Fuck No" to `3wFKU8bz...`. Archived: https://archive.ph/A4zKG*

![cyber-leek.com poll: "Next GTA 6 Video?"](../../assets/crypto-poll-nextvideo.png)

*The "Next GTA 6 video" poll on the same site. The identical `Cpj7QARn...` wallet is
now labelled "Beach" and `3wFKU8bz...` is "Nudist Town", with `78BkUe4b...` added as
"Strip Club 2". Same wallets, different options. Archived: https://archive.ph/cpbHi*

**The option wallets are recycled across polls, so the displayed totals are not
independent vote counts.** The same two wallets carry different, unrelated options
across polls:

| Option wallet | In the "Lucia" poll | In the "Next video" poll |
| --- | --- | --- |
| `Cpj7QARnmVR39NBGe4NWppUF7WUrWMamen4WsJNmbHQy` | "Yes Please" | "Beach" |
| `3wFKU8bzomz8eSn179JFzR4oimC3esEXxhbaWtKgJ3K3` | "Fuck No" | "Nudist Town" |
| `78BkUe4bywGhK6SJDHj5uwfyFJZ9NDG3iQ5U7rxo7QWA` | not used | "Strip Club 2" |

A wallet that is "Yes Please" in one poll and "Beach" in another is not a dedicated
ballot box. The percentages are presentation, not a tally of independent voters.

## The cash-out (2026-08-27)

The fee model above produced a withdrawal, and we traced all of it. On 2026-08-27
the creator wallet (`Hok9`) claimed its accumulated Raydium trading fees, swapped
them to SOL, and split the proceeds across two exchanges over the following hours.
First flagged by GTAForums user
[Vice Cit (Part 4)](https://gtaforums.com/topic/1007096-spoilers-gta-vi-cyberleeks-discussion/page/52/#comment-1072787879);
we reproduced the entire flow hop by hop on our own node and it matches to the SOL.

The first two hops:

1. **07:27:33 - fee claim.** `Hok9` claims the locked-LP fees (tx `4YgZeKvf...z57V4`).
2. **07:28:16 - swap to SOL.** 15,487,189.424 CYBERLEEK to SOL (tx `4dHLvgko...AUHnu`).
3. **07:29 to 07:32 - four outflows, 2,705.07 SOL.** To four fresh wallets:
   `He8Q` 781.24, `BFeK` 741.63, `Bv6U` 676.52, `8hyp` 505.68.
4. **07:42 to 14:05 - each splits again** into eight second-hop wallets, which
   deliver to the two exchanges below.

```mermaid
flowchart LR
    HOK["Hok9 (creator)<br/>2,705 SOL"]
    HOK --> He8Q["He8Q 781"]
    HOK --> BFeK["BFeK 742"]
    HOK --> Bv6U["Bv6U 677"]
    HOK --> w8hyp["8hyp 506"]
    He8Q --> w7M79["7M79 391"]
    He8Q --> CfHp["CfHp 212"]
    He8Q --> G2Va["G2Va 178"]
    BFeK --> AZN1["AZN1 209"]
    BFeK --> CoSK["CoSK 533"]
    Bv6U --> GokF["GokF 378"]
    Bv6U --> HLSU["HLSU 298"]
    w8hyp --> HHRZ["HHRZ 506"]
    w7M79 --> KC["KuCoin deposits<br/>GPscf / eS4n -> BmFd"]
    AZN1 --> KC
    GokF --> KC
    CfHp --> HUB["btYki -> EceGdm<br/>-> 66ZQ -> 771y"]
    G2Va --> HUB
    HUB --> KC
    CoSK --> CCE["CCE.Cash 3Afn<br/>(no-KYC)"]
    HLSU --> CCE
    HHRZ --> CCE

    classDef kyc fill:#dcfce7,stroke:#166534,color:#052e16;
    classDef nokyc fill:#fee2e2,stroke:#991b1b,color:#450a0a;
    classDef hub fill:#f3f4f6,stroke:#6b7280,color:#111827;
    class KC kyc;
    class CCE nokyc;
    class HUB hub;
```

Here is where it lands, split almost evenly:

- **~1,368 SOL (51%) to KuCoin.** Directly: `7M79` (391), `AZN1` (209), and `GokF`
  (378) forward to two KuCoin deposit addresses (`GPscfRmN...bkQt`,
  `eS4n56zr...99qW`) and on to the KuCoin processing wallet `BmFd`, the same wallet
  the operation was funded from. Indirectly: `CfHp` (212) and `G2Va` (178) do not
  stop at a neutral hub. They are layered through four pass-through wallets
  (`btYki -> EceGdm -> 66ZQ -> 771y`, one of them a high-volume hub that mixes them
  with unrelated traffic) and then hit the same `GPscf` KuCoin deposit. That layered
  leg (~390 SOL) is KuCoin-bound too, so what first looked like a dead-end hub is
  really a KuCoin feeder. Routing money through extra hops like this is a textbook
  obfuscation pattern.
- **~1,337 SOL (49%) to CCE.Cash.** `CoSK` (533), `HLSU` (298), and `HHRZ` (506)
  forward to one CCE.Cash deposit wallet (`3AfnRwXv...J2rH`, Solscan public name
  "CCE.Cash: Exchange Deposit Wallet"), confirmed on our own pull (`CoSK` 08:31,
  `HLSU` 08:54, `HHRZ` 14:05 UTC). CCE.Cash is a non-custodial, no-KYC instant-swap
  service, so that leg leaves no identity record. `HHRZ` moved in the afternoon,
  hours after Vice Cit's morning snapshot, so our trace runs slightly past theirs.

The four splits reconcile exactly: 978 direct to KuCoin (36%) + 390 layered to
KuCoin through the hub (14%) + 1,337 to CCE.Cash (49%) = 2,705 SOL.

Two things stood out to us:

- **KuCoin is on both ends, and it is the larger end.** The operation was funded from a
  KuCoin account, and once we unwound the layered hub leg the majority of the
  profit (~51%) went straight back into KuCoin. Same exchange, same KYC records, on both
  the origin and the main cash-out destination. It is the best lead we have on who is
  behind this.
- **"At least two people" is Vice Cit's read, not our conclusion.** Vice Cit (Part
  4) infers two people from the KuCoin-plus-CCE.Cash split. On-chain we confirm the
  split and where each leg lands; we cannot confirm the headcount, and one person can
  use two exchanges. We record the split as fact and the headcount as Vice Cit's
  inference. (Our routing shows KuCoin, not CCE.Cash, taking the larger share once
  the hub leg is unwound.)

Profit picture: about $29,000 to set up against roughly $270,000 claimed and moved
here, a net on the order of $241,000, larger than the ~$40k to $60k early-window fee
estimate above because it is a later, cumulative withdrawal.

Every hop is reproducible. The KuCoin and hub legs are in our Helius pulls; the CCE
leg was confirmed keyless on the public Solana RPC:

    for A in CoSKZDV8V6mzJkwKZeQx1bp52yHMwQv28u1WaGZwCv59 \
             HLSU45P2DqDNiVserd1iFzgzv6E2nKjXjbSCzKJSh9RL \
             HHRZoUMxdWPP2ThsVbVjCJmDw6idP7rP6TUXyiVeMgDH; do
      curl -s https://api.mainnet-beta.solana.com -X POST -H 'content-type: application/json' \
        -d '{"jsonrpc":"2.0","id":1,"method":"getSignaturesForAddress","params":["'$A'",{"limit":10}]}'
    done

Raw pulls for this cash-out are in
[`evidence/operation/crosscheck/`](evidence/operation/crosscheck/) (`cashout_*.json`),
SHA256 in the manifest.

## Where the trail goes private

The public Solana data takes this to two doorways:

- **The funding side ends at KuCoin.** Past the exchange wallet the trail is inside
  KuCoin's private KYC records, reachable through KuCoin's law-enforcement request
  process (an MLAT for the Seychelles entity; see **What KYC is** above for the
  sources). That is the identity target.
- **The token side did cash out, on 2026-08-27.** The liquidity stays locked and the
  dev allocation was burned, but the accumulated trading fees were claimed, swapped
  to SOL, and split roughly in half: ~51% back to KuCoin (including a leg layered
  through a hub) and ~49% to the no-KYC CCE.Cash - see **The cash-out** above. The
  KuCoin half lands back at the same KYC exchange the operation was funded from; the
  CCE.Cash half goes private.

## Cross-checked against Divyasshree N's Bitquery analysis

Divyasshree N of Bitquery published two on-chain writeups of this operation
([part 1](https://bitquery.io/investigations/cyberleek-gta6-leak-coin),
[part 2](https://bitquery.io/investigations/cyberleek-deployer-funding-trace)).
We re-pulled every claim on our own node rather than take theirs. Most of it
held. Two claims did not, and both failures point the same way our split does.

**Confirmed on our own pull:**

- The same funnel (`Ec2qmc…`) to deployer (`Hok9…`), the six-hop chain, and the
  same honest limit that KuCoin rests on Vice Cit's exchange-side evidence, not
  an on-chain label. Independent agreement with the trace above.
- **The launch was front-run** (Divyasshree N's finding, confirmed on our own pull). Four of the five top-earning wallets are
  confirmed buying `$CYBERLEEK` in a roughly six-minute window on 2026-08-18, at
  block times that match Bitquery's to the second: `kai5bkD…` 17:48:44,
  `71CBfHX…` 17:50:43, `J6oZ2HN…` 17:50:53, `HmBPYty…` 17:54:02. None trace to
  the deployer. On a full pull, all four are high-volume sniper and arbitrage
  bots, each trading dozens to hundreds of unrelated tokens across 1,000+
  transactions, which matches Bitquery's own read that they "buy whatever
  moves." The launch was sniped by bots, not tipped; see **No insider timing**
  below.
- **The funding trail was salted with address-poisoning** (Divyasshree N's finding, confirmed on our own pull). Look-alike decoy
  wallets dusted the real hops at the real transfer times: `2ZdUMU9d…CJhD` and
  `2Z13…PJhD` hitting hop `EjsB…` on 2026-08-13 seconds before its real 18:50
  transfer, and `Ec2qL1n7…` (a look-alike of the funnel `Ec2qmc…`) hitting the
  feeder `2Kxn…` on 2026-08-15 during the real consolidation. This is textbook
  poisoning, most likely a scavenger bot preying on active wallets rather than
  the operator; either way it is noise laid across the trail.

**Did not hold (corrected here):**

- **No insider timing.** We earlier read the six-minute front-run as someone
  knowing the exact drop time. On a full pull of all four wallets they are
  automated sniper and arbitrage bots (30 to 172 distinct tokens, 1,000+
  transactions each), and Bitquery reached the same conclusion: "automated
  traders that buy whatever moves ... arbitrage bots." Sniper bots auto-buy new
  launches, so the timing is ordinary bot behaviour, not evidence of a tip.
  Evidence: [`evidence/operation/sniper_wallets/`](evidence/operation/sniper_wallets/).
- **Not a serial launcher.** Bitquery read other same-named tokens (`MDBLo…`,
  and `FYzoZ…` "Rockstar Gays") as the operator relaunching. On-chain they do
  not connect to the operation's money: `Hok9…` never pays them, `MDBLo…` is
  funded by an unrelated wallet, and `FYzoZ…` is funded by
  `F7p3dFrjRTbtRp8FRF6qHLomXbKRBzpvBLjtQcfcgmNe`, which is the **copycat's**
  shared Relay-bridge solver already documented in
  [`evidence/copycat/funding/`](evidence/copycat/funding/). So these are more
  copycats riding the same public bridge, not the operator's repeat launches.
  The operation's funnel launched exactly one token.
- **No timezone or geography.** Bitquery inferred a "Central European" working
  day. On our re-pull the funding wallets are active across all 24 hours with no
  clean dead zone; that inference leaned on a social account that has since been
  deleted and was never on-chain (see [`../operator/`](../operator/)). Not
  adopted.

Raw on-chain pulls for the confirmed items are in
[`evidence/operation/crosscheck/`](evidence/operation/crosscheck/) with SHA256,
same chain of custody as the rest.

## Indicators

| Type | Value |
| --- | --- |
| Live token (the operation) | `ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg` |
| Funding wallet | `3YLNDXnV9fNysDWaD39uQxwxeSaMFeAswvoQPZNvuNA4` |
| Buffer wallet | `Ec2qmcpCCD9hjahAcquiQf5JkZWCK68BUahCje1izYC7` |
| Token creator | `Hok9nbV89yBSKCttxe3goqajwbiqQa9mtHvQBsbJH3Np` |
| 270M burn wallet | `CbfbaNpCGV64g2fbLBC2NXKSygeJJuC7S6i36cy8RMPo` |
| ArNS site-name wallet | `52yKvgZKczDMUNBH4V8RSNG7tn9y8SxeyTavYBZmwDHZ` |
| Arweave upload key | `667GfnDuPmamKPhPRjTfUA1nGyxg1wgP6ro4HZZ8L33D` |
| KuCoin processing wallet (funding source) | `BmFdpraQhkiDQE6SnfG5omcA1VwzqfXrwtNYBwWTymy6` |
| KuCoin cash-out deposit wallets | `GPscfRmNgRjtv8dLAGcXTmX83AL1eTjXZwtR3BqubkQt`, `eS4n56zrQ4ESznC8mDxQhsY4JoCpEt1jDczgcQ299qW` |
| CCE.Cash cash-out deposit wallet | `3AfnRwXvWxu4HpA6HQQwMzWfP6bETq62oUrwPMfHJ2rH` |
| Copycat token (pump.fun, stalled) | `2hRg6EhT2Z21xKPDnzniENFbQzLazoSjwt6K26bKpump` |
| Copycat token deployer | `HhFaWEVRSktrUo3TnUdVrDmE6LHbkEi5rwNyR85P2GSB` |
| Poll option wallets | `Cpj7…`, `3wFK…`, `78Bk…` |

## Reproduce it

Token facts:

    curl -s https://api.mainnet-beta.solana.com -X POST -H 'content-type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"getTokenSupply","params":["ApZuxdpzMrbEYTGEzeY9afh5pj9d6qPRJCTgQYiipbKg"]}'

Walk the funding wallet's history and its inbound (the last hop before it is the
KuCoin chain):

    curl -s https://api.mainnet-beta.solana.com -X POST -H 'content-type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"getSignaturesForAddress","params":["3YLNDXnV9fNysDWaD39uQxwxeSaMFeAswvoQPZNvuNA4",{"limit":50}]}'

## Confidence and limits

- **Verified on-chain, reproduced from our own pull:** the funding wallet paying
  the ArNS name, the Arweave key, and the token creation; the six-hop chain from
  KuCoin to the funding wallet; the creator wallet; the 270,000,000 burn; and the
  2026-08-27 fee claim, CYBERLEEK-to-SOL swap, and the full split of ~2,705 SOL,
  every hop reproduced on our own pull (~51% to KuCoin including a layered hub leg,
  ~49% to the no-KYC CCE.Cash).
- **From public market data ([Vice Cit](https://gtaforums.com/topic/994376-spoilers-gta-vi-leaks-analysis-thread-part-ii/page/314/#comment-1072766077)'s fee analysis / DexScreener):** the ~$29k
  setup, the ~$40k to $60k in fees, the daily volume and fee rate. Estimates from
  public Raydium data, not exact figures.
- **Established but off the public ledger:** the identity behind the KuCoin account
  (reachable by a law-enforcement request; MLAT for the Seychelles entity).
- **Credit:** the funding-to-KuCoin trace was first published by GTAForums user
  [Vice Cit](https://gtaforums.com/topic/994376-spoilers-gta-vi-leaks-analysis-thread-part-ii/page/314/#comment-1072766077); we reproduced it independently.

## Evidence files (hashed)

Raw pulls plus a SHA256 manifest are in [`evidence/`](evidence/):

The package is split by track, the real operation and the copycat persona:

- `operation/` - the real cyber-leek.com money operation:
  - `funding_spine/` - the KuCoin funding trail: funding wallet, buffer, creator,
    270M-burn wallet, ArNS name, Arweave key, the KuCoin processing wallet, and one
    raw transaction per cited hop (`vc_tx_*.json`).
  - `live_token/` - the live SPL token (`ApZux`), raw supply/account plus parsed
    `history/`.
  - `polls/` - the three pay-to-vote option wallets (`Cpj7`, `78Bk`, `3wFK`).
  - `crosscheck/` - our own pulls verifying the Bitquery analysis (front-run
    sniper wallets, address-poisoning decoys, and the proof that the other
    same-named tokens trace to the copycat's shared bridge `F7p3`, not the
    operator), plus the 2026-08-27 cash-out trace (`cashout_*.json`): the creator
    fee claim, the swap, the four outflows, and the split to KuCoin, CCE.Cash, and
    the shared hub.
- `copycat/` - the `@cyberleeksreal` pump.fun persona:
  - `deployer/` - the pump.fun deployer (`HhFa`), raw pulls plus parsed `history/`.
  - `funding/` - the Relay solver (`F7p3`) that bridged in to seed the deployer.
  - `token/` - the pump.fun token (`2hRg6`), raw supply/account plus parsed
    `history/`.
- `collection_log.txt`, `README_EVIDENCE.txt` - what was collected and when.
- `SHA256SUMS.txt` - SHA256 of every file (chain of custody).

Manifest SHA256: `cc6aeaf608c51ecf798998dcc72c50c8f5372cc63442d5536ba16aee18af2824`

Verify:

    cd evidence && sha256sum -c SHA256SUMS.txt
