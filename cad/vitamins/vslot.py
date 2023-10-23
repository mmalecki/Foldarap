import os
from workplane import Workplane
import cadquery as cq

PROFILE = cq.importers.importDXF(os.path.join(os.path.dirname(__file__), "vslot-2020_1.dxf")).wires()
PROFILE_MOCK = Workplane("front").rect(20, 20)

def vslot(length, mock = True):
    return (PROFILE_MOCK if mock else PROFILE).toPending().extrude(length)

if 'show_object' in globals():
    show_object(vslot(100), name="vslot100")
