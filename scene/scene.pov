// Persistence Of Vision raytracer version 3.6 (or higher) file.
// Exported from Sketchup 8.0.4811 (en-US) through SU2POV 3.5. by D. Bur.
// 25/03/2016, 14:40
//-------------------------------------------


// Pov-Ray includes
#include "C:/Program Files (x86)/Google/Google SketchUp 8/Plugins/su2pov/rad_def.inc"
#include "colors.inc"
#include "textures.inc"
#include "golds.inc"
#include "metals.inc"
#include "woods.inc"
#include "stones.inc"
#include "stars.inc"
#include "finish.inc"
#include "sunpos.inc"
#include "math.inc"
#include "transforms.inc"
//-------------------------------------------


// Declare section
//Gamma
#declare GAMMA=1.8;
// Finishes
//Default finish
#declare DefaultFinish = finish { }
#declare Default = finish { }
//Default transparent materials finish
#declare Standard = finish { ambient 0 specular 0.3 roughness 0.001 diffuse 0.25 phong 2 phong_size 60 reflection 0.25 ior 1.5 }
#declare I_Glass = interior { ior 1.5 }
// Generic Finishes
#declare F_None = finish { }
#declare F_Matt = finish { diffuse 0.5 phong 0.2 phong_size 1 }
#declare F_Sattiny = finish { diffuse 0.65 phong 0.45 phong_size 1.8 reflection 0.02 }
#declare F_Shiny = finish {ambient 0 specular 0.8 roughness 0.003}
#declare F_Glossy = finish {ambient 0 specular 1 roughness 0.0003 reflection 0.1}
#declare F_Luminous = finish {ambient 0 diffuse 3.5 }
// Metals Finishes
#declare F_Steel = finish { metallic reflection 0.07 roughness 0.6 crand 0.005 }//specular 0.03 roughness 0.8 }//brilliance 10 }
// Glass Finishes
#declare F_Glass_Default = finish { diffuse 0.5 ambient 0.7 reflection 0.1 specular 0.5 roughness 0.0002 phong 2 phong_size 200 }
#declare F_Glass_Translucent = finish { ior 1.5 ambient 0.2 diffuse 0.4 reflection 0.005 specular 0.4 ior 1.8 roughness 0.4 }
#declare F_Glass_Crystal = finish  { ior 1.5 ambient 0.07 diffuse 0 reflection { 0.2 0.4 } phong 40 phong_size 200 ior 3 }
#declare F_Glass_Dark = finish { ior 1.5 ambient 0 diffuse 0 reflection 0.01 specular 0.01 }
#declare F_Glass_Mirror = finish { ior 1.5 specular 0.7 roughness 0.001 ambient 0 diffuse 0.1 reflection 0.7 conserve_energy }
#declare F_Glass_Dark_Reflexive = finish { ior 1.5 specular 0.9 roughness 0.002 ambient 0 diffuse 0 brilliance 5 reflection { 0.05, 0.1 fresnel on } conserve_energy }
#declare F_Glass_Translucent_Reflexive = finish { ior 1.5 ambient 0.12 diffuse 0.45 reflection { 0.4, 0.7 fresnel on } conserve_energy ior 1.8 roughness 0.4 }
#declare F_Glass_Clear_Half_Reflexive = finish { ior 1.5 specular 0.9 roughness 0.001 ambient 0 diffuse 0.75 brilliance 0 reflection { 0.2, 1.0 fresnel on } conserve_energy }
// Other finishes
#declare F_Plastic = finish { ambient 0 brilliance 3 phong 0.4 phong_size 20 roughness 0.0003 reflection { 0.1, 0.4 } crand 0 }
#declare F_Altuglass = finish { ambient 0 brilliance 4 phong 0.6 phong_size 30 roughness 0.0003 reflection { 0.2, 0.5 } crand 0 }
#declare F_Mirror = finish { reflection 1.0 ambient 0 diffuse 0 specular 1 }
#declare F_Bakelite = finish { metallic reflection { 0.05 0.6 } roughness 0.8 crand 0.04 }
// Metal Normals
#declare N_galvanized = normal { spotted 0.4 scale 1.6 turbulence 1 }
#declare N_hammered = normal { bozo 0.4 scale 1.4 } // needs finish { F_MetalB }
#declare N_molted = normal { marble -1 scale -33 turbulence 1 }
#declare N_punched = normal { leopard 11 scale 0.1 }// needs finish { F_MetalB }
#declare N_stamped = normal { leopard -18 scale 0.1 octaves 0.01 }
#declare N_square_fencing = normal { quilted -1 scale 1 }
#declare N_tiled = normal { cells 3 scale 5 }
// Minerals Normals
#declare N_cast_concrete = normal { dents 0.4 scale 2 }
#declare N_wax_concrete = normal { granite 0.1 scale 200 } // needs finish { reflection 0.05 }
#declare N_rough_concrete = normal { dents 0.4 scale 0.7 }
#declare N_block_concrete = normal { agate 0.2 scale <4,1,1> }
#declare N_rough_coating = normal { agate 0.2 scale 2 turbulence 0.4 }
#declare N_blob_coating = normal { spotted 0.5 scale 2 turbulence 0.1 omega 1 }
#declare N_fine_coating = normal { agate 0.1 scale 1 turbulence 0.2 }
#declare N_full_holes = normal { crackle 8 scale 0.7 form 0.6 }
#declare N_flocking = normal { crackle 5 scale 0.9 form 0.2 }
#declare N_dirty = normal { wrinkles 0.25 scale 40 turbulence 0.12 }
#declare N_mud = normal { granite 0.2  scale 35  }
#declare N_pebbles = normal { wrinkles 2  scale 1.5 turbulence 4 }
#declare N_rock = normal { marble 0.7 scale 17 turbulence 1.2 }
#declare N_paving_pebbles = normal { dents 13 scale 0.2 turbulence 0.4 }
#declare N_dry_clay = normal { crackle 6 scale 7 solid turbulence 0.2 }
// Vegetals Normals
#declare N_raw_wood = normal { ripples 0.1 scale 1 turbulence 0.3 lambda 8 frequency 1 } //octaves 10 }
// Water Normals
#declare N_water_calm = normal { leopard 0.8 scale 5 turbulence 0.2 }
#declare N_water_riddles = normal { ripples 0.5 scale 4 turbulence 0.6 }
#declare N_water_wavy = normal { waves 0.7 scale 11 turbulence 0.8 }
#declare N_water_rough = normal { bumps 0.4 scale 8 turbulence 0.2 }
// Misc Normal
#declare N_emery = normal { spotted 1 scale 0.2 }
#declare N_oil_stain = normal { agate 0.25 scale 55 turbulence 2 }
#declare N_rust = normal { crackle 0.8 scale 11 turbulence 0.15 omega 1.2 }
#declare N_polystyrene = normal { spotted 1.2 scale 0.4 turbulence 0.06 omega 1 }
#declare N_snow = normal { marble -0.08 scale 88 turbulence 1.6 }
#declare N_cork = normal { dents 5 scale 3 turbulence 6 }
#declare N_lizard_skin = normal { wrinkles 1 scale 0.7 turbulence 0.05 octaves 18 }
#declare N_leather = normal { crackle 0.5 scale 0.3 }
#declare N_None = normal { }
// Lights colors
#declare Candle = rgb <255/255.0, 147/255.0, 41/255.0>;
#declare Incandescence = rgb <1, 0.9, 0.6>;
#declare Halogen = rgb <255/255.0, 241/255.0, 224/255.0>;
#declare Tungsten_Halogen = rgb <255/255.0, 214/255.0, 170/255.0>;
#declare Sodium_HighPressure = rgb <255/255.0, 183/255.0, 76/255.0>;
#declare Sodium_Vapor = rgb <255/255.0, 209/255.0, 178/255.0>;
#declare Fluorescent = rgb <244/255.0, 255/255.0, 250/255.0>;
#declare Fluorescent_Warm = rgb <255/255.0, 244/255.0, 229/255.0>;
#declare Fluorescent_Cold = rgb <212/255.0, 235/255.0, 255/255.0>;
#declare Mercury = rgb <216/255.0, 247/255.0, 255/255.0>;
#declare Metal_Halide = rgb <242/255.0, 252/255.0, 255/255.0>;

