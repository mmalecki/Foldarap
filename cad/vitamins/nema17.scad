use <../catchnhole/catchnhole.scad>;
include <../parameters-design-rules.scad>;
include <nema17-parameters.scad>;

module nema17_mount_plate (chamfer = nema17_chamfer) {
  linear_extrude (stepper_mount_plate_t) nema17_mount_plate_2d(chamfer);
}

module nema17_mount_plate_2d (chamfer = nema17_chamfer) {
  chamfer_corners = is_list(chamfer) ? chamfer : [chamfer, chamfer, chamfer, chamfer];
  difference () {
    translate([-nema17_d / 2, -nema17_d / 2])
      polygon([
        [0, chamfer_corners[2]],
        [0, nema17_d - chamfer_corners[1]],
        [chamfer_corners[1], nema17_d],
        [nema17_d - chamfer_corners[0], nema17_d],
        [nema17_d, nema17_d - chamfer_corners[0]],
        [nema17_d, chamfer_corners[3]],
        [nema17_d - chamfer_corners[3], 0],
        [chamfer_corners[2], 0],
      ]);

    circle(d = nema17_shaft_plate_fit_d);
  }
}

module nema17_mounts () {
  rotate([180, 0, 0]) {
    if ($children == 1) {
        translate([-nema17_bolt_s / 2, -nema17_bolt_s / 2])
          children();

        translate([-nema17_bolt_s / 2, nema17_bolt_s / 2])
          children();

        translate([nema17_bolt_s / 2, nema17_bolt_s / 2])
          children();

        translate([nema17_bolt_s / 2, -nema17_bolt_s / 2])
          children();
    }
    else if ($children == 4) {
      translate([nema17_bolt_s / 2, -nema17_bolt_s / 2])
        children(0);

      translate([-nema17_bolt_s / 2, -nema17_bolt_s / 2])
        children(1);

      translate([-nema17_bolt_s / 2, nema17_bolt_s / 2])
        children(2);

      translate([nema17_bolt_s / 2, nema17_bolt_s / 2])
        children(3);
    }
    else {
      // Never rotated an assertion before, but whatever.
      assert(false, "only 1 or 4 children are accepted by `nema17_mounts()`");
    }
  }
}

module nema17_mockup (h) {
  third = h / 3;
  color("silver") {
    translate([0, 0, -nema17_shaft_plate_h])
      cylinder(d = nema17_shaft_plate_d, h = nema17_shaft_plate_h + h);

    translate([0, 0, -nema17_shaft_l])
      cylinder(d = nema17_shaft_d, h = nema17_shaft_l);

    linear_extrude (third)
      nema17_mount_plate_2d();
  }

  translate([0, 0, third]) {
    color("black") {
      linear_extrude (third)
        offset(delta = -1, chamfer = true) nema17_mount_plate_2d();
    }
  }

  translate([0, 0, 2 * third]) {
    color("silver") {
      linear_extrude (third)
        nema17_mount_plate_2d();
    }
  }
}



nema17_mockup(40);

translate([0, 0, 40])
  nema17_mount_plate([nema17_chamfer, nema17_chamfer, nema17_chamfer, 0]);
