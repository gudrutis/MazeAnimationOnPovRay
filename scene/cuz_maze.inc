                                  //----------------------- harcode maze by me

//maze

#declare cus_maze = union
{
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
 };    
 
