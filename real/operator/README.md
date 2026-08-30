# The operator

Who is behind the operation. As of this writing that is not publicly known:
independent coverage still lists CyberLeek's identity as unconfirmed
([SoCRadar](https://socradar.io/blog/gta-vi-leak-cyberleek-explained/)). This
file tracks the one named lead the public record has produced, and the method we
are using to test it. Nothing here is an attribution. It is an open lead,
reported as others have reported it, set against what the on-chain record can
and cannot corroborate.

## The lead: a Discord handle and a Dread post

Public reporting in mid-August 2026 surfaced a handle of interest,
**`stayonthegrindd`** (also seen written `stayonthegrindd!!`). The account,
first laid out by GTAForums investigator Vice Cit and then picked up by the
games press, sits at the seam between the dark-web origin and the clearnet
launch:

- On **2026-08-18** a user called **`Cyberleeker`** posted a GTA VI basketball
  gameplay clip on the dark-web forum **Dread**, hours before it surfaced on the
  clearnet ([Gameranx](https://gameranx.com/updates/id/563817/article/the-gta-6-cyberleek-manhunt-may-have-a-lead-that-goes-through-discord-and-the-dark-web/)).
- The same day, **`stayonthegrindd`** appeared in the r/GTAVI Discord server,
  shared that same basketball clip, claimed access to the full map, and said he
  would return with driving gameplay ([Kotaku](https://kotaku.com/the-hunt-for-the-gta-6-leaker-seems-to-be-getting-closer-to-its-target-2000728088),
  [Gameranx](https://gameranx.com/updates/id/563817/article/the-gta-6-cyberleek-manhunt-may-have-a-lead-that-goes-through-discord-and-the-dark-web/)).
- The map and then the driving gameplay appeared on the Arweave leak
  distribution within hours of those Discord messages, all attributed on-chain
  to CyberLeek ([Kotaku](https://kotaku.com/the-hunt-for-the-gta-6-leaker-seems-to-be-getting-closer-to-its-target-2000728088)).

The overlap in timing is what makes the lead worth chasing. But every outlet
that carried it kept the attribution open, and so do we: the reporting places
`stayonthegrindd` as CyberLeek, or a member of the group, or a person connected
to it, and states plainly that the accounts have not been confirmed to be the
same person ([Kotaku](https://kotaku.com/the-hunt-for-the-gta-6-leaker-seems-to-be-getting-closer-to-its-target-2000728088),
[Gameranx](https://gameranx.com/updates/id/563817/article/the-gta-6-cyberleek-manhunt-may-have-a-lead-that-goes-through-discord-and-the-dark-web/)).
It is equally possible the handle simply found the Dread clip and reposted it.

## What the on-chain record contributes

The value this investigation adds is not the Discord story, which is public, but
an independent clock. The Arweave leak-upload key (`667G`) went active
**2026-08-15 12:23 UTC**, and the on-chain distribution timestamps are hard
block times, not observation dates (see [`../crypto/`](../crypto/) and the
[timeline](../../README.md#timeline)). Those are the one part of this story that
cannot be edited after the fact. Two narrow, concrete tests follow from that:

- **Timing.** Do the on-chain Arweave upload times for the specific clips
  (basketball, map, driving) line up with the Discord and Dread post times
  attributed to `stayonthegrindd` and `Cyberleeker`, within the window the
  reporting claims? A tight, repeated correlation is evidence; a loose one is
  coincidence.
- **Money.** Does any wallet in the traced funding cluster
  ([`../crypto/`](../crypto/)) show a public tie to the handle: a tip or payment
  address posted under the name, an on-chain name, a reused identifier? None is
  known yet.

Neither test has been run to conclusion. Until one lands, `stayonthegrindd`
stays a handle of interest, not the operator. This repo does not name a person.

## How to extend this (method)

The reachable, repeatable steps, for anyone continuing the work. Everything
collected goes through the same chain of custody as the rest of this repo
(SHA256 into [`../../EVIDENCE.md`](../../EVIDENCE.md)) before it is cited here.

1. **Username footprint (Maigret).** Enumerate the handle across platforms to
   see where else it exists and what it links to:
   ```
   maigret stayonthegrindd -a --html --pdf
   maigret stayonthegrind -a            # single-d variant
   ```
   Record hits, dead ends, and account creation dates. Treat matches as leads,
   not proof; common handles collide across unrelated people.
2. **Dark-web origin (Dread).** Capture the original `Cyberleeker` Dread post and
   its forum timestamp over Tor. The Dread post carries no on-chain time, so it
   is anchored only by the forum clock and by the clips it contains.
3. **Discord capture.** Preserve the `stayonthegrindd` messages (server, message
   IDs, timestamps, edits and deletes) before they are removed.
4. **On-chain correlation.** Pull the Arweave upload block times for each clip
   and compare against the captured Discord and Dread times.
5. **Public sources.** Keep the citation trail; the press coverage is itself
   dated evidence of when the lead became public, and of how each outlet hedged
   it.

## Status

Open. One publicly reported handle of interest (`stayonthegrindd`), one
dark-web poster name (`Cyberleeker`), no confirmed link to a person, and no
on-chain tie between the handle and the funding cluster. Reported here as a lead
to be tested, not a conclusion.
