                                                //////////////////////////////////////////////////////////////////////////
// A Maze Macro
// Copyright (c) 2000 by Robert Chaffe


//////////////////////////////////////////////////////////////////////////
// First, some convenience macros.

// Not sure if rand() ever returns a 1.0, which is just a wee bit too
// high, so let's try this macro.
#macro RandInt( MaxInt, Seed )
   min( int( rand( Seed ) * MaxInt ), MaxInt - 1 )
#end

// An "or" bitwise operator would be nice.  Oh well.
#macro HasEastValue( CellValue )
   ( ( CellValue = 2 ) |
     ( CellValue = 3 ) |
     ( CellValue = 6 ) |
     ( CellValue = 7 ) |
     ( CellValue = 10 ) |
     ( CellValue = 11 ) |
     ( CellValue = 14 ) |
     ( CellValue = 15 ) ? yes : no )
#end

#macro HasSouthValue( CellValue )
   ( CellValue >= 8 ? yes : no )
#end


//////////////////////////////////////////////////////////////////////////
// Parameters for Maze macro:
// pRows      = number of rows in grid
// pCols      = number of columns in grid
// WallHeight = height of maze walls
// Seed       = float value for seed function
// DoDebug    = boolean indicating if debug messages should be written

#macro Maze ( pRows, pCols, WallHeight, Seed, DoDebug )

// A few safety checks.
#if ( pRows < 4.0 )
   #error "Maze macro: The Rows parameter should be 4 or greater."
#end
#if ( pCols < 4.0 )
   #error "Maze macro: The Cols parameter should be 4 or greater."
#end
#if ( WallHeight <= 0 )
   #error "Maze macro: The WallHeight parameter should be greater than zero."
#end

// Just in case we were not given integers.
#local Rows = int( pRows );
#local Cols = int( pCols );

// Initialize randomness.
#local S = seed( Seed );

// Initialize array.
#if ( DoDebug )
   #debug concat("\nMaze: Initializing ",str(Rows,0,0),"x",str(Cols,0,0)," grid.\n")
#end

#local Grid = array[ Rows ][ Cols ]

#local R = 0;
#while ( R < Rows )
   #local C = 0;
   #while ( C < Cols )
      #local Grid[R][C] = 0;
      #local C = C + 1;
   #end
   #local R = R + 1;
#end

// Establish start and end cells.
#local StartEdge = RandInt( 2, S );

#switch ( StartEdge )
   #case ( 0 )
      // Start in north, or top row.  End in south.
      #local StartRow = 0;
      #local StartCol = RandInt( Cols, S );
      #local Grid[ StartRow ][ StartCol ] = -1;
      #local Grid[ Rows - 1 ][ RandInt( Cols, S ) ] = 8;
      #break

   #else
      // Start in west, or left column.  End in east.
      #local StartRow = RandInt( Rows, S );
      #local StartCol = 0;
      #local Grid[ StartRow ][ StartCol ] = -4;
      #local Grid[ RandInt( Rows, S ) ][ Cols - 1 ] = 2;
#end

// These will be useful later when actually creating the object.
#local InitialRow = StartRow;
#local InitialCol = StartCol;

// We're finished when the number of unused cells reaches zero.
#local NumUnusedCells = ( Rows * Cols ) - 1;

