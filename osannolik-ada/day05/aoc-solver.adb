with Ada.Text_IO;

package body AOC.Solver is

   function Part_1 (Input : in Integer_Array)
                    return Natural
   is
      Instructions : Integer_Array := Input;

      Offset : Integer;

      PC : Natural := Instructions'First;

      Nof_Jumps : Natural := 0;
   begin
 
      while PC in Instructions'Range loop
         Offset := Instructions (PC);

         Instructions (PC) := Integer'Succ (Instructions (PC));
         
         PC := PC + Offset;

         Nof_Jumps := Natural'Succ (Nof_Jumps);
      end loop;

      return Nof_Jumps;
   end Part_1;

   function Part_2 (Input : in Integer_Array)
                    return Natural
   is
      Instructions : Integer_Array := Input;

      Offset : Integer;

      PC : Natural := Instructions'First;

      Nof_Jumps : Natural := 0;
   begin
 
      while PC in Instructions'Range loop
         Offset := Instructions (PC);
         
         if Offset >= 3 then
            Instructions (PC) := Integer'Pred (Instructions (PC));
         else
            Instructions (PC) := Integer'Succ (Instructions (PC));
         end if;

         PC := PC + Offset;

         Nof_Jumps := Natural'Succ (Nof_Jumps);
      end loop;

      return Nof_Jumps;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : V_Integer.Vector;
   begin
      Get_File_Rows (Input, "day05/input.txt");

      declare
         Instructions : constant Integer_Array := 
            To_Integer_Array (Input);
      begin
         Put_Line ("Part 1: " & Part_1 (Instructions)'Img);
         Put_Line ("Part 2: " & Part_2 (Instructions)'Img);
      end;

   end Run;

end AOC.Solver;