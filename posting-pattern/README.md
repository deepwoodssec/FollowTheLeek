# Posting pattern and activity times

> **Which track: the persona, not the money.** This section documents the loud
> half of the case: the `@cyberleeksreal` Telegram / X account, the
> `cyberleeks.fun` domain, and a pump.fun token that stalled. On-chain, none of it
> connects to the KuCoin-funded wallets behind the live token and the leak site
> (see [`../crypto/`](../crypto/)). Whether this persona is the money operator
> keeping a loud alias walled off, or a copycat riding the brand, is unproven.
> Read what follows as observations about the persona, not an identification of
> whoever holds the money.


When the persona is active on its channels, measured from two independent
sources: the Telegram channel and the pump.fun token deployer wallet, both part of
this persona and not the wallet behind the money. Post and transaction times are facts you can
measure; the pattern they form is the finding.


![Daily activity window, UTC - Telegram and on-chain deployer sessions](activity-window.png)

## In plain terms

People run on habits, and scammers are no exception. If you write down the
exact time of everything the operator does in public, both his Telegram posts
and his own blockchain transactions, a daily rhythm appears: the hours he is
awake and working, and the hours he goes dark. One catch has to be handled
first: apps show each viewer the time in their own local zone, so to compare
honestly we convert every timestamp to one shared world clock called **UTC
(Coordinated Universal Time)**, the global reference that does not shift with
location or daylight saving. Lined up in UTC, his active window and his quiet
window are consistent from day to day. That repeatable rhythm is what
investigators call a **pattern of life**. It does not name him, but it links
his separate accounts to one routine and, because morning and night fall at
different UTC hours around the world, it hints at what part of the globe he
sits in.

## Sources

- **Telegram** - `t.me/cyberleeksreal` post datetimes (scraped from the public `t.me/s/` view). Raw: [`telegram-post-times.txt`](telegram-post-times.txt).
- **On-chain** - transactions signed by the CYBERLEEKS deployer wallet `HhFaWEVRSktrUo3TnUdVrDmE6LHbkEi5rwNyR85P2GSB` (the operator's own signed actions, not general token trades). Raw: [`deployer-onchain-times.txt`](deployer-onchain-times.txt).

## Method

Timestamps are parsed as timezone-aware and normalized to UTC before
binning. Activity is counted as **sessions**: events within a 10-minute
gap count once, so a rapid sequence of posts or transactions registers as
one active period rather than many. Both the raw event count and the
session count are shown below. See [`analyze_times.py`](analyze_times.py).

## Data

23 Telegram posts + 23 on-chain deployer actions. All timestamps UTC.

![Operator activity by hour, UTC - Telegram and on-chain deployer activity](activity-by-hour.png)

```
hour          TG (raw/sessions)   on-chain (raw/sessions)
03:00              1 / 1                1 / 1
05:00              1 / 1                4 / 1
06:00              1 / 1                9 / 2
07:00              3 / 1                3 / 3
08:00              1 / 1                0 / 0
09:00              2 / 2                0 / 0
10:00              1 / 1                0 / 0
11:00              3 / 1                0 / 0
13:00              1 / 1                0 / 0
14:00              2 / 1                0 / 0
15:00              6 / 2                6 / 1
16:00              1 / 1                0 / 0
17:00-02:00        0 / 0                0 / 0   (both zero)

raw events: TG 23, on-chain 23   |   sessions: TG 14, on-chain 8
```

## Finding

Both sources are active in the **03:00-16:00 UTC** band and drop to
**zero across the 17:00-02:00 UTC window** - a 10+ hour daily quiet
period that appears independently in the Telegram posts and the on-chain
deployer activity.

## A "good morning" greeting

On 2026-08-28 the channel posted a "good morning" greeting
(`t.me/cyberleeksreal/33`, archived: https://archive.ph/zkVZh):

![Telegram: "Good morning guys.. More leaks coming today"](tg-good-morning.png)

*Post /33: "Good morning guys.. More leaks coming today." The clock a Telegram
client shows is the viewer's own local time; the collector records the post's
UTC timestamp, which lands at the early edge of the active window.*

A "good morning" greeting is different from a bare timestamp: it is a semantic
self-report of local time of day. Taken at face value it aligns the operator's
local morning with the start of the active band (about 05:00-06:00 UTC), which
would point to roughly **UTC+1 to UTC+3** (Europe, West or East Africa, or the
Middle East) and is inconsistent with the Americas (that hour is the middle of
the night there) or East Asia (the afternoon). Treat this as a lead, not a
conclusion: a single greeting is weak, and could be performative, scheduled, or
written by one of several operators.


## What this is, and what it is not

This is a behavioral fingerprint: a repeatable active/quiet cycle that
shows up in two independent sources and can be used to correlate activity
between them.

On its own, the active/quiet cycle fixes **no** timezone and **no** location;
the "good morning" greeting above is the first semantic signal that points
toward one, but a single greeting does not establish it. The pattern does
**not** indicate whether one person or several are behind the operation. A quiet
window is not proof of sleep - scheduled posting, automation, shift work,
or multiple operators in different places would all produce the same
shape. The samples span 2026-08-25 through 08-28, still a short
window.
