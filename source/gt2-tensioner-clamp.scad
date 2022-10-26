include <parameters.scad>;
use <vitamins/gt2.scad>;

function gt2_tensioner_clamp_size (teeth, width = gt2_w, tension_clearance = 0) = [
  width + belt_wall_t,
  gt2_t + nut_wall_d + belt_wall_t,
  gt2_pitch * teeth + belt_wall_t + tension_clearance
];

module to_gt2_tensioner_clamp_bolt () {
  translate([-belt_wall_t / 2, 2 * belt_wall_t + gt2_t, 0]) children();
}

module gt2_tensioner_clamp (teeth, width = gt2_w) {
  size = gt2_tensioner_clamp_size(teeth, width);
  w = size[0];
  l = size[1];
  h = size[2];
  difference () {
    translate([-width / 2 - belt_wall_t, -belt_wall_t - (gt2_t - gt2_pld)])
      cube([w, l, h]);

    rotate([0, 270, 180]) gt2_clearance(teeth);
    to_gt2_tensioner_clamp_bolt () {
      nutcatch_parallel(bolt, height_clearance = h - bolt_wall_h - nut_height(bolt));
      bolt(bolt, length = h);
    }
  }
}

gt2_tensioner_clamp(gt2_clamp_min_teeth);
