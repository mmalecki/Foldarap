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

nema17_mount_plate([nema17_chamfer, nema17_chamfer, nema17_chamfer, 0]);
