#!/usr/bin/env python3
# Regenerate the posting-pattern charts from the timestamp files.
import datetime
from datetime import timezone
from collections import Counter
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Patch

BG="#0b0e16"; TG="#b0c92c"; ON="#4a9eff"
TXT="#c9d1d9"; MUT="#8b98a5"; TITLE="#eef2f6"
GRID="#ffffff"

plt.rcParams.update({
    "font.family":"monospace","font.monospace":["DejaVu Sans Mono"],
    "figure.facecolor":BG,"axes.facecolor":BG,"savefig.facecolor":BG,
    "text.color":TXT,"axes.labelcolor":TXT,"xtick.color":TXT,"ytick.color":TXT,
})

def load(path):
    dts=[]
    for raw in open(path):
        s=raw.strip()
        if not s or s.startswith("#"): continue
        s2=s[:-1]+"+00:00" if s.endswith("Z") else s
        try: dt=datetime.datetime.fromisoformat(s2)
        except ValueError: continue
        if dt.tzinfo is None: dt=dt.replace(tzinfo=timezone.utc)
        dts.append(dt.astimezone(timezone.utc))
    dts.sort(); return dts

def hists(dts,gap=10):
    raw=Counter(d.hour for d in dts)
    sess=[]; prev=None
    for d in dts:
        if prev is None or (d-prev).total_seconds()>gap*60: sess.append(d)
        prev=d
    return raw, Counter(d.hour for d in sess), len(dts), len(sess)

tg=load("telegram-post-times.txt"); oc=load("deployer-onchain-times.txt")
tg_raw,tg_sess,tg_n,tg_s = hists(tg)
oc_raw,oc_sess,oc_n,oc_s = hists(oc)

def style_axes(ax, ymax):
    for sp in ("top","right"): ax.spines[sp].set_visible(False)
    for sp in ("left","bottom"): ax.spines[sp].set_color("#2a3242")
    ax.set_xlim(-0.6,23.6); ax.set_ylim(0,ymax)
    ax.set_xticks(range(0,24,3)); ax.set_xticklabels([f"{h:02d}" for h in range(0,24,3)],fontsize=12)
    ax.set_yticks(range(0,ymax+1)); ax.tick_params(length=0)
    ax.set_axisbelow(True); ax.grid(axis="y",color=GRID,alpha=0.06,linewidth=0.8)
    # quiet band 17:00-02:00
    for x0,x1 in [(-0.6,2.5),(16.5,23.6)]:
        ax.axvspan(x0,x1,color=GRID,alpha=0.030,zorder=0)

# ---------- chart 1: activity by hour (raw faint + sessions solid) ----------
fig,ax=plt.subplots(figsize=(10.4,4.2),dpi=200)
style_axes(ax,9)
w=0.40
for h in range(24):
    ax.bar(h-0.21, tg_raw.get(h,0), w, color=TG, alpha=0.30, zorder=3)
    ax.bar(h-0.21, tg_sess.get(h,0), w, color=TG, alpha=1.0, zorder=4)
    ax.bar(h+0.21, oc_raw.get(h,0), w, color=ON, alpha=0.30, zorder=3)
    ax.bar(h+0.21, oc_sess.get(h,0), w, color=ON, alpha=1.0, zorder=4)
fig.text(0.062,0.905,"Persona activity by hour ",fontsize=17,weight="bold",color=TITLE,ha="left")
fig.text(0.462,0.905,"(UTC)",fontsize=17,weight="bold",color=TG,ha="left")
# legend row
def legend_row(y):
    fig.text(0.062,y,"■",color=TG,fontsize=15,va="center")
    fig.text(0.085,y,"Telegram",color=TXT,fontsize=12.5,va="center")
    fig.text(0.205,y,"■",color=ON,fontsize=15,va="center")
    fig.text(0.228,y,"on-chain deployer",color=TXT,fontsize=12.5,va="center")
    return
legend_row(0.815)
fig.text(0.44,0.815,"solid = activity sessions · faint = raw events",color=MUT,fontsize=11.5,va="center")
fig.text(0.062,0.03,"rapid bursts collapsed into sessions (10-min gap) · shaded = quiet 17:00-02:00 UTC",color=MUT,fontsize=11)
fig.subplots_adjust(left=0.062,right=0.985,top=0.74,bottom=0.13)
fig.savefig("activity-by-hour.png"); plt.close(fig)

# ---------- chart 2: daily activity window (sessions only) ----------
fig,ax=plt.subplots(figsize=(10.4,3.6),dpi=200)
style_axes(ax,3)
for h in range(24):
    ax.bar(h-0.21, tg_sess.get(h,0), w, color=TG, zorder=4)
    ax.bar(h+0.21, oc_sess.get(h,0), w, color=ON, zorder=4)
fig.text(0.062,0.9,"Daily activity window ",fontsize=17,weight="bold",color=TITLE,ha="left")
fig.text(0.402,0.9,"(UTC)",fontsize=17,weight="bold",color=TG,ha="left")
fig.text(0.062,0.79,"■",color=TG,fontsize=15,va="center")
fig.text(0.085,0.79,f"Telegram (n={tg_s})",color=TXT,fontsize=12.5,va="center")
fig.text(0.245,0.79,"■",color=ON,fontsize=15,va="center")
fig.text(0.268,0.79,f"on-chain deployer (n={oc_s})",color=TXT,fontsize=12.5,va="center")
fig.text(0.062,0.035,"activity sessions · active 03:00-16:00 UTC · shaded = quiet 17:00-02:00 UTC (zero in both)",color=MUT,fontsize=11)
fig.subplots_adjust(left=0.062,right=0.985,top=0.70,bottom=0.15)
fig.savefig("activity-window.png"); plt.close(fig)

print(f"TG raw={tg_n} sessions={tg_s} | on-chain raw={oc_n} sessions={oc_s}")
print("hour  TGraw/sess  OCraw/sess")
for h in range(24):
    if tg_raw.get(h) or oc_raw.get(h):
        print(f" {h:02d}   {tg_raw.get(h,0)}/{tg_sess.get(h,0)}        {oc_raw.get(h,0)}/{oc_sess.get(h,0)}")
print("charts written")