#declare Lightbulb = sphere {
    <0,0,0>,1.5
    scale <0.7,1.1,0.7>
    texture { pigment {color rgb <1, 1, 0.5>}}
    finish { Luminous }
    }

//-------------------------------------------


//Radiosity settings
global_settings {
      charset utf8
      assumed_gamma GAMMA
      max_trace_level 10
      adc_bailout 0.03
      radiosity { Rad_Settings(Radiosity_OutdoorLQ, on, off) }
      radiosity { brightness 1.0 }
      ambient_light 1
}
//-------------------------------------------


// Day Gradient Background or SkyBox map
sky_sphere {
    pigment {
    gradient y
   color_map {
    [(1-cos(radians(0)))/2 color White]
    [(1-cos(radians(50)))/2 color rgb <0.776470588235294,0.803921568627451,0.815686274509804>]
    }
    scale 1
    translate -1
    }
}
//-------------------------------------------


//-------------------------------------------


//-------------------------------------------


// Camera
camera {
    perspective
    location <545.178095834525,246.322347131113,-797.04076370448>
    look_at <-34.6630978971265,118.651624231448,-34.8947435012074>
    right <2.0554675118859,0,0>
    up <-0.0800140879710021,0.991229957205448,0.105170897422504>
    angle 65.8934488384042
}
//-------------------------------------------


