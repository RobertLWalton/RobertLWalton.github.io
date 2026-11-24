// Use `Top View'.

// All distances are in inches.

// COMPONENTS:

module six_by_six()
{
    color ("LightGrey")
        cube ([5.5,5.5,3*12]);
}
module four_by_six()
{
    color ("LightGrey")
        cube ([5.5,3.5,3*12]);
}
module two_by_six()
{
    color ("LightGrey")
        cube ([5.5,1.5,3*12]);
}

// ASSEMBLIES:

module small_single()
{
    four_by_six();
}
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
    six_by_six();
    translate ([0, 5.5]) two_by_six();
    translate ([0, 7.0]) two_by_six();
}
module small_plus_two()
{
    four_by_six();
    translate ([0, 3.5]) two_by_six();
    translate ([0, 5.0]) two_by_six();
}
module double()
{
    six_by_six();
    translate ([0, 5.5]) six_by_six();
}
step = 8;
translate ([0*step,0]) small_single();
translate ([1*step,0]) single();
translate ([2*step,0]) small_plus_two();
translate ([3*step,0]) single_plus_one();
translate ([4*step,0]) single_plus_two();
translate ([5*step,0]) double();

