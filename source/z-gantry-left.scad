use <v-slot.scad>;
use <top-corner.scad>;
use <gt2.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <parameters-gt2.scad>;
include <parameters-mgn12.scad>;

mgn = false;

h = max(2 * gt2_pitch * gt2_clamp_min_teeth + 2 * belt_wall_t, mgn ? mgn12_carriage_l : 0);
module z_gantry_left () {
}

z_gantry_left();
