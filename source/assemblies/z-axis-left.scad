include <../parameters.scad>;
use <../z-gantry-left.scad>;
use <z-axis.scad>;

// How much to explode the view.
e = 10;

// Where the gantry is.
z = 0;

module z_axis_left_assembly(e = 0, z = 0) {
  mirror([ 1, 0, 0 ]) z_axis_assembly(e, z) z_gantry_left();
}

z_axis_left_assembly(e, z);
