include <v-slot-parameters.scad>;
include <../parameters-design-rules.scad>;

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

module v_slot_2d_clearance (fit = 0) {
  hull () v_slot_2d(fit);
}

slider_w = (v_slot_d - v_slot_slot_outer_w) / 2;
// Add a taper to lessen ringing (maybe?).
slider_taper_w = 0.1 * slider_w;
module v_slot_2d_slider(original_fit) {
  slider_h = original_fit - v_slot_sliding_fit;
  for (side = [0 : 3]) {
    rotate([0, 0, side * 90]) {
      translate([v_slot_d / 2 + v_slot_sliding_fit, 0]) {
          for (part = [-1, 1]) {
          translate([0, part * v_slot_d / 3]) {
            polygon(points = [
              [0, -slider_w / 2 + slider_taper_w],
              [0, slider_w / 2 - slider_taper_w],
              [slider_h, slider_w / 2],
              [slider_h, -slider_w / 2],
            ]);
          }
        }
      }
    }
  }
}

module v_slot_2d_conduit (fit = 0, t = v_slot_wall_t) {
  channel_d = v_slot_d + v_slot_wall_t * 2;
  difference () {
    square([channel_d, channel_d], center = true);
    v_slot_2d_clearance();
  }
}

module v_slot_conduit (h, fit = 0, t = v_slot_wall_t) {
  linear_extrude (h) v_slot_2d_conduit(fit, t);
}
