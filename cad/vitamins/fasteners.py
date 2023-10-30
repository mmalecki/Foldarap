from workplane import Workplane

def standoff(od, id, h):
    return Workplane("front").circle(od / 2).circle(id / 2).extrude(h)
