![FollowTheLeek - tracing a GTA VI leak-branded crypto scam](assets/banner.png)

**CyberLeek** is an active cryptocurrency fraud operation built on stolen
intellectual property. It uses leaked Grand Theft Auto VI material -
Rockstar Games' unreleased IP - as bait to drive victims toward a
fraudulent token, then launders the proceeds through a cross-chain trail
and hides behind AI-generated branding.

This is an open, evidence-backed investigation that follows the operation
two ways: the **money**, traced on-chain from the token across a swap
and a bridge, and the **digital forensics** left in
the operation's own media and browser. Every indicator here is public, verifiable, and
cryptographically hashed - so researchers, defenders, exchanges, and
platforms can identify the operation, disrupt it, and protect victims.

Maintained by [Deep Woods Security](https://deepwoodssec.com).

## Sections

- [`crypto/`](crypto/) - the on-chain money trail, traced end to end
- [`pfp-metadata/`](pfp-metadata/) - the IPFS profile picture and its
  C2PA / Grok content-credential provenance
- [`browser/`](browser/) - the operator's browser fingerprint
- [`infrastructure/`](infrastructure/) - hosting, DNS, media delivery, and how the operation is wired
- [`posting-pattern/`](posting-pattern/) - activity times across official channels
- [`writing-style/`](writing-style/) - language and writing-style markers

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
