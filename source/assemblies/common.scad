use <../vitamins/v-slot.scad>;
include <../vitamins/gt2-parameters.scad>;

module v_slot_mockup (length) {
  color("silver") v_slot(length);
}

module belt_mockup (length) {
  for (side = [-1, 1]) {
    translate([0, side * gt2_16t_pulley_pitch_d / 2])
      color("black") cylinder(d = gt2_t, h = length);
  }
  color("gray") cylinder(d = 2, h = length);
}
