$fn = 50;

use <../catchnhole/catchnhole.scad>;
include <../parameters.scad>;

pen_max_d = 16.5;
standoff_d = 7;
h = 16;
carriage_bolts_top_offset = 5;

bolts_z = h - carriage_bolts_top_offset;
pen_bolts_z = h - 2 * carriage_bolts_top_offset;

pen_bolt = x_carriage_bolt;

t = 2.4;
w = x_carriage_bolt_s + 2 * standoff_d;
l = pen_max_d + 2 * t + nut_height(pen_bolt);

module carriage_mounts () {
  translate([x_carriage_bolt_s / 2, 0]) children();
  translate([-x_carriage_bolt_s / 2, 0]) children();
}

module carriage_bolts () {
  carriage_mounts() bolt(x_carriage_bolt, length = l);
}

module holder () {
  pen_center = (pen_max_d + 2 * t) / 2;
  difference () {
    cube([w, l, h]);
    translate([w / 2, pen_center]) cylinder(d = pen_max_d, h = h);

    translate([w - t, pen_center, pen_bolts_z]) rotate([0, 270, 0]) {
      nutcatch_sidecut(pen_bolt);
      bolt(pen_bolt, length = w);
    }

    translate([t, pen_center, pen_bolts_z]) rotate([180, 270, 0]) {
      nutcatch_sidecut(pen_bolt);
      bolt(pen_bolt, length = w);
    }

    translate([w / 2, l, bolts_z]) {
      rotate([90, 0, 0]) {
        carriage_bolts();
        bolt(pen_bolt, length = l);
      }

      translate([0, -t / 2, 0]) rotate([90, 270, 0]) {
        nutcatch_sidecut(pen_bolt);
      }
    }
  }
}

holder();
