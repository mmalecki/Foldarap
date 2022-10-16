use <catchnhole/catchnhole.scad>;
include <parameters.scad>;

module x_carriage_mounts () {
  translate([-x_carriage_bolt_s / 2, 0])
    children();

  translate([x_carriage_bolt_s / 2, 0])
    children();
}

module x_carriage_bolts (length, kind = "socket_head", countersink = 0) {
  x_carriage_mounts() bolt(x_carriage_bolt, length, kind, countersink = countersink);
}
