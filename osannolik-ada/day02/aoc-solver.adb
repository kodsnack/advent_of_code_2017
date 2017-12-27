with Ada.Text_IO;

package body AOC.Solver is

   type Integer_Table_Type is array (Integer range <>) of V_Integer.Vector;

   function Part_1 (Integer_Table : in Integer_Table_Type)
                    return Natural
   is
      Sum : Integer := 0;
   begin
      for Row of Integer_Table loop
         declare
            Max : Integer := Row.First_Element;
            Min : Integer := Row.First_Element;
         begin
            for I of Row loop
               Max := Integer'Max (Max, I);
               Min := Integer'Min (Min, I);
            end loop;

            Sum := Sum + (Max - Min);
         end;
      end loop;

      return Sum;
   end Part_1;

   function Part_2 (Integer_Table : in Integer_Table_Type)
                    return Natural
   is
      Sum : Integer := 0;
   begin
      for Row of Integer_Table loop
         declare
            Values   : constant Integer_Array := To_Integer_Array (Row);
            Found_It : Boolean := False;
         begin
            for I in Values'Range loop
               for J in Values'Range loop
                  Found_It := (I /= J) and then (Values (I) mod Values (J) = 0);
                  if Found_It then
                     Sum := Sum + Values (I) / Values (J);
                  end if;

                  exit when Found_It;
               end loop; 
               exit when Found_It;
            end loop;
         end;
      end loop;

      return Sum;
   end Part_2;

   procedure Run is 
      Input            : V_String.Vector;
      Splitted_Strings : V_String.Vector;
   begin
      Get_File_Rows (Input, "day02/input.txt");

      declare
         Integer_Table : Integer_Table_Type 
            (Input.First_Index .. Input.Last_Index);
      begin
         for R in Input.First_Index .. Input.Last_Index loop
            Split_String_At_Char
               (S       => To_String (Input.Element (R)),
                Char    => Ascii.Ht,
                Strings => Splitted_Strings);

            for Substring of Splitted_Strings loop
               Integer_Table (R).Append 
                  (Integer'Value (To_String (Substring)));
            end loop;
         end loop;

         Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Integer_Table)'Img);
         Ada.Text_IO.Put_Line ("Part 2: " & Part_2 (Integer_Table)'Img);
      end;

   end Run;

end AOC.Solver;