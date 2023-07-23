include <endstop-parameters.scad>;
include <../parameters-design-rules.scad>;

function endstop_holder_w () = endstop_w + endstop_wall_t * 2 + endstop_fit;
function endstop_holder_l () = endstop_l + endstop_wall_t * 2 + endstop_fit;
function endstop_holder_h () = endstop_h + endstop_wall_t;

module endstop_holder () {
  w = endstop_holder_w();
  l = endstop_holder_l();

  ridge_connector_offset = endstop_wall_t + endstop_connector_w;
  translate([0, -l / 2 + ridge_connector_offset]) {
    // Allow for the Duet 3 pin connector to pass through:
    translate([-w / 2 + endstop_wall_t, 0])
      cube([endstop_ridge, l - ridge_connector_offset , endstop_wall_t]);
    translate([w / 2 - endstop_wall_t - endstop_ridge, 0])
      cube([endstop_ridge, l - ridge_connector_offset, endstop_wall_t]);
  }

    linear_extrude (endstop_h + endstop_wall_t) {
      difference () {
        square([w, l], center = true);
        square([endstop_w + endstop_fit, endstop_l + endstop_fit], center = true);
      }
    }
}
