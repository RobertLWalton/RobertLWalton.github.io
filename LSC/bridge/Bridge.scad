// All distances are in inches.
//
width = 4*12;
    // Tread width.
height = 40.5;
    // Height of outside of post above top of tread.
slant = 0.75;
    // Differnce in height of outside and inside
    // of post.



module tread()
{
    color ("SandyBrown")
        cube ([5.5,48,1.5]);
}
module stringer()
{
    color ("Chocolate")
        cube ([12*12+1.5,1.5,9.25]);
}
module backwall()
{
    color ("LightGray")
        cube ([1.5,48,9.25]);
}
module post()
{
    color ("tomato")
        cube ([3.5,3.5,height+9.25+1.5]);
}
module cap()
{
    color ("blue")
        cube ([(12-2)*12,5.5,1.0]);
}
for (dx = [0:6+3.5/23:12*12]) {
    translate ([dx,0,0]) tread();
}
for (dy = [0,1.5,24-1.5,24,48-2*1.5,48-1.5]) {
    translate ([0,dy,-9.25]) stringer();
}
for (dx = [0,12*12+1.5]) {
    translate ([dx,0,-9.25])
        backwall();
}
module posts() {
    for (dx = [12,6*12-3.5/2,12*12+1.5-12-3.5]) {
    translate ([dx,-3.5,-9.25])
        post();
    translate ([dx,48,-9.25])
        post();
    }
}

module caps() {
    translate ([12,-3.5,height + 1.5])
        rotate (a = - atan ( slant/3.5 ), v = [1,0,0] )
            cap();
}

posts();
caps();