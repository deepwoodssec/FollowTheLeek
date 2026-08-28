![FollowTheLeek - tracing a GTA VI leak-branded crypto scam](assets/banner.png)

**CyberLeek** is an active cryptocurrency fraud operation built on stolen
intellectual property. It uses leaked Grand Theft Auto VI material -
Rockstar Games' unreleased IP - as bait to drive victims toward a
fraudulent token, then launders the proceeds through a cross-chain trail
and hides behind AI-generated branding.

This is an open, evidence-backed investigation that follows the operation
two ways: the **money**, traced on-chain from the token dump through a relay
and across a bridge, and the **digital forensics** left in
the operation's own media and browser. Every indicator here is public, verifiable, and
cryptographically hashed - so researchers, defenders, exchanges, and
platforms can identify the operation, disrupt it, and protect victims.

Maintained by [Deep Woods Security](https://deepwoodssec.com).

## The operation, start to finish

Read the sections in order and they tell one story. The operator stands up a
website on rented US servers and pushes traffic to it with Google Ads and
stolen GTA VI leak clips ([`infrastructure/`](infrastructure/)). Those clips
funnel victims into a cryptocurrency token he created for free: he hypes it,
lets real buyers pour their money into the trading pool, then sells his own
free tokens on top of them and bridges the proceeds off Solana toward a
trading platform ([`crypto/`](crypto/)). He tried to stay anonymous, but he
left fingerprints. His own screenshots expose the computer he works on and the
Google account he is signed into ([`browser/`](browser/)); the times he posts
reveal his daily rhythm and rule out whole continents
([`posting-pattern/`](posting-pattern/)); the way he writes points to the
language he grew up speaking ([`writing-style/`](writing-style/)); and even his
profile picture is AI-generated, so the persona itself is fabricated
([`pfp-metadata/`](pfp-metadata/)).

## Sections

- [`infrastructure/`](infrastructure/) - hosting, DNS, media delivery, and how the operation is wired
- [`crypto/`](crypto/) - the on-chain money trail, traced end to end
- [`browser/`](browser/) - the operator's browser fingerprint
- [`posting-pattern/`](posting-pattern/) - activity times across official channels
- [`writing-style/`](writing-style/) - language and writing-style markers
- [`pfp-metadata/`](pfp-metadata/) - the IPFS profile picture and its C2PA / Grok content-credential provenance

## Evidence integrity (chain of custody)

Every artifact cited in this repo is hashed and timestamped so anyone
can confirm it has not been altered since collection:

- **SHA256** of each source artifact is recorded in
  [`EVIDENCE.md`](EVIDENCE.md).
- **UTC capture time** is recorded next to each hash.
- **archive.ph** snapshots provide an independent, third-party timestamp
  for the live pages and posts.

Raw sensitive material (for example the leaked frames) is **not**
published here. Its hash and archive link are enough to prove it existed
and is unchanged, without redistributing it. Regenerate or verify the
manifest with [`make_manifest.sh`](make_manifest.sh).

## Deliberately not here

- No leaked media. The stolen frames are not redistributed.
- No personal-identity attribution. This documents the operation, not a
  named individual. We make no claim about whether it is run by one
  person or a group, or where they are located - those determinations
  are left to law enforcement. "Operator" is used throughout as neutral
  shorthand and does not imply a single individual.

## Contributing

PRs welcome if verifiable from public sources. Cite every indicator with
a block-explorer link, an archive.ph snapshot, or a transaction hash,
and include the artifact's SHA256. No PII, no leaked media, no
accusations against named people.

## Victims

Report to https://www.ic3.gov with your transaction hashes, wallet
addresses, and timestamps.
