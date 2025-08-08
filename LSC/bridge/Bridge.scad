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
        cube ([3.5,3.5,44]);
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
for (dx = [12,6*12-3.5/2,12*12+1.5-12-3.5]) {
    translate ([dx,-3.5,-9.25])
        post();
    translate ([dx,48,-9.25])
        post();
}