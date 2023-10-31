from workplane import Workplane
from settings import Settings
from vitamins.vslot import vslot
from vitamins.nema17 import nema17Mount

d = 42
id = 22.5

def yStepperMount():
    mount = Workplane("front")
    mount = mount.rect(vslot.d, yStepperMount.w).extrude(Settings.stepperPlateT)
    mount = mount.faces(">Z").workplane().pushPoints([
        (0, -d / 2 - Settings.frameBoltWallD / 2),
        (0, d / 2 + Settings.frameBoltWallD / 2)
    ]).boltHole(Settings.frameBolt)
    mount = mount.center(vslot.d / 2 - Settings.stepperPlateT / 2, 0).rect(Settings.stepperPlateT, d).extrude(d)

    mount.faces(">X[1]").tag("mateStepper").workplane(centerOption="CenterOfBoundBox").tag("stepper")
    mount = mount.workplaneFromTagged("stepper").hole(id)
    mount = nema17Mount(mount.workplaneFromTagged("stepper"), "stepperMountPoints").boltHole(Settings.bolt)

    mount.faces("<Z").tag("mateFrame").end()

    mount = mount.faces(">Z").edges("#Y").chamfer(3)

    return mount

yStepperMount.w = Settings.frameBoltWallD * 2 + d

if 'show_object' in globals():
    mount = yStepperMount()
    show_object(mount, name="yStepperMount")
