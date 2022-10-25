use <v-slot.scad>;
use <top-corner.scad>;
use <gt2.scad>;
use <z-gantry.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <parameters-gt2.scad>;
include <parameters-mgn12.scad>;

module z_gantry_right () {
  z_gantry_common();
}

z_gantry_right();
