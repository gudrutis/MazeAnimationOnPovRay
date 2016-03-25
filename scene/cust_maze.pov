                                          // Include files
#include "colors.inc"
#include "stones.inc"
#include "textures.inc"     


// config
#declare rad = 0.3;  
#declare k = 8; // high of piramid 

// Camera, and light sources
camera {
	location <10,5,2>
	look_at <0, 0, 0>
    }
light_source { 
    <-50, 300,-100> 
    color rgb<1,1,1>
    }
light_source { 
    <-50, 25,-50> 
    color rgb<1,1,1>
    }

// Scene Objects  
plane {
    y, 0 
    texture{
        pigment{
            checker White, Gray25
               } 
            scale 1
           }
      }     


//maze

box {
 <0, 0, 0>
 <-3, 1, 0>
 }

box {
 <0, 0, 0>
 <0, 1, 3>
 }

      
