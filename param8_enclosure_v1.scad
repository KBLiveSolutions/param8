// ============================================================
// param8 v4.2 — Sandwich Enclosure
// Split at PCB level: bottom=tray, top=cap with walls
// ============================================================

$fn = 60;

// --- PCB ---
pcb_w         = 198.0;
pcb_h         = 73.0;
pcb_thick     = 1.6;
pcb_corner_r  = 3.0;

// --- Enclosure ---
wall_thick     = 2.0;
wall_clearance = 0.8;      // gap PCB ↔ inner wall
plate_thick    = 2.0;
fillet_r       = 1.5;      // top edge fillet radius

// Derived inner/outer dims
inner_w  = pcb_w + wall_clearance * 2;
inner_h  = pcb_h + wall_clearance * 2;
inner_r  = pcb_corner_r + wall_clearance;
outer_w  = inner_w + wall_thick * 2;
outer_h  = inner_h + wall_thick * 2;
outer_r  = inner_r + wall_thick;

// Heights
standoff_h    = 3.0;       // PCB sits 3mm above bottom inner surface
clearance_top = 9.0;       // space above PCB top (incl. 2mm plexi)

// Bottom wall = standoff + PCB (up to PCB top)
bot_wall_h = standoff_h + pcb_thick;
// Top wall = clearance above PCB top
top_wall_h = clearance_top;

// Lip for alignment (top slides over bottom wall edge)
lip_h      = 1.5;
lip_inset  = 0.8;          // step width
lip_tol    = 0.35;         // tolerance on lip fit (XY)
lip_tol_z  = 0.5;          // tolerance on lip fit (Z)

// --- Hardware ---
m3_clear_d    = 3.6;
m3_head_d     = 6.0;
m3_head_depth = 2.0;
standoff_d    = 6.5;

// Self-tapping pilot hole (M3 screw into plastic)
pilot_d       = 2.2;       // pilot hole for M3 wood/self-tap screw
pilot_depth   = 7.0;       // depth into standoff
pilot_cbore_d = 4.0;       // counterbore for displaced material
pilot_cbore_h = 1.0;       // counterbore depth

// --- Mounting holes (board origin bottom-left, Y up) ---
mount_holes = [
    [3.50,  69.50],
    [194.50, 69.50],
    [3.56,  3.50],
    [194.50, 3.50]
];

// Board-to-enclosure offset
brd_ox = wall_thick + wall_clearance;
brd_oy = wall_thick + wall_clearance;

// --- Encoders ---
encoder_shaft_d     = 7.2;
encoder_body_d      = 13.0;
encoder_body_recess = 1.5;

encoders = [
    [50.17,  58.76],  [84.99,  59.01],
    [132.84, 59.01],  [167.01, 59.01],
    [50.16,  14.43],  [84.99,  14.43],
    [132.84, 14.43],  [167.01, 14.43]
];

// --- Displays ---
disp_active_w      = 69.0;
disp_active_h      = 17.5;
disp_chamfer_angle = 30;
disp_chamfer_depth = 2.0;
disp_bottom_ext    = 2.0;      // extend window 2mm down (black bezel area)

disp_centers = [
    [67.44,  39.39],
    [150.24, 39.39]
];

// --- Tactile switches (K6-6270S03: 9x8mm body, round cap) ---
tact_d = 10.5;             // round hole + clearance
tact_positions = [
    [16.51, 28.53],
    [16.51, 44.15]
];

// --- USB-C (top edge of board, on top side) ---
usbc_w        = 9.5;
usbc_h        = 1.8;
usbc_x        = 15.1;

usbc_corner_r = 1.0;

// Cable plug recess (thins the wall around the connector)
usbc_plug_w       = 13.0;
usbc_plug_h       = 7.0;
usbc_wall_remain  = 0.8;      // remaining wall thickness at recess

// ============================================================
// 2D Profiles
// ============================================================

module rounded_rect_2d(w, h, r) {
    offset(r = r)
        square([w - 2*r, h - 2*r]);
}

module outer_2d() {
    translate([outer_r, outer_r])
        rounded_rect_2d(outer_w, outer_h, outer_r);
}

module inner_2d() {
    translate([wall_thick + inner_r, wall_thick + inner_r])
        rounded_rect_2d(inner_w, inner_h, inner_r);
}

// Lip profiles (for alignment step between top and bottom)
module lip_outer_2d() {
    // Slightly inset from outer wall
    inset = lip_inset;
    translate([inset + (outer_r - inset), inset + (outer_r - inset)])
        rounded_rect_2d(outer_w - 2*inset, outer_h - 2*inset, outer_r - inset);
}

