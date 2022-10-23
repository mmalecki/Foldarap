use <v-slot.scad>;
include <parameters.scad>;
include <parameters.scad>;

h = 10;
module z_gantry_left () {
  slider_d = v_slot_d + 2 * v_slot_wall_t;
  linear_extrude (h) {
    difference () {
      translate([-slider_d / 2, -slider_d / 2])
        square([slider_d, slider_d]);

      v_slot_2d_clearance(loose_fit);
    }

    v_slot_2d_slider();
  }
}

z_gantry_left();
