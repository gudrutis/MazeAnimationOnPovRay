// Include files
#include "colors.inc"
#include "stones.inc"
#include "textures.inc"     


// config
//#declare rad = 0.3;  
//#declare k = 8; // high of piramid 

// Camera, and light sources
camera {
	location <0,10,0>
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
// || z
box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,3>
 translate<3,0,0>
 pigment{Yellow}
 }

box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,3>
 pigment{Yellow}
 }

box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,1>
 translate<2,0,2>
 pigment{Yellow}
 }      
      
// || x
box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,3>
 pigment{Yellow}
 rotate < 0,90,0>
 }

box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,2>
 pigment{Yellow}
 rotate < 0,90,0>
 translate<0,0,1>
 }
 
box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,1>
 pigment{Yellow}
 rotate < 0,90,0>
 translate<0,0,3>
 }
      
box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,1>
 pigment{Yellow}
 rotate < 0,90,0>
 translate<2,0,3>
 }  

box {
 <-0.01, 0, 0>
 <0.01, 1, 1>
 scale<1,1,1>
 pigment{Yellow}
 rotate < 0,90,0>
 translate<1,0,2>
 } 