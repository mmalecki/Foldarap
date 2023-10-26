import os
import cadquery as cq

PROFILE = cq.importers.importDXF(os.path.join(os.path.dirname(__file__), "vslot-2020_1.dxf")).wires()
VSLOT_D = 20
PROFILE_MOCK = cq.Workplane("front").rect(VSLOT_D, VSLOT_D)

def vslot(length, mock = True):
    return (PROFILE_MOCK if mock else PROFILE).toPending().extrude(length)

vslot.d = VSLOT_D

def joiningPlate2():
    plate = cq.importers.importStep(os.path.join(os.path.dirname(__file__), "Joining Strip Plate 2 Hole.step"))
    plate.faces(">Y").tag("mate0").end()
    plate.faces("<Y").tag("mate1").end()
    # debug(plate.faces(tag="mate0").edges(">X"))
    return plate

if 'show_object' in globals():
    show_object(vslot(100), name="vslot100")
    show_object(joiningPlate2().translate((VSLOT_D * 2, 0, 0)), name="joiningPlate2")
