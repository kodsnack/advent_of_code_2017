with Ada.Text_IO;

package body AOC.Solver is

   type Direction_Type is (N, Ne, Se, S, Sw, Nw);
   --    \ n  /            y
   --  nw +--+ ne           \
   --    /    \              \
   --  -+      +-             ----- x
   --    \    /              /
   --  sw +--+ se           /
   --    / s  \            z

   type Dir_List is array (Natural range <>) of Direction_Type;

   type Hex_Coord is record
      X, Y, Z : Integer;
   end record;

   Delta_Coord : constant array (Direction_Type) of Hex_Coord :=
      (N  => (0,1,-1), 
       Ne => (1,0,-1), 
       Se => (1,-1,0), 
       S  => (0,-1,1), 
       Sw => (-1,0,1), 
       Nw => (-1,1,0));

   type Position_Type is record
      Coord        : Hex_Coord := (0, 0, 0);
      Max_Distance : Natural   := 0;
   end record;

   function "+" (H1, H2 : in Hex_Coord) return Hex_Coord
   is
   begin
      return (H1.X + H2.X, H1.Y + H2.Y, H1.Z + H2.Z);
   end "+";

   function Distance (H1 : in Hex_Coord;
                      H2 : in Hex_Coord := (0, 0, 0)) 
                      return Natural
   is
   begin
      return (abs (H1.X - H2.X) + abs (H1.Y - H2.Y) + abs (H1.Z - H2.Z)) / 2;
   end Distance;

   procedure Move (Pos          : in out Position_Type;
                   To_Direction : in     Direction_Type)
   is
   begin
      Pos.Coord := Pos.Coord + Delta_Coord (To_Direction);
      Pos.Max_Distance := Natural'Max (Pos.Max_Distance, Distance (Pos.Coord));
   end Move;

   function Create_Direction_List (Input : in String)
                                   return Dir_List
   is
      Splitted : String_Vec;
   begin
      Split_String_At_Char (Input, ',', Splitted);

      declare
         List : Dir_List (Splitted.First_Index .. Splitted.Last_Index);
      begin
         for I in List'Range loop
            --  Assume lower case only...
            if Splitted.Element (I) = "n"  then
               List (I) := N;
            elsif Splitted.Element (I) = "ne" then
               List (I) := Ne;
            elsif Splitted.Element (I) = "se" then
                List (I) := Se;
            elsif Splitted.Element (I) = "s"  then
               List (I) := S;
            elsif Splitted.Element (I) = "sw" then
                List (I) := Sw;
            elsif Splitted.Element (I) = "nw" then
               List (I) := Nw;
            else
               raise Constraint_Error;
            end if;
         end loop;

         return List;
      end;
   end Create_Direction_List;

   function Part_1 (Walker : in out Position_Type;
                    Input  : in     Dir_List)
                    return Natural
   is
   begin
      for Direction of Input loop
         Move (Walker, Direction);
      end loop;

      return Distance (Walker.Coord);
   end Part_1;

   function Part_2 (Walker : in Position_Type)
                    return Natural
   is
   begin
      return Walker.Max_Distance;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : constant Dir_List := 
         Create_Direction_List (Get_File_String ("day11/input.txt"));
      Walker : Position_Type;
   begin
      Put_Line ("Part 1: " & Part_1 (Walker, Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Walker)'Img);
   end Run;

end AOC.Solver;