#while ( NumUnusedCells > 0 )

   #if ( DoDebug )
      #debug concat("Maze: Starting new path at ",str(StartRow,0,0),",",str(StartCol,0,0),".\n")
   #end

   #local CurrRow = StartRow;
   #local CurrCol = StartCol;
   #local NumUnusedCells = NumUnusedCells - 1;

   #local CreatingPath = 1;
   #while ( CreatingPath = 1 )

      #local Direction = RandInt( 4, S );
      #local Attempt = 0;
      #local Success = 0;

      #while ( ( Attempt < 4 ) & ( Success = 0 ) )

         #if ( DoDebug )
            #debug concat("Maze: Attempting direction ",str(Direction,0,0),".\n")
         #end

         #switch ( Direction )
            #case ( 0 )  // North
               #if ( CurrRow > 0 )  // Proceed if not at edge.
                  #local NextRow = CurrRow - 1;
                  #local NextCol = CurrCol;
                  #local NextCellValue = Grid[ NextRow ][ NextCol ];
                  #if ( NextCellValue >= 0 )
                     // Next cell in selected direction not blocked.
                     #local Success = 1;
                     #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] - 1;
                     #if ( NextCellValue = 0 )
                        // Next cell unused, so set to direction value for current path.
                        #local Grid[ NextRow ][ NextCol ] = -8;
                     #else
                        // Next cell on previous path, so add in the new direction value.
                        #local Grid[ NextRow ][ NextCol ] = NextCellValue + 8;
                     #end
                  #end
               #end
               #break

            #case ( 1 )  // East
               #if ( CurrCol < ( Cols-1 ) )
                  #local NextRow = CurrRow;
                  #local NextCol = CurrCol + 1;
                  #local NextCellValue = Grid[ NextRow ][ NextCol ];
                  #if ( NextCellValue >= 0 )
                     #local Success = 1;
                     #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] - 2;
                     #if ( NextCellValue = 0 )
                        #local Grid[ NextRow ][ NextCol ] = -4;
                     #else
                        #local Grid[ NextRow ][ NextCol ] = NextCellValue + 4;
                     #end
                  #end
               #end
               #break

            #case ( 2 )  // West
               #if ( CurrCol > 0 )
                  #local NextRow = CurrRow;
                  #local NextCol = CurrCol - 1;
                  #local NextCellValue = Grid[ NextRow ][ NextCol ];
                  #if ( NextCellValue >= 0 )
                     #local Success = 1;
                     #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] - 4;
                     #if ( NextCellValue = 0 )
                        #local Grid[ NextRow ][ NextCol ] = -2;
                     #else
                        #local Grid[ NextRow ][ NextCol ] = NextCellValue + 2;
                     #end
                  #end
               #end
               #break

            #else  // South
               #if ( CurrRow < ( Rows-1 ) )
                  #local NextRow = CurrRow + 1;
                  #local NextCol = CurrCol;
                  #local NextCellValue = Grid[ NextRow ][ NextCol ];
                  #if ( NextCellValue >= 0 )
                     #local Success = 1;
                     #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] - 8;
                     #if ( NextCellValue = 0 )
                        #local Grid[ NextRow ][ NextCol ] = -1;
                     #else
                        #local Grid[ NextRow ][ NextCol ] = NextCellValue + 1;
                     #end
                  #end
               #end
         #end  // switch ( Direction )

         #if ( Success = 0 )  // Attempted direction is blocked.
            #local Attempt = Attempt + 1;
            #local Direction = ( Direction = 3 ? 0 : Direction + 1 );
         #else
            #if ( NextCellValue > 0 )  // Reached a cell of a previous path.
               #local CreatingPath = 0;
            #else
               #local NumUnusedCells = NumUnusedCells - 1;
            #end
         #end

      #end  // while ( ( Attempt < 4 ) & ( Success = 0 ) )

      #if ( Success = 0 )
         // All directions blocked.  Mark current cell accordingly and back up.
         #if ( DoDebug )
            #debug "Maze: All directions blocked.  Backing up!\n"
         #end

         #local CurrCellValue = Grid[ CurrRow ][ CurrCol ];
         #local Grid[ CurrRow ][ CurrCol ] = -99;
         #switch ( CurrCellValue )
            #case ( -1 )
               #local CurrRow = CurrRow - 1;  
               #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] + 8;
               #break
            #case ( -2 )
               #local CurrCol = CurrCol + 1;
               #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] + 4;
               #break
            #case ( -4 )
               #local CurrCol = CurrCol - 1;
               #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] + 2;
               #break
            #else
               #local CurrRow = CurrRow + 1;
               #local Grid[ CurrRow ][ CurrCol ] = Grid[ CurrRow ][ CurrCol ] + 1;
         #end
         #local NumUnusedCells = NumUnusedCells + 1;
      #else
         // Advance to the next cell selected for current path.
         #if ( DoDebug )
            #debug concat("Maze: Advancing to ",str(NextRow,0,0),",",str(NextCol,0,0),".\n")
         #end
         #local CurrRow = NextRow;
         #local CurrCol = NextCol;
      #end

   #end  // while ( CreatingPath = 1 )

   // Prepare for selection of next path's starting cell.
   #local NewStartCellNum = RandInt( NumUnusedCells, S );
   #local N = 0;

   // Adjust cell values of current path.  Also select next path's starting cell.
   #local R = 0;
   #while ( R < Rows )
      #local C = 0;
      #while ( C < Cols )
         #local CurrCellValue = Grid[R][C];
         #if ( CurrCellValue < 0 )
            #if ( CurrCellValue = -99 )
               #local Grid[R][C] = 0;
            #else
               #local Grid[R][C] = -1 * CurrCellValue;
            #end
         #end
         #if ( CurrCellValue = 0 | CurrCellValue = -99 )
            #if ( N = NewStartCellNum )
               #local StartRow = R;
               #local StartCol = C;
            #end
            #local N = N + 1;
         #end
         #local C = C + 1;
      #end
      #local R = R + 1;
   #end

   #if ( DoDebug )
      #debug concat("Maze: Path complete.  Number of unused cells = ",str(NumUnusedCells,0,0),".\n")
   #end

#end  // while ( NumUnusedCells > 0 )


// Now that we have a grid full of direction values, let's create a maze.
difference {
   // We create a bunch of solid walls...
   union {
      #local R = 0;
      #while ( R <= Rows )
         box { <-0.05, 0, R-0.05>, <Cols+0.05, WallHeight, R+0.05> }
         #local R = R + 1;
      #end
      #local C = 0;
      #while ( C <= Cols )
         box { <C-0.05, 0, -0.05>, <C+0.05, WallHeight, Rows+0.05> }
         #local C = C + 1;
      #end
   }
   // ... and cut openings based on the direction values.
   #if ( StartEdge = 0 )
      box { <InitialCol+0.0501, -1, Rows-0.1>, <InitialCol+0.9499, WallHeight+1, Rows+0.1> }
   #else
      box { <-0.1, -1, Rows-InitialRow-0.9499>, <0.1, WallHeight+1, Rows-InitialRow-0.0501> }
   #end
   #local R = 0;
   #while ( R < Rows )
      #local C = 0;
      #while ( C < Cols )
         #if ( HasSouthValue( Grid[R][C] ) )
            box { <C+0.0501, -1, Rows-R-1.1>, <C+0.9499, WallHeight+1, Rows-R-0.9> }
         #end
         #if ( HasEastValue( Grid[R][C] ) )
            box { <C+0.9, -1, Rows-R-0.9499>, <C+1.1, WallHeight+1, Rows-R-0.0501> }
         #end
         #local C = C + 1;
      #end
      #local R = R + 1;
   #end
}


// End of macro Maze
#end
