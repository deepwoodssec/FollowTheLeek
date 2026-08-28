# Posting pattern and activity times

When the operator is active on the official channels, measured from two
independent sources. Post and transaction times are facts you can
measure; the pattern they form is the finding.


![Daily activity window, UTC - Telegram and on-chain deployer sessions](activity-window.png)

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

22 Telegram posts + 23 on-chain deployer actions. All timestamps UTC.

![Operator activity by hour, UTC - Telegram and on-chain deployer activity](activity-by-hour.png)

```
hour          TG (raw/sessions)   on-chain (raw/sessions)
03:00              1 / 1                1 / 1
05:00              1 / 1                4 / 1
06:00              0 / 0                9 / 2
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

raw events: TG 22, on-chain 23   |   sessions: TG 13, on-chain 8
```

## Finding

Both sources are active in the **03:00-16:00 UTC** band and drop to
**zero across the 17:00-02:00 UTC window** - a 10+ hour daily quiet
period that appears independently in the Telegram posts and the on-chain
deployer activity.

## What this is, and what it is not

This is a behavioral fingerprint: a repeatable active/quiet cycle that
shows up in two independent sources and can be used to correlate activity
between them.

It establishes **no** timezone and **no** location, and it does **not**
indicate whether one person or several are behind the operation. A quiet
window is not proof of sleep - scheduled posting, automation, shift work,
or multiple operators in different places would all produce the same
shape. Both samples also cluster around 2026-08-25 to 08-26, a short
window.
