from workplane import Workplane
from settings import Settings

def bedMount(plane, tag = None):
    return plane.pushPoints([
        (bedMount.x / 2, 0),
        (-bedMount.x / 2, -bedMount.y/ 2),
        (-bedMount.x / 2, bedMount.y / 2),
    ])

bedMount.x = Settings.bedX - 20
bedMount.y = 70

def bed():
    bed = Workplane("front")
    bed = bed.rect(Settings.bedX, Settings.bedY).extrude(Settings.bedT)
    bed = bedMount(bed.faces(">Z").workplane()).cskBoltHole(Settings.bolt)
    return bed

if 'show_object' in globals():
    show_object(bed(), name="bed")
