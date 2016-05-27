// Include files
#include "colors.inc"
#include "stones.inc"
#include "textures.inc"     

//// use these functions to check if 3 points are in 1 line
// !!! Doesnt work with not perpendicular interconections!!!            
#declare distance_is = function(ax, ay,az, bx,by,bz  ) { sqrt(pow(ax - bx,2) + pow(ay - by,2) + pow(az - bz,2)) }
// check if c point is beetween a and b          
#declare isBetween = function( ax, ay, az, bx, by, bz, cx, cy, cz ) { distance_is(ax,ay,az,cx,cy,cz) + distance_is(bx,by,bz,cx,cy,cz) = distance_is(ax, ay, az , bx,by,bz ) }


////
// Constants / Config
#declare step = 0.5;
#declare angularStep = 45;

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

camera {
  location <6.5,11.5,-4>
  look_at  <6.5,0.5,6.5>
}

light_source { <6.5,12,-0.2> rgb 1 }



                  

// plane { y, 0 pigment {rgb <0,0,1>} }

// file reading, used for animation
#fopen MyFile "mydata.txt" read
    #read  (MyFile, Object_coordinates)  // the "object" a.k.a maze traverser 
    #read  (MyFile, Direction) // where object looks 
    #read  (MyFile, Move) // wich part of move between 2 points it is
    #read  (MyFile, Status) // wich part of move between 2 points it is 
    #read  (MyFile, SpVarFoward) // wich part of move between 2 points it is    
#fclose MyFile  

 
//vectors for the foloving intersection points and new position calculation
#declare Object_point_st = vrotate(<1,0,0> , <0, Direction, 0>); // point in front of object
#declare Object_point_right = vrotate(<1,0,0> , <0, Direction+90, 0>); 
#declare Object_point_left = vrotate(<1,0,0> , <0, Direction-90, 0>); 
#declare Object_point_back = vrotate(<1,0,0> , <0, Direction-180, 0>);

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

////////
// maze traversing algorithm - check if there is intersection, and if yes, change values acordingly

#declare Norm_st = <0, 0, 0>;
#declare Norm_right = <0, 0, 0>;
#declare Norm_left = <0, 0, 0>;

// exhact position of testing points and used for object new position, not relative vectors
#declare Point_st = Object_coordinates + Object_point_st;
#declare Point_right = Object_coordinates + Object_point_right;
#declare Point_left = Object_coordinates + Object_point_left;
#declare Point_back = Object_coordinates + Object_point_back;

// Coordinates of intersection between obecjt and ray to obsticle in front | right | left, used on later calculations 
#declare Inter_st= trace ( The_maze, Object_coordinates, Object_point_st , Norm_st );
#declare Inter_right= trace ( The_maze, Object_coordinates, Object_point_right, Norm_right );
#declare Inter_left= trace ( The_maze, Object_coordinates, Object_point_left , Norm_left );

#declare obsticle_st =          isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z,
                                           Point_st.x, Point_st.y, Point_st.z, 
                                           Inter_st.x, Inter_st.y, Inter_st.z );
#declare obsticle_right =       isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z, 
                                           Point_right.x, Point_right.y, Point_right.z, 
                                           Inter_right.x, Inter_right.y, Inter_right.z ) ;
#declare obsticle_left =        isBetween( Object_coordinates.x, Object_coordinates.y, Object_coordinates.z, 
                                           Point_left.x, Point_left.y, Point_left.z, 
                                           Inter_left.x, Inter_left.y, Inter_left.z ) ;

/////////////////////////
// Debug
//////////
//!! using #warning instead of #debug since #debug mesages were not displayed on console(or I didn't find them)
#warning concat("Front is:",str(obsticle_st, 0, 3) ,"\n") 
#warning concat("Right is:",str(obsticle_right, 0, 3) ,"\n")
#warning concat("Left  is:",str(obsticle_left, 0, 3) ,"\n")
//----debug finishes

//-- if->else to determine new location, position and transition for the object
/*
#if ((obsticle_st=0) & (obsticle_right=0) & (obsticle_left=0)) //(finish)no obsticles around, we finished 
    //!!! theres is posibility for it to fail(when all 4 ways are open inside maze !!!
    // do nothing    
*/               
#warning concat("Status:", str(Status,3,3) ,"\n")  
#switch (Status)
  #case (0)
    #if((obsticle_st=0) & (obsticle_right=1)) //(straig)obsticles in the right but not straigh, go straight 
		#declare Status = 1 ; // Todo - decide what to do with Move variable 
		#declare Object_coordinates = Object_coordinates + Object_point_st*step;
		#declare Move = step;
	#elseif( obsticle_right = 0 ) //(right) no obsticles in the right, go right 
        #declare Status = 2 ;
        #declare SpVarFoward = 1;
        #declare Direction = Direction + angularStep; 
	#elseif((obsticle_st=1) & (obsticle_right=1) & (obsticle_left=0)) //(left) 
        #declare Status = 3 ;
        #declare Direction = Direction - angularStep;
	#else //back 
		#warning concat("script to go back is firing")
		#declare Status = 4 ; // Todo - decide what to do with Move variable
		#declare Direction = Direction + angularStep; 
	#end
  #break
  #case (1) // move
    #if(Move < 1) 
        #declare Object_coordinates = Object_coordinates + Object_point_st*step;
        #declare Move = Move + step;
    #else 
        #declare Status = 0;
        #declare Move = 0;
    #end
  #break
  #case (2) // rotate right + exceptions          
    #if(mod(Direction,90)!= 0) 
        #declare Direction = Direction + angularStep; 
    #else  // after rotating right go foward
        #if (SpVarFoward = 1 )
            #declare Status = 1 ;
            #declare SpVarFoward = 0;
            #declare Object_coordinates = Object_coordinates + Object_point_st*step;
            #declare Move = Move + step; 
        #else
            #declare Status = 0 ;
        #end    
    #end
  #break
  #case (3) // rotate left
    #if(mod(Direction,90)!= 0)
        #declare Direction = Direction - angularStep;
    #else
        #declare Status = 0 ;
    #end                     
  #break
  #case (4) // rotate right 180 degrees
    #if(mod(Direction,180)!= 0)
        #declare Direction = Direction + angularStep;
    #else
        #declare Status = 0 ;
        #declare SpVarFoward = 1;
    #end  
  #break    
  #else
    #warning concat("Status:",Status ,"\n")  
    #debug "Pass"
#end

#if (Status=0) // this if will get rid of extra idle rendered pictures
    #if((obsticle_st=0) & (obsticle_right=1)) //(straig)obsticles in the right but not straigh, go straight 
		#declare Status = 1 ; // Todo - decide what to do with Move variable 
		#declare Object_coordinates = Object_coordinates + Object_point_st*step;
		#declare Move = step;
	#elseif( obsticle_right = 0 ) //(right) no obsticles in the right, go right 
        #declare Status = 2 ;
        #declare SpVarFoward = 1;
        #declare Direction = Direction + angularStep; 
	#elseif((obsticle_st=1) & (obsticle_right=1) & (obsticle_left=0)) //(left) 
        #declare Status = 3 ;
        #declare Direction = Direction - angularStep;
	#else //back 
		#warning concat("script to go back is firing")
		#declare Status = 4 ; // Todo - decide what to do with Move variable
		#declare Direction = Direction + angularStep; 
	#end
#end






//-- place to open file and safe changes
#fopen MyFile "mydata.txt" write
    #write( MyFile, Object_coordinates,",", Direction,",",Move,",",Status,",",SpVarFoward,"\n")
#fclose MyFile 


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