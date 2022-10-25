use <vitamins/v-slot.scad>;
use <top-corner.scad>;
use <vitamins/gt2.scad>;
use <z-gantry.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <vitamins/gt2-parameters.scad>;
include <vitamins/mgn12-parameters.scad>;

module z_gantry_left () {
  z_gantry_common();
}

z_gantry_left();
