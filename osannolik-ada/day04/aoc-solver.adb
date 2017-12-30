with Ada.Text_IO;

package body AOC.Solver is

   function Is_Not_Equal (Word_A, Word_B : in Unbounded_String)
                          return Boolean
   is
   begin
      return Word_A /= Word_B;
   end Is_Not_Equal;

   function Is_Anagram (Word_A, Word_B : in Unbounded_String)
                            return Boolean
   is
      SA : constant String := To_String (Word_A);
      SB : constant String := To_String (Word_B);
   begin
      if SA'Length /= SB'Length then
         return False; --  Anagrams are equally long
      end if;

      if SA = SB then
         return True; --  Anagrams if identical
      end if;

      declare
         Count : array (Character'Range) of Integer := (others => 0);
      begin
         for C in SA'Range loop
            Count (SA (C)) := Count (SA (C)) + 1;
            Count (SB (C)) := Count (SB (C)) - 1;
         end loop;

         for N of Count loop
            if N /= 0 then
               --  Not the same number of occurences of some letter
               return False; 
            end if;
         end loop;
      end;

      return True;
   end Is_Anagram;

   function Calculate_Nof_Correct_Phrases
      (Input            : in V_String.Vector;
       Validity_Checker : access
         function (Word_A, Word_B : in Unbounded_String)
                   return Boolean)
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
            Found_Incorrect : Boolean := False;
            Words : constant String_Array := 
               To_String_Array (Row_Words);
         begin

            for I in Words'Range loop
               for J in Words'Range loop
                  Found_Incorrect := 
                     I /= J and not Validity_Checker (Words (I), Words (J));

                  exit when Found_Incorrect;
               end loop;
               exit when Found_Incorrect;
            end loop;

            if Found_Incorrect then
               Nof_Correct := Nof_Correct - 1;
            end if;

         end;
      end loop;

      return Nof_Correct;

   end Calculate_Nof_Correct_Phrases;

   function Part_1 (Input : in V_String.Vector)
                    return Natural
   is
   begin
      return Calculate_Nof_Correct_Phrases
         (Input            => Input,
          Validity_Checker => Is_Not_Equal'Access);
   end Part_1; 

   function Part_2 (Input : in V_String.Vector)
                    return Natural
   is
      function Is_Valid (Word_A, Word_B : in Unbounded_String)
                         return Boolean
      is
      begin
         return Is_Not_Equal (Word_A, Word_B) and 
                not Is_Anagram (Word_A, Word_B);
      end Is_Valid;
   begin
      return Calculate_Nof_Correct_Phrases
         (Input            => Input,
          Validity_Checker => Is_Valid'Access);
   end Part_2; 

   procedure Run is 
      Input : V_String.Vector;
   begin
      Get_File_Rows (Input, "day04/input.txt");
      --  Assume always lower case

      Ada.Text_IO.Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Ada.Text_IO.Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;