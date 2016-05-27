folders:
output/ <- dir to output rendered images
trash_code/ <-old code and examples that can prove useful

files:
main.ini 	<- 	entry point of scene rendering
cust_maze.pov 	<- 	main scene with custom logic difened
amaze.inc 	<- 	custom size labirint "class", credits to author
mydata.txt	<- 	file used to store temporary variables between rendering, this makes animation posbile using only Pov-Ray

-----NOTES
Default starting values:
*for the following Maze initilization in cust_maze.pov :
#declare The_maze = object { Maze( 13, 13, 1, 2, no ) pigment { rgb <0,1,0> } }

mydata.txt 
<0.5,0.4,6.5> ,0,1 <- default values
//|<koordinates>| , |angle|, |state| of maze "traverser"