module lip_socket_2d() {
    // Same as lip_outer but with tolerance
    inset = lip_inset - lip_tol;
    translate([inset + (outer_r - inset), inset + (outer_r - inset)])
        rounded_rect_2d(outer_w - 2*inset, outer_h - 2*inset, outer_r - inset);
}

module pcb_2d() {
    translate([brd_ox + pcb_corner_r, brd_oy + pcb_corner_r])
        rounded_rect_2d(pcb_w, pcb_h, pcb_corner_r);
}

// ============================================================
// Display window with viewing chamfer
// ============================================================

module display_window() {
    ext_h = disp_active_h + disp_bottom_ext;

    // Straight cut through plate, shifted down by half the extension
    translate([0, -disp_bottom_ext/2, -0.1])
        linear_extrude(plate_thick + 0.2)
            square([disp_active_w, ext_h], center = true);

    // Chamfer on top surface
    expand = disp_chamfer_depth * tan(disp_chamfer_angle);
    translate([0, -disp_bottom_ext/2, plate_thick - disp_chamfer_depth])
        linear_extrude(disp_chamfer_depth + 0.1, scale = [
            (disp_active_w + 2*expand) / disp_active_w,
            (ext_h + 2*expand) / ext_h
        ])
            square([disp_active_w, ext_h], center = true);
}

// ============================================================
// USB-C notch (open U-shape at bottom of top wall)
// ============================================================

module usbc_notch_top() {
    notch_h = pcb_thick + usbc_h + 0.5;
    notch_depth = wall_thick + 2;
    cx = brd_ox + usbc_x;
    cy = outer_h - wall_thick - 1;
    r = usbc_corner_r;

    // Through-hole for the PCB connector
    translate([cx, cy + notch_depth/2, 0])
        rotate([90, 0, 0])
            translate([0, 0, -notch_depth/2])
                linear_extrude(notch_depth)
                    offset(r = r)
                        translate([-(usbc_w/2 - r), -0.1])
                            square([usbc_w - 2*r, notch_h - r]);

    // Outer recess for cable plug — thins wall to usbc_wall_remain
    recess_depth = wall_thick - usbc_wall_remain;
    translate([cx, outer_h - recess_depth, 0])
        rotate([90, 0, 0])
            translate([0, 0, -recess_depth])
                linear_extrude(recess_depth + 0.1)
                    offset(r = r)
                        translate([-(usbc_plug_w/2 - r), -0.1])
                            square([usbc_plug_w - 2*r, usbc_plug_h - r]);
}

// ============================================================
// BOTTOM PLATE
// ============================================================

module bottom_fillet_plate() {
    // Quarter-circle profile on bottom edges using hull slices
    fillet_steps = 8;
    for(i = [0 : fillet_steps - 1]) {
        a1 = 90 * i / fillet_steps;
        a2 = 90 * (i + 1) / fillet_steps;
        hull() {
            translate([0, 0, fillet_r * (1 - cos(a1))])
                linear_extrude(0.01)
                    offset(r = -fillet_r * (1 - sin(a1)))
                        outer_2d();
            translate([0, 0, fillet_r * (1 - cos(a2))])
                linear_extrude(0.01)
                    offset(r = -fillet_r * (1 - sin(a2)))
                        outer_2d();
        }
    }
    // Flat remainder above fillet
    translate([0, 0, fillet_r])
        linear_extrude(plate_thick - fillet_r)
            outer_2d();
}

module bottom_plate() {
    color("DimGray", 0.9)
    difference() {
        union() {
            bottom_fillet_plate();

            // Walls up to PCB top
            translate([0, 0, plate_thick])
                linear_extrude(bot_wall_h)
                    difference() {
                        outer_2d();
                        inner_2d();
                    }

            // Lip for top/bottom alignment
            translate([0, 0, plate_thick + bot_wall_h])
                linear_extrude(lip_h)
                    difference() {
                        lip_outer_2d();
                        inner_2d();
                    }

            // PCB standoffs
            for (h = mount_holes)
                translate([brd_ox + h[0], brd_oy + h[1], plate_thick])
                    cylinder(h = standoff_h, d = standoff_d);
        }

        // M3 through-holes + countersink
        for (h = mount_holes) {
            translate([brd_ox + h[0], brd_oy + h[1], -0.1])
                cylinder(h = plate_thick + standoff_h + 0.2, d = m3_clear_d);
            translate([brd_ox + h[0], brd_oy + h[1], -0.1])
                cylinder(h = m3_head_depth + 0.1, d = m3_head_d);
        }

        // USB-C cable plug recess on bottom wall
        usbc_recess_bottom();

        // Notch in lip at USB-C location (flat bottom at lip base, rounded top)
        translate([brd_ox + usbc_x, outer_h - wall_thick - 1 + (wall_thick + 2)/2, plate_thick + bot_wall_h])
            rotate([90, 0, 0])
                translate([0, 0, -(wall_thick + 2)/2])
                    linear_extrude(wall_thick + 2)
                        intersection() {
                            offset(r = usbc_corner_r)
                                translate([-(usbc_w/2 - usbc_corner_r), 0])
                                    square([usbc_w - 2*usbc_corner_r, lip_h + 0.2]);
                            translate([-usbc_w, -1])
                                square([usbc_w * 2, lip_h + 1]);
                        };
    }
}

