from workplane import Workplane
from vitamins.mgn import mgn12cMount
from settings import Settings
from bed import bedMount

# Y carriage thickness
t = 4

def yCarriage():
    carriage = Workplane("front")
    carriage = carriage.rect(bedMount.x + Settings.boltWallD, bedMount.y + Settings.boltWallD).extrude(t)
    carriage.faces(">Z").workplane().tag("top")
    carriage.faces("<Z").tag("bottom")

    carriage = bedMount(carriage.workplaneFromTagged("top")).boltHole(Settings.bolt)

    i = 0
    for mp in carriage.faces("<Z").edges("%Circle").all():
        mp.tag(f"bedMount{i}")
        i = i + 1

    carriage = mgn12cMount(carriage.workplaneFromTagged("top"), "railCarriageMount").boltHole(Settings.bolt)
    return carriage

if 'show_object' in globals():
    show_object(yCarriage(), name="yCarriage")
