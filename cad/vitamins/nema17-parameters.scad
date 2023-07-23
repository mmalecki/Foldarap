include <../parameters-design-rules.scad>;

nema17_d = 42.3;
nema17_bolt_s = 31;
nema17_shaft_d = 5;
nema17_shaft_l = 20;
nema17_shaft_plate_h = 3;
nema17_shaft_plate_d = 22;
nema17_shaft_plate_fit_d = nema17_shaft_plate_d + loose_fit;
nema17_chamfer = (nema17_d - nema17_bolt_s) / 2;
