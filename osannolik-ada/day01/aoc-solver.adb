with Ada.Text_IO;

package body AOC.Solver is

   function Sum_If_Equal_At_Offset (Input  : in String;
                                    Offset : in Positive)
                                    return Natural
   is
      Sum : Natural := 0;
      I   : Integer := Input'First + Offset;
   begin
      for C of Input loop
         if C = Input (I) then
            Sum := Sum + To_Integer (C);
         end if;

         if I >= Input'Last then
            I := Input'First;
         else
            I := I + 1;
         end if;
      end loop;

      return Sum;
   end Sum_If_Equal_At_Offset;

   function Part_1 (Input : in String) 
                    return Natural 
   is
   begin
      return Sum_If_Equal_At_Offset
         (Input  => Input,
          Offset => 1);
   end Part_1;

   function Part_2 (Input : in String)
                    return Natural
   is
   begin
      return Sum_If_Equal_At_Offset
         (Input  => Input,
          Offset => Input'Length / 2);
   end Part_2;

   procedure Run is 
      Input : constant String := 
         AOC.Get_File_String ("day01/input.txt");
   begin
      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Ada.Text_IO.Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;