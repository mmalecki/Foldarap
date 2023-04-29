include <../parameters-design-rules.scad>;
include <v-slot-parameters.scad>;

module v_slot_2d (fit = 0) {
  d_fit = v_slot_d + fit;
  difference() {
    square([ d_fit, d_fit ], center = true);

    for (spot = [0:3]) {
      rotate([ 0, 0, spot * 90 ]) {
        translate([ 0, d_fit / 2 - v_slot_slot_h ]) {
          for (copy = [ 0, 1 ]) {
            mirror([ copy, 0, 0 ]) {
              polygon([
                [ -v_slot_slot_outer_w / 2, v_slot_slot_h ],
                [ -v_slot_slot_inner_w / 2, v_slot_slot_h - v_slot_outer_wall_t ],
                [ -v_slot_slot_inner_w / 2, 0 ],
                [ 0, 0 ],
                [ 0, v_slot_slot_h ],
              ]);
            }
          }
        }
      }
    }

    circle(d = v_slot_center_hole_d);
  }
}

module v_slot (h, fit = 0) {
  linear_extrude(h) v_slot_2d(fit);
}

module v_slot_clearance (h, fit = 0) {
  hull() v_slot(h, fit);
}

module v_slot_2d_clearance (fit = 0) {
  hull() v_slot_2d(fit);
}

module v_slot_2d_conduit (fit = 0, t = v_slot_wall_t) {
  channel_d = v_slot_d + v_slot_wall_t * 2;
  difference() {
    square([ channel_d, channel_d ], center = true);
    v_slot_2d_clearance();
  }
}

module v_slot_conduit (h, fit = 0, t = v_slot_wall_t) {
  linear_extrude(h) v_slot_2d_conduit(fit, t);
}

module v_slot_mockup (length) {
  color("silver") v_slot(length);
}
