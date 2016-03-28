#include "amaze.inc"

camera {
  location <6.5,11.5,-4>
  look_at  <6.5,0.5,6.5>
}

light_source { <6.5,12,-0.2> rgb 1 }

plane { y, 0 pigment { rgb <0,0,1> } }

object { Maze( 13, 13, 0.5, 5, no ) pigment { rgb <0,1,0> } }