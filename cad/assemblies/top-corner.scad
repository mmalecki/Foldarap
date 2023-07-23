include <../parameters.scad>;
use <../top-corner.scad>;
use <../vitamins/nema17.scad>;
e = 0;
module top_corner_assembly(e = 0) {
  top_corner();
  top_corner_to_stepper_mount() {
    translate([ 0, 0, stepper_mount_plate_t ]) nema17_mockup(h = 40);
  }
}

top_corner_assembly(e);
