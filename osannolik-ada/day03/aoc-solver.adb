with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;

package body AOC.Solver is

   type Point is record
      X, Y : Integer := 0;
   end record;

   function Manhattan_Distance (P1 : in Point;
                                P2 : in Point := (0, 0))
                                return Natural
   is
   begin
      return abs (P1.X - P2.X) + abs (P1.Y - P2.Y);
   end Manhattan_Distance;

   function Part_1 (Input : in Natural)
                    return Natural
   is
      use Ada.Numerics.Elementary_Functions;

      D_Stop : Integer := 
         Integer (Float'Ceiling (Sqrt (Float (Input))));
      D_Start : Integer;

      -- P1 = D^2
      -- P3 = D^2 - 2 * (D + 2) + 2;
      -- P4 = D^2 - (D + 2) + 1;
      -- P2 = D^2 - 3 * (D + 2) + 3;

      Stop        : Integer; --  = Bottom Right
      Start       : Integer; --  The number above Stop
      Top_Right   : Integer;
      Top_Left    : Integer;
      Bottom_Left : Integer;

      P : Point;
   begin

      if Input = 1 then
         return 0;
      end if;

      if D_Stop mod 2 = 0 then
         --  Force uneven
         D_Stop := D_Stop + 1;
      end if;

      D_Start := D_Stop - 2;

      Stop  := D_Stop ** 2;
      Start := D_Start ** 2 + 1;

      Top_Right   := Stop - 3 * (D_Start + 2) + 3;
      Top_Left    := Stop - 2 * (D_Start + 2) + 2;
      Bottom_Left := Stop - (D_Start + 2) + 1;

      if Input in Start .. Stop then

         if Input in Start .. Top_Right then
            P := ((D_Start + 1) / 2,
                  abs (Top_Right - (Top_Right - Start + 1) / 2 - Input));

         elsif Input in Top_Right .. Top_Left then
            P := (abs ((Top_Right + Top_Left) / 2 - Input),
                  (D_Start + 1) / 2);

         elsif Input in Top_Left .. Bottom_Left then
            P := ((D_Start + 1) / 2,
                  abs ((Top_Left + Bottom_Left) / 2 - Input));

         elsif Input in Bottom_Left .. Stop then
            P := (abs ((Bottom_Left + Stop) / 2 - Input),
                  (D_Start + 1) / 2);
         end if;

      end if;

      return Manhattan_Distance (P);
   end Part_1;

   procedure Run is 
      Input : constant Natural :=
         Natural'Value (Get_File_String ("day03/input.txt"));
   begin
      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
   end Run;

end AOC.Solver;