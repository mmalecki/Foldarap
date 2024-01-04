from cadquery import Workplane

NEMA17_D = 42.3
MOUNT_D = 31
ID = 22.5
BOLT_D = 3

def nema17Mount(plane, tag = None):
    mount = plane.rect(MOUNT_D, MOUNT_D, forConstruction = True).vertices()
    if tag is not None:
        mount.tag(tag)
    return mount

def nema17Mock (h = NEMA17_D):
    mock = Workplane("front").rect(NEMA17_D, NEMA17_D).extrude(h)

    mock = nema17Mount(mock.faces(">Z").workplane(), "mountPoints").hole(BOLT_D, depth=5)
    mock = mock.edges("|Z").chamfer(3)
    mock.faces(">Z").tag("mateMount")
    # Shaft plate
    mock = mock.faces(">Z").workplane().circle((ID - 0.5) / 2).extrude(3)
    # Shaft
    mock = mock.faces(">Z").workplane().circle(2.5).extrude(20)
    return mock

if 'show_object' in globals():
    mock = nema17Mock()
    show_object(mock, name="nema17Mock")
