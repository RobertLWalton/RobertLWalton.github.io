// Use `Top View'.

// All distances are in inches.
//
sill_width = 5.5;
    // Sill top and bottom width.

// COMPONENTS:

module six_by_six()
{
    color ("LightGrey")
        cube ([sill_width,5.5,3*12]);
}
module four_by_four()
{
    color ("LightGrey")
        cube ([3.5,3.5,3*12]);
}
module two_by_six()
{
    color ("LightGrey")
        cube ([sill_width,1.5,3*12]);
}

// ASSEMBLIES:

module single()
{
    six_by_six();
}
module single_plus_one()
{
    six_by_six();
    translate ([0, 5.5]) two_by_six();
}
module single_plus_two()
{
    two_by_six();
    translate ([0, 1.5]) six_by_six();
    translate ([0, 7.0]) two_by_six();
}
module small_plus_two()
{
    two_by_six();
    translate ([1.0, 1.5]) four_by_four();
    translate ([0, 5.0]) two_by_six();
}
module double()
{
    six_by_six();
    translate ([0, 5.5]) six_by_six();
}
translate ([0,0]) single();
translate ([10,0]) small_plus_two();
translate ([20,0]) single_plus_one();
translate ([30,0]) single_plus_two();
translate ([40,0]) double();

