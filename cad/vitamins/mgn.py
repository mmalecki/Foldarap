import os
import cadquery as cq

_dir = os.path.dirname(__file__)
def _p(f):
    return os.path.join(_dir, f)

RAIL_MODELS = {
    "MGN12": {
        300: cq.importers.importStep(_p("MGNR12R300HM_FILE_1.stp")),
        "C": cq.importers.importStep(_p("MGN12CZ0HM_FILE_2.stp"))
    }
}

def mgn12(length):
    return RAIL_MODELS["MGN12"][length]

def mgn12c():
    c = RAIL_MODELS["MGN12"]["C"]
    c.faces(">Z[4]").tag("mateRail").end()
    # Hack to create a single unified face at the top of the carriage for mounting.
    c = (c.faces("<Z[1]").wires().toPending().extrude(0.25))
    c.faces("<Z[0]").tag("mateLoad").end()
    return c

def mgn12cMount(plane, tag = None):
    mount = plane.rect(20, 15, forConstruction = True)
    if tag is not None:
        mount.tag(tag)
    return mount.vertices()


if 'show_object' in globals():
    # show_object(mgn12(300), name="mgn12_300")
    c = mgn12c()
    show_object(c, name="mgn12c")