module usbc_recess_bottom() {
    recess_depth = wall_thick - usbc_wall_remain;
    cx = brd_ox + usbc_x;
    r = usbc_corner_r;
    translate([cx, outer_h - recess_depth, plate_thick])
        rotate([90, 0, 0])
            translate([0, 0, -recess_depth])
                linear_extrude(recess_depth + 0.1)
                    offset(r = r)
                        translate([-(usbc_plug_w/2 - r), -0.1])
                            square([usbc_plug_w - 2*r, bot_wall_h + 0.2 - r]);
}

// ============================================================
// TOP PLATE (cap with walls going down)
// ============================================================

module top_fillet_plate() {
    // Flat base up to fillet zone
    linear_extrude(plate_thick - fillet_r)
        outer_2d();
    // Quarter-circle profile on top edges
    fillet_steps = 8;
    for(i = [0 : fillet_steps - 1]) {
        a1 = 90 * i / fillet_steps;
        a2 = 90 * (i + 1) / fillet_steps;
        hull() {
            translate([0, 0, plate_thick - fillet_r + fillet_r * sin(a1)])
                linear_extrude(0.01)
                    offset(r = -fillet_r * (1 - cos(a1)))
                        outer_2d();
            translate([0, 0, plate_thick - fillet_r + fillet_r * sin(a2)])
                linear_extrude(0.01)
                    offset(r = -fillet_r * (1 - cos(a2)))
                        outer_2d();
        }
    }
}

module top_plate() {
    // Top part origin at junction level (PCB top)
    junction_z = plate_thick + bot_wall_h;

    color("Silver", 0.85)
    translate([0, 0, junction_z])
    difference() {
        union() {
            // Walls going up from junction
            linear_extrude(top_wall_h)
                difference() {
                    outer_2d();
                    inner_2d();
                }

            // Lid plate with rounded top edges
            translate([0, 0, top_wall_h])
                top_fillet_plate();

            // Top standoffs (descend from lid to PCB top)
            for (h = mount_holes)
                translate([brd_ox + h[0], brd_oy + h[1], 0])
                    cylinder(h = top_wall_h, d = standoff_d);
        }

        // Socket for bottom lip (recess at bottom of top walls)
        translate([0, 0, -0.1])
            linear_extrude(lip_h + lip_tol_z + 0.1)
                difference() {
                    lip_socket_2d();
                    inner_2d();
                }

        // Pilot holes for M3 self-tapping (blind, from underside)
        for (h = mount_holes) {
            translate([brd_ox + h[0], brd_oy + h[1], -0.1])
                cylinder(h = pilot_depth + 0.1, d = pilot_d);
            // Counterbore for displaced material
            translate([brd_ox + h[0], brd_oy + h[1], -0.1])
                cylinder(h = pilot_cbore_h + 0.1, d = pilot_cbore_d);
        }

        // Encoder shaft holes (through lid) + body recess on underside
        for (pos = encoders) {
            translate([brd_ox + pos[0], brd_oy + pos[1], top_wall_h - 0.1])
                cylinder(h = plate_thick + 0.2, d = encoder_shaft_d);
            translate([brd_ox + pos[0], brd_oy + pos[1], top_wall_h - 0.1])
                cylinder(h = encoder_body_recess + 0.1, d = encoder_body_d);
        }

        // Display windows (in lid + fillet)
        for (dc = disp_centers)
            translate([brd_ox + dc[0], brd_oy + dc[1], top_wall_h])
                display_window();

        // Tactile switch holes (through lid)
        for (pos = tact_positions)
            translate([brd_ox + pos[0], brd_oy + pos[1], top_wall_h - 0.1])
                cylinder(h = plate_thick + 0.2, d = tact_d);

        // USB-C notch (open at bottom of top wall)
        usbc_notch_top();

        // Notch in lip socket at USB-C location (matches bottom lip notch)
        translate([brd_ox + usbc_x, outer_h - wall_thick - 1 + (wall_thick + 2)/2, 0])
            rotate([90, 0, 0])
                translate([0, 0, -(wall_thick + 2)/2])
                    linear_extrude(wall_thick + 2)
                        intersection() {
                            offset(r = usbc_corner_r)
                                translate([-(usbc_w/2 - usbc_corner_r), 0])
                                    square([usbc_w - 2*usbc_corner_r, lip_h + lip_tol_z + 0.2]);
                            translate([-usbc_w, -1])
                                square([usbc_w * 2, lip_h + lip_tol_z + 1]);
                        };

        // (logos and labels removed — too small to print legibly)
    }
}

