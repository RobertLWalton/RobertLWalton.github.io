// PARAMETERS:

// All distances are in inches.
//
corner_angle = 31;  // Degrees, angle of corner.
short_gap = 0.125;  // Space between tapered treads
		    // on the short stringers.
tread_angle = 4.0;  // Degrees, part of corner angle
		    // occupied by one tapered tread.

// PARAMETERS USUALLY NOT CHANGED:
//
// Stringers are 2x8's.  Sill is 6x6.
//
tread_width = 3*12;	// Tread width.
stringer_space = 27.5;	// Distance between stringer
			// centers.
tapered_long = 3;	// Length long end of tapered
			// tread.
tapered_short = 1.5;	// Length short end of tapered
			// tread.
cantilever = 3.5;	// Length of tread end beyone
			// stringer.
stringer_long_length = 4*12; // Length longer stringer.
normal_gap = 0.5 + 0.5/15; // Gap between normal treads.


stringer_short_length =
      stringer_long_length
    - stringer_space * tan ( corner_angle / 2 );
nt = floor ( corner_angle / tread_angle + 1e-6 );
number_tapered = nt - nt % 2;
excess_angle = corner_angle
             - tread_angle * number_tapered;

tapered_short_width = tapered_short
              + (cantilever/tread_width)
	      * (tapered_long - tapered_short);
    // Width of tapered tread where it crosses short
    // stringer.

echo ( "corner angle = ", corner_angle );
echo ( "tread angle = ", tread_angle );
echo ( "short gap = ", short_gap );
echo ( "number tapered = ", number_tapered );
echo ( "excess angle = ", excess_angle / 2 );

// z axis is vertical; x axis it along boardwalk;
// y axis is across boardwalk.
//
// Origin is center of sills top.  z == 0 is bottom of
// treads.

// COMPONENTS:

module sill()
{
    color ("LightGray")
	    cube ([5.5,tread_width,5.5]);
}
module stringer( length )
{
    color ("Chocolate")
        cube ([length,1.5,7.25]);
}

module tread ( short_length = 5.5,
               long_length = 5.5,
               extra_length = 0 )
{
    color ("SandyBrown")
    translate ( [0,-cantilever,0] )
    linear_extrude ( 1.5 )
    {
	polygon ( [ [-extra_length,0],
	            [-extra_length,tread_width,],
		    [long_length,tread_width],
		    [short_length,0] ] );
    }
}

// Computed so the line joining the halfway points of
// the long and short ends aligns with the y axis and
// has the origin that is cantilevel distant from short
// end of tread.
//
module tapered_tread()
{
    bisector_angle = atan2 ( (3.0-1.5)/2, tread_width);
    color ("SandyBrown")
    rotate ( [0,0,bisector_angle] )
    translate ( [-tapered_short_width/2,-cantilever,0] )
    linear_extrude ( 1.5 )
    {
	polygon ( [ [0,0], [0,tread_width,],
		    [tapered_long,tread_width],
		    [tapered_short,0] ] );
    }
}

// ASSEMBLIES:

module sills() {
    translate ([-5.5/2,-tread_width/2,-5.5-7.25])
	sill();
}
module stringers()
{

    translate([0,-stringer_space/2,0])
	rotate ([0,0,-corner_angle/2])
	    translate ([0.5,-1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,-stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_short_length-0.5,
	                -1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,-corner_angle/2])
	    translate ([0.5,-1.5/2,-7.25])
		stringer ( stringer_long_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_long_length-0.5,
	                -1.5/2,-7.25])
		stringer ( stringer_long_length );

}

module treads()
{
    excess_portion = excess_angle / tread_angle;
    corner_short_length = (tapered_short_width + short_gap)
			* (number_tapered + excess_portion)
			/ 2;
	// Length of short stringer covered by tapered
	// treads plus excess_portion.
    corner_long_length = corner_short_length
                       + stringer_space
		       * tan ( corner_angle/2 );
	// Length of long stringer covered by tapered
	// treads plus excess_portion.
    nn = ceil (   ( corner_long_length + 1e-6 )
		/ ( 5.5 + normal_gap ) );
    corner_normal_length =
        nn == 0 ? 0 :
	( 5.5 + normal_gap ) * nn - normal_gap;
    echo ( "corner_normal_length",
           corner_normal_length, nn );

    // Define a circle such that it is tangent to the
    // short stringers at the point corner_short_length
    // inches from the point where the midlines of the
    // two short stringers intersect.  The center of
    // this circle is on the y axis, and the tangent
    // points are at angles +- corner_angle/2 relative
    // to the center of the circle.
    //
    radius = corner_short_length
           / tan ( corner_angle/2 );
    center_y = - corner_short_length
               / sin ( corner_angle/2 )
             - stringer_space/2;
    for ( i = [0:number_tapered-1] )
    {
        da = - corner_angle/2 + excess_angle/2
	   + tread_angle/2 + i * tread_angle;
        r = radius
	  / cos ( corner_angle/2 - abs ( da ) );
        x = r * sin ( da );
	y = center_y + r * cos ( da );
	translate ( [x, y, 0] )
	    rotate ( [0,0,-da] )
	    tapered_tread();
    }



    if ( excess_angle > 0 )
    {
	excess_short_length =
	      radius * tan ( excess_angle/2 )
	    - short_gap/2;
	excess_long_length = excess_short_length
			   + stringer_space
			   * tan ( excess_angle/2 );
	excess_extra_length_1 =
	    corner_normal_length - corner_long_length;
	el_1 = excess_extra_length_1 +
	       excess_long_length;
	excess_extra_length_2 =
	      excess_extra_length_1
	    + ( el_1 < 1.5 ? 5.5 + normal_gap : 0 );
	el_2 = excess_extra_length_2 +
	       excess_long_length;
	        
	excess_extra_length =
	      excess_extra_length_2
	    + ( el_2 < 5.5 ? 0 : - 3.0 - normal_gap );
	excess_next_length = ( el_2 < 5.5 ? 0 : 3.0 );

	echo ( "ADDING EXTRA TREAD",
	       excess_extra_length,
	         excess_extra_length
	       + corner_long_length );
	x = radius * sin ( - corner_angle/2 );
	y = center_y
	  + radius * cos ( - corner_angle/2 );
	translate ( [x, y, 0] )
	rotate ( [0,0,corner_angle/2] )
	tread ( excess_short_length,
		excess_long_length,
		excess_extra_length );

	if ( excess_next_length > 0 && 1 == 0 )
	{
	    echo ( "ADDING NARROW TREAD",
	           excess_next_length );
	    len = excess_extra_length
	        + excess_next_length
		+ normal_gap;
	    dx = - len * cos ( corner_angle/2 );
	    dy = - len * sin ( corner_angle/2 );
	    translate ( [x+dx, y+dy, 0] )
	    rotate ( [0,0,corner_angle/2] )
	    tread ( excess_next_length,
	            excess_next_length,
		      excess_next_length + normal_gap
		    + excess_extra_length
		    + corner_long_length );
	}
    }
}

sills();
stringers();
treads();
