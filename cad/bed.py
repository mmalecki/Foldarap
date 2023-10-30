from workplane import Workplane
from settings import Settings
from vitamins.fasteners import standoff

def bedMount(plane):
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

    i = 0
    for mp in bed.faces("<Z").edges("%Circle").all():
        mp.tag(f"mount{i}")
        i = i + 1
               
    return bed

def bedStandoff():
    return standoff(6.2, 3, 6)

if 'show_object' in globals():
    show_object(bed(), name="bed")
