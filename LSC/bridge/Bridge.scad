// All distances are in inches.
//
tread_width = 4*12;
    // Tread width.
backwall_width = 5 * 12;
    // Width of backwall.       
span = 12*10;
    // Bridge span.
bearing = 1*12;
    // Bridge end bearing.
number_of_treads = (span+2*bearing)/6;
    // 6 inches per tread.
stretch = 3.5/(number_of_treads - 1);
    // Amount that each 1/2 inch gap must be
    // stretched to accommodate backwall and
    // extra 1/2 inch.
bridge_length = span + 2*bearing + 2*1.5;
    // Total length of bridge.
        
height = 40.5;
    // Height of outside of post above top of tread.
slant = 0.75;
    // Differnce in height of outside and inside
    // of post.
post_gap = 3 * 12;
    // Distance between post centers.
number_of_posts =
    floor ( span / post_gap ) + 1;

module tread()
{
    color ("SandyBrown")
        cube ([5.5,tread_width,1.5]);
}
module stringer()
{
    color ("Chocolate")
        cube ([span+2*bearing,1.5,9.25]);
}
module backwall()
{
    color ("LightGray")
        cube ([1.5,backwall_width,9.25]);
}
module post()
{
    color ("tomato")
        cube ([3.5,3.5,height+9.25+1.5]);
}
module cap()
{
    color ("blue")
        cube ([span,5.5,1.0]);
}
module treads()
{
    for (dx = [0:6+stretch:bridge_length]) {
        translate ([dx,0,0]) tread();
    }
}
module stringers()
{
    half = tread_width/2;
    for (dy = [0,1.5,half-1.5,half,
                 tread_width-2*1.5,
                 tread_width-1.5]) {
        translate ([1.5,dy,-9.25]) stringer();
    }
}
module backwalls()
{
    overhang = (backwall_width - tread_width)/2;
    for (dx = [0,span+2*bearing+1.5]) {
        translate ([dx,-overhang,-9.25])
            backwall();
    }
}        
module posts() {
    post_length = (number_of_posts-1)*post_gap;
    offset = (bridge_length - post_length)/2;
    for (dx = [offset-3.5/2:post_gap:
               offset+post_length-3.5/2]) {
        translate ([dx,-3.5,-9.25])
            post();
        translate ([dx,tread_width,-9.25])
            post();
    }
}

module caps() {
    translate ([bearing+1.5,-3.5,height + 1.5])
        rotate (a = - atan ( slant/3.5 ), v = [1,0,0] )
            cap();
    translate ([bearing+1.5,tread_width+3.5,height + 1.5])
        rotate (a = atan ( slant/3.5 ), v = [1,0,0] )
            translate ([0,-5.5,0])
                cap();
}

stringers();
backwalls();
treads();
posts();
caps();