//-------------------------------------------


// Default material
#declare Default = texture {
    pigment { color rgb <1.0,1.0,1.0>}
    finish {
    ambient 0.1 diffuse 0.6
    brilliance 0.1
    phong 0 phong_size 40
    specular 0.0
    roughness 0.005
    crand 0.0
    reflection { 0.0 }
    }
}
//-------------------------------------------


#declare black = texture {
    pigment { color rgb <0.0,0.0,0.0>}
    finish { F_None }
}

#declare infBeigesupb = texture {
    pigment { color rgb <0.827450980392157,0.741176470588235,0.564705882352941>}
    finish { F_None }
}

#declare Color_Bce = texture {
    pigment { color rgb <0.2,0.137254901960784,0.117647058823529>}
    finish { F_None }
}

#declare infLightGraysup = texture {
    pigment { color rgb <0.662745098039216,0.662745098039216,0.662745098039216>}
    finish { F_None }
}

#declare abdf_DarkGray = texture {
    pigment { color rgb <0.317647058823529,0.317647058823529,0.317647058823529>}
    finish { F_None }
}

#declare jgjgjg = texture {
    pigment { color rgb <0.376470588235294,0.376470588235294,0.376470588235294>}
    finish { F_None }
}

#declare jeanblue = texture {
    pigment { color rgb <0.141176470588235,0.184313725490196,0.258823529411765>}
    finish { F_None }
}

#declare infCharcoalsup = texture {
    pigment { color rgb <0.137254901960784,0.137254901960784,0.137254901960784>}
    finish { F_None }
}

//-------------------------------------------


//-------------------------------------------


//-------------------------------------------


//-------------------------------------------

//-------------------------------------------

