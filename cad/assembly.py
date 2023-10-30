import cadquery as cq
from vitamins.vslot import vslot, joiningPlate2
from vitamins.mgn import mgn12, mgn12c
from settings import Settings
from y_carriage import yCarriage
from bed import bed, bedStandoff

frameTopFront = vslot(Settings.xL)
frameTopBack = vslot(Settings.xL)
frameTopLeft = vslot(Settings.yL)
frameTopRight = vslot(Settings.yL)

yAxisMountFront = joiningPlate2()
yAxisMountBack = joiningPlate2()

yAxisProfile = vslot(Settings.yL + 2 * vslot.d)
yAxisRail = mgn12(Settings.yL)
yAxisRailCarriage = mgn12c()

yCarriage_ = yCarriage()
bed = bed()

y = 0

assembly = (
    cq.Assembly()
        .add(frameTopFront, name="frameTopFront")
        .add(frameTopLeft, name="frameTopLeft")
        .add(frameTopRight, name="frameTopRight")
        .add(frameTopBack, name="frameTopBack")

        .add(yAxisProfile, name="yAxisProfile")
        .add(yAxisMountFront, name="yAxisMountFront")
        .add(yAxisMountBack, name="yAxisMountBack")
        .add(yAxisRail, name="yAxisRail")

        # Don't ask me why this works:
        .add(yAxisRailCarriage.translate((0, -y, 0)), name="yAxisRailCarriage")
        .add(yCarriage_.translate((0, y, 0)), name="yCarriage")

        .add(bedStandoff(), name="bedStandoff0")
        .add(bedStandoff(), name="bedStandoff1")
        .add(bedStandoff(), name="bedStandoff2")
        .add(bed.translate((0, -y, 0)), name="bed")

        .constrain("frameTopFront", frameTopFront.faces(">Z").edges(">Y").val(), "frameTopLeft", frameTopLeft.faces(">Z").edges(">Y").val(), "Point")
        .constrain("frameTopFront", frameTopFront.faces("<Z").edges(">Y").val(), "frameTopRight", frameTopRight.faces(">Z").edges("<Y").val(), "Point")
        .constrain("frameTopFront@faces@>Y", "frameTopLeft@faces@>Z", "Axis")
        .constrain("frameTopFront@faces@>Y", "frameTopRight@faces@>Z", "Axis")

        .constrain("frameTopBack", frameTopBack.faces(">Z").edges("<Y").val(), "frameTopLeft", frameTopLeft.faces("<Z").edges(">Y").val(), "Point")
        .constrain("frameTopBack@faces@>Y", "frameTopLeft@faces@>Z", "Axis")

        .constrain("yAxisProfile@faces@>Y", "frameTopFront@faces@<X", "Axis")

        # TODO: hand-wavy
        .constrain("frameTopFront", frameTopFront.faces("<Y").edges(">X").val(), "yAxisMountFront", yAxisMountFront.faces(">Y").edges(">X").val(), "Axis")
        .constrain("frameTopFront", frameTopFront.faces("<Y").val(), "yAxisMountFront", yAxisMountFront.edges("%Circle").all()[1].val(), "Plane")
        .constrain("yAxisProfile", yAxisProfile.faces(">Z").val(), "yAxisMountFront", yAxisMountFront.edges("%Circle").all()[3].val(), "Plane")

        # TODO: this one works very well, but somehow doesn't translate cleanly to ^
        .constrain("frameTopBack", frameTopBack.faces(">Y").edges(">X").val(), "yAxisMountBack", yAxisMountBack.faces(tag="mate1").edges(">X").val(), "Plane")
        .constrain("yAxisProfile", yAxisProfile.faces("<Z").edges("<Y").val(), "yAxisMountBack", yAxisMountBack.faces(tag="mate1").edges("<X").val(), "Point")

        .constrain("yAxisRail@faces@<Z", "yAxisProfile@faces@>Y", "Plane")
        .constrain("yAxisRail@faces@<Y", "yAxisProfile@faces@>Z", "Axis")

        .constrain("yAxisRail@faces@>Z", "yAxisRailCarriage?mateRail", "Plane")
        .constrain("yAxisRailCarriage@faces@>X", "yAxisProfile@faces@>X", "Axis")

        .constrain("yCarriage@faces@>X", "yAxisProfile@faces@>X", "Axis")
        .constrain("yCarriage@faces@>Z", "yAxisRailCarriage@faces@>Z", "Axis")
        .constrain("yCarriage?railCarriageMount", "yAxisRailCarriage?mateLoad", "Point")

        .constrain("bed?mount0", "bedStandoff1@faces@>Z", "Plane")
        .constrain("bed?mount1", "bedStandoff0@faces@>Z", "Plane")
        .constrain("bed?mount2", "bedStandoff2@faces@>Z", "Plane")

        .constrain("bedStandoff0@faces@<Z", "yCarriage?bedMount0", "Plane")
        .constrain("bedStandoff1@faces@<Z", "yCarriage?bedMount1", "Plane")
        .constrain("bedStandoff2@faces@<Z", "yCarriage?bedMount2", "Point")
)



assembly.solve()

if 'show_object' in globals():
    show_object(assembly, name = "theSwoon")
