use <../z-gantry-left.scad>;
use <z-axis.scad>;
include <../parameters.scad>;

// Where the gantry is.
z = 0;

module z_axis_left_assembly (z) {
  mirror([1, 0, 0])
    z_axis_assembly(z)
      z_gantry_left();
}

z_axis_left_assembly(z);