#declare MODEL = union {
mesh2 {
    vertex_vectors {
      4,
<-708.661417322835,100.157480314961,590.551181102362>,
<-708.661417322835,0.0,0.0>,
<-708.661417322835,100.157480314961,0.0>,
<-708.661417322835,0.0,590.551181102362>,
}
   normal_vectors {
      4,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
}
    uv_vectors {
    4,
<-590.551181102362,100.157480314961>,
<0.0,0.0>,
<0.0,100.157480314961>,
<-590.551181102362,0.0>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-354.330708661417,98.5553991919406,0.0>,
<-708.661417322835,0.0,0.0>,
<-354.330708661417,0.0,0.0>,
<-708.661417322835,100.157480314961,0.0>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-354.330708661417,98.5553991919406>,
<-708.661417322835,0.0>,
<-354.330708661417,0.0>,
<-708.661417322835,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<0.0,100.157480314961,708.661417322835>,
<0.0,0.0,236.220472440945>,
<0.0,100.157480314961,236.220472440945>,
<0.0,0.0,708.661417322835>,
}
   normal_vectors {
      4,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
}
    uv_vectors {
    4,
<-708.661417322835,100.157480314961>,
<-236.220472440945,0.0>,
<-236.220472440945,100.157480314961>,
<-708.661417322835,0.0>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<0.0,100.157480314961,708.661417322835>,
<-118.110236220472,0.0,708.661417322835>,
<0.0,0.0,708.661417322835>,
<-118.110236220472,100.157480314961,708.661417322835>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<0.0,100.157480314961>,
<-118.110236220472,0.0>,
<0.0,0.0>,
<-118.110236220472,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-590.551181102362,100.157480314961,708.661417322835>,
<-708.661417322835,0.0,708.661417322835>,
<-590.551181102362,0.0,708.661417322835>,
<-708.661417322835,100.157480314961,708.661417322835>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-590.551181102362,100.157480314961>,
<-708.661417322835,0.0>,
<-590.551181102362,0.0>,
<-708.661417322835,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-118.110236220472,0.0,708.661417322835>,
<-118.110236220472,100.157480314961,472.44094488189>,
<-118.110236220472,0.0,472.44094488189>,
<-118.110236220472,100.157480314961,708.661417322835>,
}
   normal_vectors {
      4,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    4,
<708.661417322835,0.0>,
<472.44094488189,100.157480314961>,
<472.44094488189,0.0>,
<708.661417322835,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-354.330708661417,100.157480314961,472.44094488189>,
<-472.44094488189,0.0,472.44094488189>,
<-354.330708661417,0.0,472.44094488189>,
<-472.44094488189,100.157480314961,472.44094488189>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-354.330708661417,100.157480314961>,
<-472.44094488189,0.0>,
<-354.330708661417,0.0>,
<-472.44094488189,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-236.220472440945,0.0,236.220472440945>,
<-236.220472440945,100.157480314961,118.110236220473>,
<-236.220472440945,0.0,118.110236220473>,
<-236.220472440945,100.157480314961,236.220472440945>,
}
   normal_vectors {
      4,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    4,
<236.220472440945,0.0>,
<118.110236220473,100.157480314961>,
<118.110236220473,0.0>,
<236.220472440945,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-236.220472440945,100.157480314961,118.110236220473>,
<-118.110236220472,0.0,118.110236220473>,
<-236.220472440945,0.0,118.110236220473>,
<-118.110236220472,100.157480314961,118.110236220473>,
}
   normal_vectors {
      4,
<-0.0,-0.0,1.0>,
<-0.0,-0.0,1.0>,
<-0.0,-0.0,1.0>,
<-0.0,-0.0,1.0>,
}
    uv_vectors {
    4,
<236.220472440945,100.157480314961>,
<118.110236220472,0.0>,
<236.220472440945,0.0>,
<118.110236220472,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-118.110236220472,100.157480314961,354.330708661417>,
<-354.330708661417,0.0,354.330708661417>,
<-118.110236220472,0.0,354.330708661417>,
<-354.330708661417,100.157480314961,354.330708661417>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-118.110236220472,100.157480314961>,
<-354.330708661417,0.0>,
<-118.110236220472,0.0>,
<-354.330708661417,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-354.330708661417,0.0,354.330708661417>,
<-354.330708661417,100.157480314961,236.220472440945>,
<-354.330708661417,0.0,236.220472440945>,
<-354.330708661417,100.157480314961,354.330708661417>,
}
   normal_vectors {
      4,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    4,
<354.330708661417,0.0>,
<236.220472440945,100.157480314961>,
<236.220472440945,0.0>,
<354.330708661417,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-354.330708661417,100.157480314961,236.220472440945>,
<-472.44094488189,0.0,236.220472440945>,
<-354.330708661417,0.0,236.220472440945>,
<-472.44094488189,100.157480314961,236.220472440945>,
}
   normal_vectors {
      4,
<-2.40637139844087e-016,0.0,-1.0>,
<-2.40637139844087e-016,0.0,-1.0>,
<-2.40637139844087e-016,0.0,-1.0>,
<-2.40637139844087e-016,0.0,-1.0>,
}
    uv_vectors {
    4,
<-354.330708661417,100.157480314961>,
<-472.44094488189,0.0>,
<-354.330708661417,0.0>,
<-472.44094488189,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-118.110236220472,97.4873451099273,0.0>,
<-354.330708661417,0.0,0.0>,
<-118.110236220472,0.0,0.0>,
<-354.330708661417,98.5553991919406,0.0>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-118.110236220472,97.4873451099273>,
<-354.330708661417,0.0>,
<-118.110236220472,0.0>,
<-354.330708661417,98.5553991919406>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      5,
<-354.330708661417,0.0,236.220472440945>,
<-354.330708661417,98.5553991919406,0.0>,
<-354.330708661417,0.0,0.0>,
<-354.330708661417,100.157480314961,0.0>,
<-354.330708661417,100.157480314961,236.220472440945>,
}
   normal_vectors {
      5,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    5,
<236.220472440945,0.0>,
<0.0,98.5553991919406>,
<0.0,0.0>,
<0.0,100.157480314961>,
<236.220472440945,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      3,
<0,1,2>, 0,
<1,0,3>, 0,
<3,0,4>, 0,
}
    normal_indices {
    3,
<0,1,2>,
<1,0,3>,
<3,0,4>,
}
    uv_indices {
      3,
<0,1,2>,
<1,0,3>,
<3,0,4>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-472.44094488189,100.157480314961,118.110236220472>,
<-590.551181102362,0.0,118.110236220472>,
<-472.44094488189,0.0,118.110236220472>,
<-590.551181102362,100.157480314961,118.110236220472>,
}
   normal_vectors {
      4,
<-6.01592849610218e-016,0.0,-1.0>,
<-6.01592849610218e-016,0.0,-1.0>,
<-6.01592849610218e-016,0.0,-1.0>,
<-6.01592849610218e-016,0.0,-1.0>,
}
    uv_vectors {
    4,
<-472.44094488189,100.157480314961>,
<-590.551181102362,0.0>,
<-472.44094488189,0.0>,
<-590.551181102362,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-472.44094488189,0.0,472.44094488189>,
<-472.44094488189,100.157480314961,236.220472440945>,
<-472.44094488189,0.0,236.220472440945>,
<-472.44094488189,100.157480314961,472.44094488189>,
}
   normal_vectors {
      4,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    4,
<472.44094488189,0.0>,
<236.220472440945,100.157480314961>,
<236.220472440945,0.0>,
<472.44094488189,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-590.551181102362,100.157480314961,708.661417322835>,
<-590.551181102362,0.0,118.110236220472>,
<-590.551181102362,100.157480314961,118.110236220472>,
<-590.551181102362,0.0,708.661417322835>,
}
   normal_vectors {
      4,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
}
    uv_vectors {
    4,
<-708.661417322835,100.157480314961>,
<-118.110236220472,0.0>,
<-118.110236220472,100.157480314961>,
<-708.661417322835,0.0>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<0.0,100.157480314961,236.220472440945>,
<0.0,0.0,0.0>,
<0.0,100.157480314961,0.0>,
<0.0,0.0,236.220472440945>,
}
   normal_vectors {
      4,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
<-1.0,0.0,0.0>,
}
    uv_vectors {
    4,
<-236.220472440945,100.157480314961>,
<0.0,0.0>,
<0.0,100.157480314961>,
<-236.220472440945,0.0>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<0.0,100.157480314961,236.220472440945>,
<-236.220472440945,0.0,236.220472440945>,
<0.0,0.0,236.220472440945>,
<-236.220472440945,100.157480314961,236.220472440945>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<0.0,100.157480314961>,
<-236.220472440945,0.0>,
<0.0,0.0>,
<-236.220472440945,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-118.110236220472,100.157480314961,472.44094488189>,
<-236.220472440945,0.0,472.44094488189>,
<-118.110236220472,0.0,472.44094488189>,
<-236.220472440945,100.157480314961,472.44094488189>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-118.110236220472,100.157480314961>,
<-236.220472440945,0.0>,
<-118.110236220472,0.0>,
<-236.220472440945,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-118.110236220472,100.157480314961,708.661417322835>,
<-590.551181102362,0.0,708.661417322835>,
<-118.110236220472,0.0,708.661417322835>,
<-590.551181102362,100.157480314961,708.661417322835>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-118.110236220472,100.157480314961>,
<-590.551181102362,0.0>,
<-118.110236220472,0.0>,
<-590.551181102362,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-236.220472440945,100.157480314961,590.551181102362>,
<-472.44094488189,0.0,590.551181102362>,
<-236.220472440945,0.0,590.551181102362>,
<-472.44094488189,100.157480314961,590.551181102362>,
}
   normal_vectors {
      4,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
<0.0,0.0,-1.0>,
}
    uv_vectors {
    4,
<-236.220472440945,100.157480314961>,
<-472.44094488189,0.0>,
<-236.220472440945,0.0>,
<-472.44094488189,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
mesh2 {
    vertex_vectors {
      4,
<-472.44094488189,0.0,590.551181102362>,
<-472.44094488189,100.157480314961,472.44094488189>,
<-472.44094488189,0.0,472.44094488189>,
<-472.44094488189,100.157480314961,590.551181102362>,
}
   normal_vectors {
      4,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
<1.0,-0.0,-0.0>,
}
    uv_vectors {
    4,
<590.551181102362,0.0>,
<472.44094488189,100.157480314961>,
<472.44094488189,0.0>,
<590.551181102362,100.157480314961>,
}
    texture_list{
    1,
texture { Default }
}
    face_indices {
      2,
<0,1,2>, 0,
<1,0,3>, 0,
}
    normal_indices {
    2,
<0,1,2>,
<1,0,3>,
}
    uv_indices {
      2,
<0,1,2>,
<1,0,3>,
}
}
} // End of MODEL object declare
//-------------------------------------------


object { MODEL }
//-------------------------------------------


//-------------------------------------------


//-------------------------------------------


