with Ada.Text_IO;

package body AOC.Solver is

   type Cleaning_Parser is record
      Skip_Next  : Boolean := False;
      Is_Garbage : Boolean := False;
   end record;

   function Process_Character (S : in out Cleaning_Parser;
                               Input : in Character)
                               return Character
   is
      Nul : constant Character := Character'Val (0);
   begin
      if S.Skip_Next then
         S.Skip_Next := False;

         return Nul;
      end if;

      if Input = '!' then
         S.Skip_Next := True;

         return Nul;
      end if;

      if S.Is_Garbage then
      
         if Input = '>' then
            S.Is_Garbage := False;
         end if;

         return Nul;
      end if;

      if Input = '<' then
         S.Is_Garbage := True;

         return Nul;
      end if;

      return Input;
   end Process_Character;

   function Part_1 (Input : in String)
                    return Natural
   is
      Parser : Cleaning_Parser;

      Group : Natural := 0;
      Score : Natural := 0;
   begin
      for C of Input loop
         declare
            C_Out : constant Character := Process_Character (Parser, C);
         begin
            if C_Out = '{' then
               Group := Natural'Succ (Group);
               Score := Score + Group;
            elsif C_Out = '}' then
               Group := Natural'Pred (Group);
            end if;
         end;
      end loop;

      return Score;
   end Part_1;

   procedure Run is
      use Ada.Text_IO;

      Input : constant String := 
         AOC.Get_File_String ("day09/input.txt");
   begin
      Put_Line ("Part 1: " & Part_1 (Input)'Img);
   end Run;

end AOC.Solver;