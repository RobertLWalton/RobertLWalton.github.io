// FUNCTIONS:

function hypotenuse(x,y) = sqrt ( x*x + y*y );

// PARAMETERS:

// All distances are in inches.
//
tread_width = 3*12;
    // Tread width.
backwall_width = 4 * 12;
    // Width of backwall.       
length = 12*8;
    // Length of section including bearing.
bearing = 1.5;
    // Section end berring.
number_of_treads = length/6;
    // 6 inches per tread.
stretch = 2.0/(number_of_treads - 1);
    // Amount that each 1/2 inch gap must be
    // stretched to accommodate backwall and
    // extra 1/2 inch.
section_length = length + 1.5;
    // Total length of section including one backwall.

// Stringers are 2x8's.  Sill is 6x6.

// COMPONENTS:

module tread()
{
    color ("SandyBrown")
        cube ([5.5,tread_width,1.5]);
}
module stringer()
{
    color ("Chocolate")
        cube ([length,1.5,7.25]);
}
module block()
{
    color ("Salmon")
        cube ([1.5,tread_width - 2*3.5 - 2*1.5,7.25]);
}
module backwall()
{
    color ("LightGray")
        cube ([1.5,backwall_width,7.25]);
}
module sill()
{
    color ("LightGray")
        cube ([5.5,tread_width,5.5]);
}

// ASSEMBLIES:

module treads()
{
    for (dx = [0:6+stretch:section_length]) {
        translate ([dx + 5.5 - bearing,0,0]) tread();
    }
}
module stringers()
{
    for (dy = [3.5,tread_width - 3.5 - 1.5]) {
        translate ([5.5 - bearing,dy,-7.25]) stringer();
    }
}
module blocks()
{
    for (dx = [length/3, length - length/3 - 1.5]) {
        translate ([5.5 - bearing + dx,3.5 + 1.5,-7.25])
	block();
    }
}
module backwalls()
{
    overhang = (backwall_width - tread_width)/2;
    translate ([5.5 - bearing + length,-overhang,-7.25])
	backwall();
}        
module sills() {
    translate ([0,0,-7.25 - 5.5]) sill();
}

treads();
stringers();
blocks();
backwalls();
sills();
