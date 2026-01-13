// PARAMETERS:

// All distances are in inches.
//
corner_angle = 45;  // Degrees, angle of corner.

// PARAMETERS USUALLY NOT CHANGED:
//
// Stringers are 2x8's.  Sill is 6x6.
//
tread_width = 3*12;	// Tread width.
stringer_space = 27.5;	// Distance between stringer
			// centers.
stringer_gap = 0.5 + sin ( corner_angle/2 ) * 1.5;
			// Gap between stringers at
			// junction.
tapered_long = 4;	// Length long end of tapered
			// tread.
tapered_short = 1.5;	// Length short end of tapered
			// tread.
cantilever = 3.5;	// Length of tread end beyone
			// stringer.
stringer_long_length = 4*12; // Length longer stringer.
normal_gap = 0.5; // Gap between normal treads.


stringer_short_length =
      stringer_long_length
    - stringer_space * tan ( corner_angle / 2 );

tapered_long_width = tapered_long
              - (cantilever/tread_width)
	      * (tapered_long - tapered_short);
    // Width of tapered tread where it crosses long
    // stringer.

tapered_short_width = tapered_short
              + (cantilever/tread_width)
	      * (tapered_long - tapered_short);
    // Width of tapered tread where it crosses short
    // stringer.



echo ( "corner angle = ", corner_angle );

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

// Tread short and long lengths can be negated to
// flip tread across y axis.
//
module tread ( short_length = 5.5,
               long_length = 5.5 )
{
    color ("SandyBrown")
    translate ( [0,-cantilever,0] )
    linear_extrude ( 1.5 )
    {
	polygon ( [ [0,0],
	            [0,tread_width,],
		    [long_length,tread_width],
		    [short_length,0] ] );
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
	    translate ([stringer_gap/2,-1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,-stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_short_length
	                -stringer_gap/2,
	                -1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,-corner_angle/2])
	    translate ([stringer_gap/2,-1.5/2,-7.25])
		stringer ( stringer_long_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_long_length
	                -stringer_gap/2,
	                -1.5/2,-7.25])
		stringer ( stringer_long_length );

}

// side = -1 for left side, +1 for right side.
//
// short_length is distance from x= 0 along center of
// short stringer that next treads edge nearest
// x = 0 is to be placed.  Ditto long_length for
// long stringer.
//
gap = sin ( corner_angle/2 ) * (1.5/2);
module treads
	( side, short_length = gap, long_length = gap )
{
    short_x = side * short_length
                   * cos ( corner_angle/2 );
    short_y = - stringer_space/2
              - short_length * sin ( corner_angle/2 );
    long_x = side * long_length
                  * cos ( corner_angle/2 );
    long_y = + stringer_space/2
             - long_length * sin ( corner_angle/2 );

    tread_angle = atan2 ( long_y - short_y,
                          long_x - short_x )
		- 90;
	// If side == -1, tread_angle >= 0.

    echo ( "TREADS", side, short_length, long_length,
                     tread_angle );

    if ( corner_angle/2 + side * tread_angle >= 4 )
    {
        // Install tapered tread.

	translate ( [short_x, short_y, 0] )
	rotate ( [0, 0, tread_angle] )
	tread ( side * tapered_short, side * tapered_long );

	treads ( side,
	         short_length + tapered_short_width
		              + normal_gap,
	         long_length + tapered_long_width
		             + normal_gap );
    }
    else
    {
        target_long =
	       ceil (   ( long_length + 1e-3 )
	              / ( 5.5 + normal_gap ) )
	    * ( 5.5 + normal_gap );
	target_short = target_long
	             - stringer_space
		     * sin ( corner_angle/2 );
	x = side * target_short
                 * cos ( corner_angle/2 );
	y = - stringer_space/2
            - target_short * sin ( corner_angle/2 );

	if ( - side * tread_angle > 0.5 )
	{
	    long_1 = target_long - long_length
	                         - normal_gap;
	    short_1 = target_short - short_length
	                           - normal_gap;
	    assert ( short_1 <= long_1 + 1e-3 );
	    min_1 = min ( long_1, short_1 );
	    max_1 = max ( long_1, short_1 );
	    extra = ( min_1 >= 1.5 ? 0 :
	              max_1 <= 2.5 ? 3.0 :
		      1.5 - min_1 );
	    long = long_1 + extra;
	    short = short_1 + extra;
	    assert ( long_1 <= 5.5 + 1e-3 );
	    translate ( [x, y, 0] )
	    rotate ( - side * corner_angle/2 )
	    tread ( side * short, side * long );
	}
	else
	if ( target_length - long_length > 0.25 )
	{
	    long_1 = target_length - normal_gap;
	    long = ( long_1 >= 1.5 ? long_1 : 3.0 );

	    translate ( [x, y, 0] )
	    rotate ( - side * corner_angle/2 )
	    tread ( side * long, side * long );
	}
    }
}

sills();
stringers();
treads ( -1 );
