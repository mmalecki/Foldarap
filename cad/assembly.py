import cadquery as cq
from vitamins.vslot import vslot
from settings import Settings

frameTopFront = vslot(Settings.xL)
frameTopBack = vslot(Settings.xL)
frameTopLeft = vslot(Settings.yL)
frameTopRight = vslot(Settings.yL)

assembly = (
    cq.Assembly()
        .add(frameTopFront, name="frameTopFront")
        .add(frameTopLeft, name="frameTopLeft")
        .add(frameTopRight, name="frameTopRight")
        .add(frameTopBack, name="frameTopBack")
        .constrain("frameTopFront", frameTopFront.faces(">Z").edges(">Y").val(), "frameTopLeft", frameTopLeft.faces(">Z").edges(">Y").val(), "Point")
        .constrain("frameTopFront", frameTopFront.faces("<Z").edges(">Y").val(), "frameTopRight", frameTopRight.faces(">Z").edges("<Y").val(), "Point")
        .constrain("frameTopFront@faces@>Y", "frameTopLeft@faces@>Z", "Axis")
        .constrain("frameTopFront@faces@>Y", "frameTopRight@faces@>Z", "Axis")

        .constrain("frameTopBack", frameTopBack.faces(">Z").edges("<Y").val(), "frameTopLeft", frameTopLeft.faces("<Z").edges(">Y").val(), "Point")
        .constrain("frameTopBack", frameTopBack.faces("<Z").edges("<Y").val(), "frameTopRight", frameTopRight.faces("<Z").edges("<Y").val(), "Point")
        .constrain("frameTopBack@faces@>Y", "frameTopLeft@faces@>Z", "Axis")
        .constrain("frameTopBack@faces@>Y", "frameTopRight@faces@>Z", "Axis")
)

assembly.solve()

if 'show_object' in globals():
    show_object(assembly, name = "theSwoon")
