# Project description

This is source code of animation showing ball traversing a maze. Both rendering and animation is implemented using POV-Ray renderer. The animation itself is implemented using 'hacky' solution - variables are stored temporary in ouput file which alows to implement some logic since POV-Ray is used for scene rendering and not for animation.

## Structure
folders:
trash_code/ <-old code and examples that can prove useful

files:
main.ini 	<- 	entry point of scene rendering
cust_maze.pov 	<- 	main scene with custom logic difened
amaze.inc 	<- 	custom size maze "class", credits to author
mydata.txt	<- 	file used to store temporary variables between rendering, this makes animation posbile using only Pov-Ray

## NOTES

*for the following Maze initilization in cust_maze.pov :
#declare The_maze = object { Maze( 13, 13, 1, 2, no ) pigment { rgb <0,1,0> } }

Default starting values:
in <mydata.txt>
<0.5,0.4,6.5> ,0,0,0,0 <- default values
//|<coordinates>| , |angle|, |move|,|state|,|spec_var| of maze "traverser"
