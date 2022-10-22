include <parameters-v-slot.scad>;
include <parameters-design-rules.scad>;

module v_slot_2d (fit = 0) {
  d_fit = v_slot_d + fit;
  difference () {
    translate([-d_fit / 2, -d_fit / 2]) {
      square([d_fit, d_fit]);
    }

    circle(d = v_slot_center_hole_d);
  }
}

module v_slot (h, fit = 0) {
  linear_extrude (h) v_slot_2d();
}

module v_slot_clearance (h, fit = 0) {
  hull () v_slot(h, fit);
}
