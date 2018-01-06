with Ada.Text_IO;
with AOC.Hash; 

package body AOC.Solver is
   use AOC.Hash;

   Input_File_Name : constant String := "day10/input.txt";
   
   function Part_1 return Integer
   is
      Knot_Hash : Knot_Hash_Type;
      Input : constant Integer_Vec := 
         Get_File_Integer_Vec (Input_File_Name);
   begin
      Initialize (Knot_Hash);
      Knot_Sparse_Hash_Round (Knot_Hash, Create_Length_List (Input));

      return Integer (Knot_Hash.List (0)) * Integer (Knot_Hash.List (1));
   end Part_1;

   function Part_2 return String
   is
      Input : constant String := 
         Get_File_String (Input_File_Name);
   begin
      return Knot_Hash_Of_String (Input);
   end Part_2;

   procedure Run is
      use Ada.Text_IO;
   begin
      Put_Line ("Part 1: " & Part_1'Img);
      Put_Line ("Part 2: " & Part_2);
   end Run;

end AOC.Solver;