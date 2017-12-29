with Ada.Text_IO;

package body AOC.Solver is

   function Part_1 (Input      : in  Integer_Array;
                    Stop_State : out Integer_Array)
                    return Natural
   is
      subtype Bank_Index is Natural range Input'First .. Input'Last;

      type Banks_List is new Integer_Array (Bank_Index'Range);

      package State_List is new Ada.Containers.Vectors
         (Natural,
          Banks_List);

      Banks : Banks_List := Banks_List (Input);

      State_History : State_List.Vector;

      B : Bank_Index;
      Blocks : Natural;

      Nof_Cycles : Natural := 0;
   begin

      while not State_History.Contains (Banks) loop
         State_History.Append (Banks);

         Blocks := Max (Integer_Array (Banks), B);

         Banks (B) := 0;

         while Blocks > 0 loop
            if B = Banks'Last then
               B := Banks'First;
            else
               B := B + 1;
            end if;

            Banks (B) := Banks (B) + 1;
            Blocks := Blocks - 1;
         end loop;

         Nof_Cycles := Natural'Succ (Nof_Cycles);
      end loop;
      
      Stop_State := Integer_Array (Banks);

      return Nof_Cycles;
   end Part_1;

   function Part_2 (Input : in Integer_Array)
                    return Natural
   is
      Dummy : Integer_Array (Input'Range);
      pragma Unreferenced (Dummy);
   begin
      return Part_1 (Input, Dummy);
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : constant String := 
         AOC.Get_File_String ("day06/input.txt");
      Splitted_String : V_String.Vector;
   begin
      Split_String_At_Char (S       => Input,
                            Char    => Ascii.Ht,
                            Strings => Splitted_String);
      declare
         Nof_Blocks_In_Bank : constant Integer_Array := 
            To_Integer_Array (Splitted_String);
         Stop_State : Integer_Array (Nof_Blocks_In_Bank'Range);
      begin
         Put_Line ("Part 1: " & Part_1 (Nof_Blocks_In_Bank, Stop_State)'Img);
         Put_Line ("Part 2: " & Part_2 (Stop_State)'Img);
      end;

   end Run;

end AOC.Solver;