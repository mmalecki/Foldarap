use <catchnhole/catchnhole.scad>;
include <parameters-design-rules.scad>;
include <parameters-nema17.scad>;

module nema17_mount_plate () {
  linear_extrude (stepper_mount_plate_t) nema17_mount_plate_2d();
}

module nema17_mount_plate_2d () {
  difference () {
     translate([-nema17_d / 2, -nema17_d / 2])
      square([nema17_d, nema17_d]);

    circle(d = nema17_shaft_plate_fit_d);
  }
}
