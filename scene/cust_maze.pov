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

// file reading, used for animation
#fopen MyFile "mydata.txt" read
#read  (MyFile,Object_coordinates)  // the "object" a.k.a maze traverser
//#read  (MyFile,Object_look) 
#read  (MyFile, Direction) 
 
 
//vrotate( Direction, <90, 0, 0>)
#declare Object_point_st = vrotate(<1,0,0> , <0, Direction, 0>); // point in front of object
#declare Object_point_right = vrotate(<1,0,0> , <0, Direction+90, 0>); 
#declare Object_point_left = vrotate(<1,0,0> , <0, Direction-90, 0>); 

#declare The_maze = object { Maze( 13, 13, 1, 2, no ) pigment { rgb <0,1,0> } }   
object { The_maze } 

#declare MySphere = sphere { Object_coordinates + Object_point_st, 0.2 }

object { MySphere  pigment {color red 1} } 
// point on right
object {
        sphere { Object_coordinates + Object_point_right, 0.2 pigment {color blue 1} }
        }
// point on left
object { sphere { Object_coordinates + Object_point_left, 0.2 pigment {color rgb<100,10,1>}}}
  
///--------      
// #declare MySphere = sphere {MySphere_vector, 0.4 pigment { rgb <8,1,0> } }  

// draving the the maze traverser
#declare Mover = cone { <-0.3,0,0>, 0.4, <0.3,0,0>, 0 pigment { rgb <8,1,0> } } 
object { Mover rotate <0,Direction,0>
               translate Object_coordinates
      //translate - MySphere_vector rotate 90  translate (MySphere_vector)
    }  


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
  
#declare Inter= trace ( The_maze, Start, End - Start, Norm );    // !!Note!! trace continues until it meets something, not only to END point



// check if there is interconection, and if yes show 
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