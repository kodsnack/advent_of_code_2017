with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;

package body AOC.Solver is

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

   type Direction is (New_Lap, Up, Left, Down, Right);

   type Step_Array is array (Direction'Range) of Positive;

   type Position_Generator is tagged limited record
      Current_Position  : Point      := (0, 0);
      Current_Direction : Direction  := New_Lap;
      Step              : Natural    := 0;
      Nof_Steps         : Step_Array :=
         (New_Lap => 1,
          Up      => 1,
          Left    => 2,
          Down    => 2,
          Right   => 2);
   end record;

   procedure Update_Position (PG : in out Position_Generator)
   is
      --  Generate spiraling coordinates
      Delta_Pos : constant array (Direction'Range) of Point :=
         (New_Lap => (1, 0), 
          Up      => (0, 1), 
          Left    => (-1, 0), 
          Down    => (0, -1), 
          Right   => (1, 0));
   begin
      if PG.Step >= PG.Nof_Steps (PG.Current_Direction) then
         PG.Step := 0;

         if PG.Current_Direction = Direction'Last then
            PG.Current_Direction := Direction'First;
            for Dir in Up .. Right loop
               PG.Nof_Steps (Dir) := PG.Nof_Steps (Dir) + 2;
            end loop;
         else
            PG.Current_Direction := Direction'Succ (PG.Current_Direction);
         end if;

      end if; 

      PG.Current_Position := 
         PG.Current_Position + Delta_Pos (PG.Current_Direction);

      PG.Step := Natural'Succ (PG.Step);
   end Update_Position;

   function Sum_Neighbors (Data : in Natural_2D;
                           P    : in Point)
                           return Natural
   is
      function Get_Value (Data : in Natural_2D;
                          P    : in Point)
                          return Natural
      is
      begin
         if P.X in Data'Range (1) and
            P.Y in Data'Range (2) 
         then
            return Data (P.X, P.Y);
         end if;

         return 0;
      end Get_Value;

      Kernel_Idx_Offset : constant array (1 .. 8) of Point :=
         ((-1, 1),  (0, 1),  (1, 1), 
          (-1, 0),           (1, 0), 
          (-1, -1), (0, -1), (1, -1));

      Sum : Natural := 0;
   begin
      for Offset of Kernel_Idx_Offset loop
         Sum := Sum + Get_Value (Data, P + Offset);
      end loop;

      return Sum;
   end Sum_Neighbors;

   function Part_2 (Input : in Natural)
                    return Natural
   is
      Spiral_Coord : Position_Generator;

      Size         : constant := 5;
      Memory       : Natural_2D (-Size .. Size, -Size .. Size) := 
         (others => (others => 0)); --  Hopefully big enough static...

      P : Point := (0, 0);
   begin
      Memory (P.X, P.Y) := 1;

      while Memory (P.X, P.Y) <= Input loop
         Spiral_Coord.Update_Position;

         P := Spiral_Coord.Current_Position;

         Memory (P.X, P.Y) := Sum_Neighbors (Memory, P);
      end loop;

      return Memory (P.X, P.Y);
   end Part_2;

   procedure Run is 
      Input : constant Natural :=
         Natural'Value (Get_File_String ("day03/input.txt"));
   begin
      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Ada.Text_IO.Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;