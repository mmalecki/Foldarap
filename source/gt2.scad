use <catchnhole/catchnhole.scad>;
include <parameters-design-rules.scad>;
include <parameters-gt2.scad>;

module gt2_2d_tooth_clearance (fit = tight_fit) {
  tooth_base_to_back = gt2_t - gt2_tooth_h;
  // Putting the pitch line (below teeth) on Y = 0 (later Z = 0 when extruded)
  // will make the positioning easier, since we rely on pulley pitch diameter
  // data.
  fit_pld = -gt2_pld - (fit / 2);
  translate([0, fit_pld])
    square([gt2_pitch, tooth_base_to_back + fit / 2]);
  translate([0, gt2_t - gt2_tooth_h - gt2_pld])
    square([gt2_tooth_w, gt2_tooth_h]);

}
module gt2_2d_clearance (teeth, fit = tight_fit) {
  for (step = [0 : teeth - 1]) {
    translate([step * gt2_pitch, 0]) gt2_2d_tooth_clearance();
  }
}

module gt2_clearance (teeth, width = gt2_w, fit = tight_fit) {
  translate([0, 0, -(width + fit) / 2]) linear_extrude (width + fit)
    gt2_2d_clearance(teeth, fit);
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

function gt2_tensioner_clamp_size (teeth, width = gt2_w) = [
  width + belt_wall_t,
  gt2_t + nut_wall_d + belt_wall_t,
  gt2_pitch * gt2_clamp_min_teeth + belt_wall_t
];

module to_gt2_tensioner_clamp_bolt () {
  translate([-belt_wall_t / 2, 2 * belt_wall_t + gt2_t, 0]) children();
}
gt2_tensioner_clamp(6);
