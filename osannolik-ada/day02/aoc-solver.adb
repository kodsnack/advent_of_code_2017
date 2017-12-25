with Ada.Text_IO;

package body AOC.Solver is

   type Integer_Array is array (Positive range <>) of Integer;

   function Char_Separated_String_To_Integer_Array
      (S : in String;
       C : in Character)
       return Integer_Array
   is
      N : Integer := 0;
   begin
      for I in S'Range loop
         if S (I) = C then
            N := N + 1;
         end if;
      end loop;

      N := Integer'Succ (N);
      
      declare
         J : Integer := 1;
         List : Integer_Array (1 .. N);
      begin
         N := List'First;

         for I in S'Range loop
            if S (I) = C then
               List (N) := Integer'Value (S (J .. I-1));
               J := Integer'Succ (I);
               N := Integer'Succ (N);
            end if;
         end loop;

         List (N) := Integer'Value (S (J .. S'Last));

         return List;
      end;
   end Char_Separated_String_To_Integer_Array;

   function Part_1 (Input : in String_Array) 
                    return Natural
   is
      Sum : Natural := 0;
   begin

      for Row of Input loop
         declare
            List : constant Integer_Array := 
               Char_Separated_String_To_Integer_Array
                  (S => To_String (Row),
                   C => Ascii.Ht);
            Max : Integer := List (List'First);
            Min : Integer := Max;
         begin
            for I of List loop
               Max := Integer'Max (Max, I);
               Min := Integer'Min (Min, I);
            end loop;
            
            Sum := Sum + (Max - Min);
         end;
      end loop;

      return Sum;

   end Part_1;

   function Part_2 (Input : in String_Array) 
                    return Natural
   is
      Sum : Natural := 0;
   begin

      for Row of Input loop
         declare
            List : constant Integer_Array := 
               Char_Separated_String_To_Integer_Array
                  (S => To_String (Row),
                   C => Ascii.Ht);
            Found_It : Boolean := False;
         begin

            for I in List'Range loop   
               for J in List'Range loop

                  Found_It := (I /= J) and then (List (I) mod List (J) = 0);
                  if Found_It then
                     Sum := Sum + List (I) / List (J);
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
      Input : constant String_Array := 
         AOC.Get_File_Rows ("day02/input.txt");
   begin
      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Ada.Text_IO.Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;