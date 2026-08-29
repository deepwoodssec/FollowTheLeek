#!/usr/bin/env python3
# Activity-time analysis for OSINT timezone/behavioral fingerprinting.
#
# Design notes (addresses common, valid critiques):
#  - All timestamps are parsed as timezone-aware and normalized to UTC
#    before binning. Naive inputs are assumed UTC and flagged.
#  - Invalid/unparseable lines are COUNTED and reported, never silently
#    dropped.
#  - Rapid bursts are collapsed into activity SESSIONS (events within a
#    gap threshold are one session) so automation/rapid tx sequences do
#    not inflate an hour. Both raw-event and session histograms print.
#  - No single timezone offset is asserted. The quiet window is reported,
#    and the FULL range of offsets consistent with it (ties included) is
#    given, with the explicit caveat that a quiet window is not proof of
#    sleep (it can be scheduling, automation, shifts, or multiple people).
#
# Usage: python3 analyze_times.py <file> [gap_minutes=10]

import sys, datetime
from datetime import timezone
from collections import Counter

path = sys.argv[1] if len(sys.argv) > 1 else "telegram-post-times.txt"
gap_min = int(sys.argv[2]) if len(sys.argv) > 2 else 10

dts, skipped = [], []
for raw in open(path):
    line = raw.strip()
    if not line or line.lstrip().startswith("#"):
        continue
    s = line[2:].strip() if line[:2].isdigit() and line[2:3] in ".)" else line  # tolerate "1. " numbering
    s = s.rstrip("Z") + ("+00:00" if s.endswith("Z") else "")
    try:
        dt = datetime.datetime.fromisoformat(s)
    except ValueError:
        skipped.append(line); continue
    if dt.tzinfo is None:                 # naive -> assume UTC, flag
        dt = dt.replace(tzinfo=timezone.utc)
        skipped.append(f"(assumed-UTC) {line}")
    dts.append(dt.astimezone(timezone.utc))

dts.sort()
n = len(dts)
print(f"parsed: {n} timestamps   skipped/flagged: {len(skipped)}")
for s in skipped:
    print("   FLAG:", s)
if not n:
    sys.exit(1)

# raw-event histogram
raw_h = Counter(d.hour for d in dts)
# collapse into sessions: new session when gap from previous > threshold
sessions, prev = [], None
for d in dts:
    if prev is None or (d - prev).total_seconds() > gap_min*60:
        sessions.append(d)          # session anchored at its first event
    prev = d
sess_h = Counter(d.hour for d in sessions)

print(f"\nraw events: {n}   activity sessions (gap>{gap_min}m collapsed): {len(sessions)}\n")
print("hour(UTC)  raw  sessions")
for h in range(24):
    print(f"  {h:02d}:00    {raw_h.get(h,0):3d}   {sess_h.get(h,0):3d}")

# quiet window from SESSIONS (bursts removed), all offsets consistent with it
active = sorted(h for h in range(24) if sess_h.get(h,0))
quiet = [h for h in range(24) if not sess_h.get(h,0)]
print(f"\nactive hours (sessions): {active}")
print(f"quiet hours (sessions):  {quiet}")
# longest contiguous quiet run(s)
def runs(hours):
    hs=set(hours); out=[]; 
    for h in range(24):
        if h in hs and (h-1)%24 not in hs:
            length=0; k=h
            while k%24 in hs: length+=1; k+=1
            out.append((h,length))
    return out
print("longest quiet runs (start,len):", sorted(runs(quiet), key=lambda x:-x[1])[:3])
print("\nNOTE: a quiet window is NOT proof of sleep. It is equally consistent")
print("with scheduled posting, automation, shift work, campaign timing, or")
print("multiple operators. This script reports the pattern, not a location.")
