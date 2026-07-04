#!/usr/bin/env python3
"""Generate kid-friendly military-adventure modpack icons as SVG + PNG."""
import math, os
import cairosvg

OUT = os.path.dirname(os.path.abspath(__file__))

# ---------- palette ----------
BG_LIGHT = "#4f9a5e"   # green radial center
BG_DARK  = "#245536"   # green radial edge
TAN      = "#e2c184"   # gear / khaki
TAN_HI   = "#f0d59c"   # gear highlight
OUTLINE  = "#3a2c15"   # dark brown outline
CREAM    = "#f6ecd2"   # medallion
GREEN    = "#3f7d4c"   # emblem green
GREEN_D  = "#2b5c37"
GOLD     = "#f4b731"   # accent gold
GOLD_D   = "#c8891c"

def pts(cx, cy, R, r, n, rot=-90):
    """star points, alternating outer/inner radius, n = number of points."""
    p = []
    for i in range(n*2):
        ang = math.radians(rot + i*180.0/n)
        rad = R if i % 2 == 0 else r
        p.append((cx + rad*math.cos(ang), cy + rad*math.sin(ang)))
    return " ".join(f"{x:.1f},{y:.1f}" for x,y in p)

def gear_teeth(cx, cy, Rb, n, w, h, rx):
    """rounded-rect teeth straddling body circle of radius Rb."""
    s = []
    for i in range(n):
        a = i*360.0/n
        s.append(
            f'<g transform="translate({cx},{cy}) rotate({a}) translate(0,{-Rb})">'
            f'<rect x="{-w/2}" y="{-h/2}" width="{w}" height="{h}" rx="{rx}" '
            f'fill="{TAN}" stroke="{OUTLINE}" stroke-width="9"/></g>'
        )
    return "\n".join(s)

def bg(defs_extra=""):
    return f'''<defs>
  <radialGradient id="bg" cx="50%" cy="42%" r="72%">
    <stop offset="0%" stop-color="{BG_LIGHT}"/>
    <stop offset="100%" stop-color="{BG_DARK}"/>
  </radialGradient>
  <linearGradient id="tan" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0%" stop-color="{TAN_HI}"/>
    <stop offset="100%" stop-color="{TAN}"/>
  </linearGradient>
  {defs_extra}
</defs>
<rect x="0" y="0" width="512" height="512" rx="96" fill="url(#bg)"/>'''

def wrap(body, defs_extra=""):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" '
            f'width="512" height="512">\n{bg(defs_extra)}\n{body}\n</svg>')

def save(name, svg):
    with open(os.path.join(OUT, name+".svg"), "w") as f:
        f.write(svg)
    cairosvg.svg2png(bytestring=svg.encode(), write_to=os.path.join(OUT, name+".png"),
                     output_width=512, output_height=512)
    print("wrote", name)

def medallion(cx, cy, Rb):
    teeth = gear_teeth(cx, cy, Rb, 12, 48, 62, 14)
    return f'''
{teeth}
<circle cx="{cx}" cy="{cy}" r="{Rb}" fill="url(#tan)" stroke="{OUTLINE}" stroke-width="10"/>
<circle cx="{cx}" cy="{cy}" r="118" fill="{CREAM}" stroke="{OUTLINE}" stroke-width="9"/>
<circle cx="{cx}" cy="{cy}" r="116" fill="none" stroke="{GOLD}" stroke-width="6" opacity="0.55"/>'''

# ============ Candidate 1: Cog + bold GOLD star (recommended) ============
def cand1():
    cx, cy = 256, 256
    star = pts(cx, cy-2, 116, 49, 5)
    body = medallion(cx, cy, 152) + f'''
<polygon points="{star}" fill="{GOLD}" stroke="{GOLD_D}" stroke-width="9" stroke-linejoin="round"/>
'''
    return wrap(body)

# ============ Candidate 2: Cog + gold star + one bold chevron ============
def cand2():
    cx, cy = 256, 256
    star = pts(cx, cy-34, 82, 35, 5)
    # single bold chevron (rank stripe) pointing up, near bottom of medallion
    thick, halfw, top, bot = 32, 86, 66, 108
    chevron = (f'<path d="M {cx-halfw} {cy+bot} L {cx} {cy+top} L {cx+halfw} {cy+bot} '
               f'L {cx+halfw-thick} {cy+bot} L {cx} {cy+top+thick*1.2} L {cx-halfw+thick} {cy+bot} Z" '
               f'fill="{GREEN}" stroke="{GREEN_D}" stroke-width="7" stroke-linejoin="round"/>')
    body = medallion(cx, cy, 152) + f'''
<polygon points="{star}" fill="{GOLD}" stroke="{GOLD_D}" stroke-width="8" stroke-linejoin="round"/>
{chevron}
'''
    return wrap(body)

# ============ Candidate 3: Cog + bold GREEN star (tactical alt) ============
def cand3():
    cx, cy = 256, 256
    star = pts(cx, cy-2, 116, 49, 5)
    body = medallion(cx, cy, 152) + f'''
<polygon points="{star}" fill="{GREEN}" stroke="{GREEN_D}" stroke-width="9" stroke-linejoin="round"/>
'''
    return wrap(body)

save("military-icon-1", cand1())
save("military-icon-2", cand2())
save("military-icon-3", cand3())
