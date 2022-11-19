use <../catchnhole/catchnhole.scad>;
include <../parameters-design-rules.scad>;
include <gt2-parameters.scad>;

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

module gt2_belt_mockup (length) {
  for (side = [-1, 1]) {
    translate([0, side * gt2_16t_pulley_pitch_d / 2])
      color("SaddleBrown") translate([-gt2_w / 2, -gt2_t /2])
        cube([gt2_w, gt2_t, length]);
  }
  color("gray", 0.5) cylinder(d = 2, h = length);
}
