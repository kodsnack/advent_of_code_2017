with Ada.Text_IO;

package body AOC.Solver is

   type Cleaning_Parser is record
      Skip_Next  : Boolean := False;
      Is_Garbage : Boolean := False;
      Nof_Non_Skipped_Garbage : Natural := 0;
   end record;

   function Process_Character (Parser : in out Cleaning_Parser;
                               Input  : in     Character)
                               return Character
   is
      Nul : constant Character := Character'Val (0);
   begin
      if Parser.Skip_Next then
         Parser.Skip_Next := False;

         return Nul;
      end if;

      if Input = '!' then
         Parser.Skip_Next := True;

         return Nul;
      end if;

      if Parser.Is_Garbage then
      
         if Input = '>' then
            Parser.Is_Garbage := False;

            return Nul;
         end if;

         Parser.Nof_Non_Skipped_Garbage := 
            Natural'Succ (Parser.Nof_Non_Skipped_Garbage);

         return Nul;
      end if;

      if Input = '<' then
         Parser.Is_Garbage := True;

         return Nul;
      end if;

      return Input;
   end Process_Character;

   function Part_1 (Input  : in     String;
                    Parser : in out Cleaning_Parser)
                    return Natural
   is
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

   function Part_2 (Parser : in Cleaning_Parser)
                    return Natural
   is
   begin
      return Parser.Nof_Non_Skipped_Garbage;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : constant String := 
         AOC.Get_File_String ("day09/input.txt");

      Parser : Cleaning_Parser;
   begin
      Put_Line ("Part 1: " & Part_1 (Input, Parser)'Img);
      Put_Line ("Part 2: " & Part_2 (Parser)'Img);
   end Run;

end AOC.Solver;