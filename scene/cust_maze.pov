// Include files
#include "colors.inc"
#include "stones.inc"
#include "textures.inc"     


// config
//#declare rad = 0.3;  
//#declare k = 8; // high of piramid 

// Camera, and light sources
/*
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
*/ 

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

//// use these functions to check if 3 points are in 1 line
// !!! Doesnt work with not perpendicular interconections!!!            
#declare distance_is = function(ax, ay,az, bx,by,bz  ) { sqrt(pow(ax - bx,2) + pow(ay - by,2) + pow(az - bz,2)) }
          
#declare isBetween = function( ax, ay, az, bx, by, bz, cx, cy, cz ) { distance_is(ax,ay,az,cx,cy,cz) + distance_is(bx,by,bz,cx,cy,cz) = distance_is(ax, ay, az , bx,by,bz ) }

// for maze itself
#include "amaze.inc"

camera {
  location <6.5,11.5,-4>
  look_at  <6.5,0.5,6.5>
}

light_source { <6.5,12,-0.2> rgb 1 }

plane { y, 0 pigment { rgb <0,0,1> } }

#declare a = object { Maze( 13, 13, 1, 2, no ) pigment { rgb <0,1,0> } }   
object { a } 
  
///--------      
#declare MySphere = sphere { <0.5, 0.4, 6.5>, 0.4 pigment { rgb <8,1,0> } }  
object { MySphere }  

#declare Norm = <0, 0, 0>; 
#declare Start = <0.5, 0.5, 0.5>;
#declare End = <-0.5, 0.5, 0.5>;
// trace ray
cylinder { 
  Start, End, .1 
  texture { 
    pigment {color blue 1} 
    } 
  }      
  
#declare Inter= trace ( a, Start, End - Start, Norm );    // !!Note!! trace continues until it meets something, not only to END point



// check if there is interconection
#if (vlength(Norm)!=0 & isBetween( Start.x, Start.y, Start.z, End.x, End.y, End.z, Inter.x, Inter.y, Inter.z )) 
cylinder { 
  Inter, Inter+Norm, .1 
  texture { 
    pigment {color red 1} 
    } 
  } 
#end 



          
           
//----------           
#warning concat("Value is:",vstr(3,Inter, ", ", 0,1),"\n") // zinute  (println) NOTE! debug message cant be found, so using Warning instead!   
 
 
 
// #include "cuz_maze.inc"
// object  {cus_maze}