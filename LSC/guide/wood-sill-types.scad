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
translate ([0,0]) single();
translate ([10,0]) single_plus_one();
translate ([20,0]) single_plus_two();

