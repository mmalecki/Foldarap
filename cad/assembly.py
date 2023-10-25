import cadquery as cq
from vitamins.vslot import vslot, joiningPlate2
from settings import Settings

frameTopFront = vslot(Settings.xL)
frameTopBack = vslot(Settings.xL)
frameTopLeft = vslot(Settings.yL)
frameTopRight = vslot(Settings.yL)

yAxisMountFront = joiningPlate2()

yAxisProfile = vslot(Settings.yL + 2 * vslot.d)

assembly = (
    cq.Assembly()
        .add(frameTopFront, name="frameTopFront")
        .add(frameTopLeft, name="frameTopLeft")
        .add(frameTopRight, name="frameTopRight")
        .add(frameTopBack, name="frameTopBack")

        .add(yAxisProfile, name="yAxisProfile")
        .add(yAxisMountFront, name="yAxisMountFront")

        .constrain("frameTopFront", frameTopFront.faces(">Z").edges(">Y").val(), "frameTopLeft", frameTopLeft.faces(">Z").edges(">Y").val(), "Point")
        .constrain("frameTopFront", frameTopFront.faces("<Z").edges(">Y").val(), "frameTopRight", frameTopRight.faces(">Z").edges("<Y").val(), "Point")
        .constrain("frameTopFront@faces@>Y", "frameTopLeft@faces@>Z", "Axis")
        .constrain("frameTopFront@faces@>Y", "frameTopRight@faces@>Z", "Axis")

        .constrain("frameTopBack", frameTopBack.faces(">Z").edges("<Y").val(), "frameTopLeft", frameTopLeft.faces("<Z").edges(">Y").val(), "Point")
        .constrain("frameTopBack", frameTopBack.faces("<Z").edges("<Y").val(), "frameTopRight", frameTopRight.faces("<Z").edges("<Y").val(), "Point")
        .constrain("frameTopBack@faces@>Y", "frameTopLeft@faces@>Z", "Axis")
        .constrain("frameTopBack@faces@>Y", "frameTopRight@faces@>Z", "Axis")

        .constrain("frameTopFront", frameTopFront.faces("<Y").edges(">X").val(), "yAxisMountFront", yAxisMountFront.faces(">Y").edges(">X").val(), "Axis")
        .constrain("frameTopFront", frameTopFront.faces("<Y").val(), "yAxisMountFront", yAxisMountFront.edges("%Circle").all()[1].val(), "Plane")
        .constrain("yAxisProfile", yAxisProfile.faces(">Z").val(), "yAxisMountFront", yAxisMountFront.edges("%Circle").all()[3].val(), "Plane")
        .constrain("yAxisProfile@faces@>Y", "frameTopFront@faces@<X", "Axis")
)



assembly.solve()

if 'show_object' in globals():
    show_object(assembly, name = "theSwoon")
