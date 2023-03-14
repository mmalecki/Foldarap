include <mgn12-parameters.scad>;
use <../catchnhole/catchnhole.scad>;

module mgn12c () {
  translate([ -mgn12c_w / 2, -mgn12c_l / 2 ]) {
    difference() {
      cube([ mgn12c_w, mgn12c_l, mgn12c_h ]);
      mgn12c_bolts(mgn12c_h);
    }
  }
}

module mgn12c_bolts (length) {
  mgn12c_mounts() bolt(mgn12c_bolt, length);
}

module mgn12c_mounts () {
  translate([ -mgn12c_bolt_w_s / 2, -mgn12c_bolt_l_s / 2 ]) children();

  translate([ mgn12c_bolt_w_s / 2, -mgn12c_bolt_l_s / 2 ]) children();

  translate([ mgn12c_bolt_w_s / 2, mgn12c_bolt_l_s / 2 ]) children();

  translate([ -mgn12c_bolt_w_s / 2, mgn12c_bolt_l_s / 2 ]) children();
}

module mgn12_2d () {
  translate([ -mgn12_w / 2, 0 ]) square([ mgn12_w, mgn12_h ]);
}

module mgn12 (l) {
  linear_extrude(l) mgn12_2d();
}

module mgn12_mockup (l) {
  color("gray") mgn12(l);
}

module mgn12_to_carriage () {
  translate([ 0, 0, mgn12c_rail_z_offset ]) children();
}

mgn12(100);
mgn12_to_carriage() mgn12c();
