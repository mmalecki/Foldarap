import cadquery as cq
from workplane import Workplane
from vitamins.vslot import vslot
from settings import Settings

def yIdler():
    idler = Workplane("front")
    w = Settings.yIdler.diameter + 2 * Settings.frameBoltWallD + 2 * Settings.looseFit
    h = 2 * Settings.stepperPlateT + Settings.yIdler.height + 2 * Settings.looseFit
    idler = idler.rect(h, w).extrude(Settings.stepperPlateT)

    idler.faces("<Z").tag("back").end()

    idler = idler.faces(">Z").workplane().rarray(1, w - Settings.frameBoltWallD, 1, 2).boltHole(Settings.frameBolt)

    prongH = Settings.yIdler.diameter + Settings.looseFit
    idler = idler.faces(">Z").workplane().rarray(h - Settings.stepperPlateT, 1, 2, 1).rect(Settings.stepperPlateT, prongH).extrude(prongH)

    # These selectors center locations appears undeterministic.
    idler = idler.faces(">X").workplane().center(0, prongH / 2).cboreBoltHole(Settings.bolt)
    idler = idler.faces("<X").workplane().center(0, 0).nutcatchParallel(Settings.bolt)

    return idler

if 'show_object' in globals():
    idler = yIdler()
    show_object(idler, name="yIdler")
