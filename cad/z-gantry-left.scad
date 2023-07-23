include <parameters.scad>;
include <vitamins/endstop-parameters.scad>;
include <vitamins/gt2-parameters.scad>;
include <vitamins/nema17-parameters.scad>;
use <catchnhole/catchnhole.scad>;
use <top-corner.scad>;
use <vitamins/endstop.scad>;
use <vitamins/gt2.scad>;
use <vitamins/v-slot.scad>;
use <z-gantry.scad>;

// This still needs to be mirrored. Do that for part preview, but leave the module
// as is for the gantry assembly to be rotated as a whole.
module z_gantry_left() {
  z_gantry_common();
  h = z_gantry_h();

  translate([
    v_slot_d / 2 + frame_z_x_offset - z_gantry_x_fit() - endstop_holder_h() +
      frame_bolt_wall_d,
    v_slot_d / 2 + v_slot_wall_t + endstop_holder_w() / 2 - endstop_wall_t,
    h - endstop_holder_l() / 2
  ]) rotate([ 90, 0, 90 ]) endstop_holder();
}

mirror([ 1, 0, 0 ]) z_gantry_left();