// ============================================================
// Logo <3D + param8 (engraved on top plate)
// ============================================================

logo_engrave = 0.5;
logo_x = 15;
logo_y = 66;
logo_lw = 0.6;

module logo_chevron() {
    hull() {
        translate([-1.8, 0]) circle(d = logo_lw, $fn = 16);
        translate([0, 2.2]) circle(d = logo_lw, $fn = 16);
    }
    hull() {
        translate([-1.8, 0]) circle(d = logo_lw, $fn = 16);
        translate([0, -2.2]) circle(d = logo_lw, $fn = 16);
    }
}

module logo_b_no_bar() {
    r = 1.3;
    for (sy = [1, -1])
        translate([0, sy * r])
            difference() {
                circle(r = r, $fn = 32);
                circle(r = r - logo_lw, $fn = 32);
                translate([-(r+1), -(r+1)]) square([r+1, 2*(r+1)]);
            }
}

module logo_d_no_bar() {
    r = 2.2;
    difference() {
        circle(r = r, $fn = 40);
        circle(r = r - logo_lw, $fn = 40);
        translate([-(r+1), -(r+1)]) square([r+1, 2*(r+1)]);
    }
}

module logo_3d() {
    translate([-2.5, 0]) logo_chevron();
    translate([0.5, 0]) logo_b_no_bar();
    translate([3.5, 0]) logo_d_no_bar();
}

module logo_and_text() {
    translate([0, 2.5, 0])
        linear_extrude(logo_engrave + 0.1)
            logo_3d();
    translate([0, -2.5, 0])
        linear_extrude(logo_engrave + 0.1)
            text("param8", size = 2.2, halign = "center", valign = "center",
                 font = "Liberation Sans:style=Bold");
}

// ============================================================
// PCB + components (visualization)
// ============================================================

module pcb_visual() {
    pcb_z = plate_thick + standoff_h;

    color("ForestGreen", 0.5)
    translate([0, 0, pcb_z])
        linear_extrude(pcb_thick)
            pcb_2d();

    // Encoders
    color("DarkGray", 0.4)
    for (pos = encoders) {
        translate([brd_ox + pos[0], brd_oy + pos[1], pcb_z + pcb_thick]) {
            cylinder(h = 6.5, d = 12.4);
            translate([0, 0, 6.5])
                cylinder(h = 15, d = 6.0);
        }
    }

    // OLED modules
    color("MidnightBlue", 0.5)
    for (dc = disp_centers)
        translate([brd_ox + dc[0] - disp_active_w/2,
                   brd_oy + dc[1] - disp_active_h/2,
                   pcb_z + pcb_thick + 4.0])
            cube([disp_active_w, disp_active_h, 1.5]);

    // USB-C
    color("Silver", 0.6)
    translate([brd_ox + usbc_x - usbc_w/2,
               brd_oy + pcb_h - 4,
               pcb_z + pcb_thick])
        cube([usbc_w, 8, usbc_h]);
}

// ============================================================
// ASSEMBLY
// ============================================================

explode = 10;  // set to 0 for assembled view

bottom_plate();
pcb_visual();
translate([0, 0, explode]) top_plate();

// ============================================================
// PRINT EXPORT — uncomment ONE, then F6 + Export STL
// ============================================================

// Bottom (print as-is, lip facing up):
//!bottom_plate();

// Top (flip for printing, lid flat on bed):
 !rotate([180, 0, 0])
     translate([0, -outer_h, -(plate_thick + bot_wall_h + top_wall_h + plate_thick)])
         top_plate();
