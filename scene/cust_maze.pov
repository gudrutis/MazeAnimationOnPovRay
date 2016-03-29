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
// check if c point is beetween a and b          
#declare isBetween = function( ax, ay, az, bx, by, bz, cx, cy, cz ) { distance_is(ax,ay,az,cx,cy,cz) + distance_is(bx,by,bz,cx,cy,cz) = distance_is(ax, ay, az , bx,by,bz ) }



camera {
  location <6.5,11.5,-4>
  look_at  <6.5,0.5,6.5>
}

light_source { <6.5,12,-0.2> rgb 1 }

plane { y, 0 pigment {rgb <0,0,1>} }

// file reading, used for animation
#fopen MyFile "mydata.txt" read
#read  (MyFile,Object_coordinates)  // the "object" a.k.a maze traverser 
#read  (MyFile, Direction) // where object looks 
#read  (MyFile, Move) // wich part of move between 2 points it is
#fclose MyFile  

 
//vectors for the foloving intersection points
#declare Object_point_st = vrotate(<1,0,0> , <0, Direction, 0>); // point in front of object
#declare Object_point_right = vrotate(<1,0,0> , <0, Direction+90, 0>); 
#declare Object_point_left = vrotate(<1,0,0> , <0, Direction-90, 0>); 

// for maze itself
#include "amaze.inc"
#declare The_maze = object { Maze( 13, 13, 1, 2, no ) pigment { rgb <0,1,0> } }   
object { The_maze } 


#declare MySphere = sphere { Object_coordinates + Object_point_st, 0.2 }

// point straight in front
object { MySphere  pigment {color red 1} } 
// point on right
object {        sphere { Object_coordinates + Object_point_right, 0.2 pigment {color blue 1}}}
// point on left
object { sphere { Object_coordinates + Object_point_left, 0.2 pigment {color rgb<100,10,1>}}}
  
///--------      
// #declare MySphere = sphere {MySphere_vector, 0.4 pigment { rgb <8,1,0> } }  

// draving the the maze traverser
#declare Mover = cone { <-0.3,0,0>, 0.4, <0.3,0,0>, 0 pigment { rgb <8,1,0> } } 
object { Mover rotate <0,Direction,0>
               translate (Object_coordinates+Object_point_st*0) // vector multplying works
      //translate - MySphere_vector rotate 90  translate (MySphere_vector)
    }  

////  ////
// maze traversing algorithm - check if there is intersection, and if yes, change values acordingly

#declare Norm_st = <0, 0, 0>;
#declare Norm_right = <0, 0, 0>;
#declare Norm_left = <0, 0, 0>;

// exhact position of testing points, not relative vectors
#declare Point_st = Object_coordinates + Object_point_st;
#declare Point_right = Object_coordinates + Object_point_right;
#declare Point_left = Object_coordinates + Object_point_left;

#declare Inter_st= trace ( The_maze, Object_coordinates, Object_point_st , Norm_st );
#declare Inter_right= trace ( The_maze, Object_coordinates, Object_point_right, Norm_right );
#declare Inter_left= trace ( The_maze, Object_coordinates, Object_point_left , Norm_left );

// 
#warning concat("Front is:",str(isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z,
                                           Point_st.x, Point_st.y, Point_st.z, 
                                           Inter_st.x, Inter_st.y, Inter_st.z ), 0, 3) ,"\n")

#warning concat("Right is:",str(isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z, 
                                           Point_right.x, Point_right.y, Point_right.z, 
                                           Inter_right.x, Inter_right.y, Inter_right.z ), 0, 3) ,"\n")
#warning concat("Left  is:",str(isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z, 
                                           Point_left.x, Point_left.y, Point_left.z, 
                                           Inter_left.x, Inter_left.y, Inter_left.z ), 0, 3) ,"\n")

/*
#warning concat("intersection in front:",vstr(3,Inter_st, ", ", 0,1),"\n") // zinute  (println) NOTE! debug message cant be found, so using Warning instead!
#warning concat("intersection on right:",vstr(3,Inter_right, ", ", 0,1),"\n")
#warning concat("intersection on left:",vstr(3,Inter_left, ", ", 0,1),"\n")
*/


/*
//// This is trace testing algorithm //// 
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
*/
          
//----------           
//#warning concat("Value is:",vstr(3,Inter, ", ", 0,1),"\n") // zinute  (println) NOTE! debug message cant be found, so using Warning instead!   
 
 
// #include "cuz_maze.inc"
// object  {cus_maze}