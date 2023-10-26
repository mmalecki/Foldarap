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
    c.faces(">Z[4]").tag("mate").end()
    return c


if 'show_object' in globals():
    # show_object(mgn12(300), name="mgn12_300")
    show_object(mgn12c(), name="mgn12c")
