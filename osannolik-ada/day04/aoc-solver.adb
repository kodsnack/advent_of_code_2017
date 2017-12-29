with Ada.Text_IO;

package body AOC.Solver is

   function Part_1 (Input : in V_String.Vector)
                    return Natural
   is
      Row_Words : V_String.Vector;
      Nof_Correct : Natural := Natural (Input.Length);
   begin
      for R in Input.First_Index .. Input.Last_Index loop
         Split_String_At_Char
            (S       => To_String (Input.Element (R)),
             Char    => ' ',
             Strings => Row_Words);

         declare
            Found_Non_Unique : Boolean := False;
            Words : constant String_Array := 
               To_String_Array (Row_Words);
         begin

            Found_Non_Unique := False;

            for I in Words'Range loop
               for J in Words'Range loop
                  Found_Non_Unique :=  I /= J and Words (I) = Words (J);

                  exit when Found_Non_Unique;
               end loop;
               exit when Found_Non_Unique;
            end loop;

            if Found_Non_Unique then
               Nof_Correct := Nof_Correct - 1;
            end if;

         end;
      end loop;

      return Nof_Correct;
   end Part_1; 

   procedure Run is 
      Input            : V_String.Vector;
   begin
      Get_File_Rows (Input, "day04/input.txt");

      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
   end Run;

end AOC.Solver;