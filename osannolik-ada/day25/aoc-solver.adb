with Ada.Text_IO;

package body AOC.Solver is

   Match_State : constant String := "In state ";
   Match_Next  : constant String := "    - Continue with state ";
   Match_Init  : constant String := "Begin in state ";

   type Tape_Type is array (Integer range <>) of Boolean;

   type Tape_Ref is access all Tape_Type;

   type Machine is record
      Tape       : Tape_Ref;
      Cursor     : Integer := 0;
      Nof_Cycles : Natural;
      State      : Integer;
   end record;

   type Rule is record
      Write_Value : Boolean;
      Move        : Integer;
      Next_State  : Natural;
   end record;

   type State is record
      True_Rule  : Rule;
      False_Rule : Rule;
   end record;

   type Instructions is array (Natural range <>) of State;

   function Get_Nof_Cycles (Input : in String_Vec) return Natural is
      Tmp : String_Vec;
   begin
      Split_String_At_Char 
         (S       => To_String (Input.Element (Input.First_Index + 1)),
          Char    => ' ',
          Strings => Tmp);
      return To_Integer (Tmp.Element (Tmp.Last_Index - 1));
   end Get_Nof_Cycles;

   function Create_Tape (Size : in Natural) return Tape_Ref is
      Tape : constant Tape_Ref := new Tape_Type (-Size .. Size);
   begin
      return Tape;
   end Create_Tape;

   function Create_Names (Input : in String_Vec)
                          return String_Vec
   is
      Names : String_Vec;
   begin
      for Row of Input loop
         if 0 /= Index (Row, Match_State) then
            Names.Append 
               (Unbounded_Slice (Row, Match_State'Length + 1, Length (Row) - 1));
         end if;
      end loop;
      return Names;
   end Create_Names;

   function Create_Rule (Input   : in String_Vec;
                         Names   : in String_Vec;
                         I_Start : in Natural)
                         return Rule
   is
      Action      : constant UString := Input.Element (I_Start);
      Value       : constant Integer :=
         To_Integer (Element (Action, Length (Action) - 1));
      Next        : constant UString := Input.Element (I_Start + 2);
      Next_Name   : constant UString := 
         Unbounded_Slice (Next, Match_Next'Length + 1, Length (Next) - 1);
      Move        : Integer := -1;
      Write_Value : Boolean := False;
   begin
      if 0 /= Index (Input.Element (I_Start + 1), "right") then
         Move := 1;
      end if;

      if Value /= 0 then
         Write_Value := True;
      end if;

      return (Write_Value => Write_Value, 
              Move        => Move, 
              Next_State  => Names.Find_Index (Next_Name));
   end Create_Rule;

   procedure Create_Program (Input   : in     String_Vec;
                             Names   : in     String_Vec;
                             Program :    out Instructions) 
   is
   begin
      for I in Names.First_Index .. Names.Last_Index loop
         declare
            Match : constant String := Match_State & To_String (Names.Element (I));
         begin
            for R in Input.First_Index .. Input.Last_Index loop
               if 0 /= Index (Input.Element (R), Match) then
                  Program (I) := 
                      --  Assume false rule is first...
                     (False_Rule => Create_Rule (Input, Names, R+2),
                      True_Rule  => Create_Rule (Input, Names, R+6));
               end if;
            end loop;
         end;
      end loop;
   end Create_Program;

   function Initialize_Machine (Input : in String_Vec;
                                Names : in String_Vec;
                                Tape  : in Tape_Ref)
                                return Machine
   is
      Init_State_Name : constant UString := Unbounded_Slice 
         (Input.First_Element, Match_Init'Length + 1, Length (Input.First_Element) - 1);
   begin
      return (Tape          => Tape,
              Cursor        => 0,
              Nof_Cycles    => Get_Nof_Cycles (Input),
              State => Names.Find_Index (Init_State_Name));
   end Initialize_Machine;

   procedure Update (M : in out Machine;
                     R : in     Rule)
   is
   begin
      M.Tape (M.Cursor) := R.Write_Value;
      M.Cursor          := M.Cursor + R.Move;
      M.State           := R.Next_State;
   end Update;

   procedure Execute (M       : in out Machine;
                      Program : in     Instructions)
   is
   begin
      for I in 1 .. M.Nof_Cycles loop
         if M.Tape (M.Cursor) then
            Update (M, Program (M.State).True_Rule);
         else
            Update (M, Program (M.State).False_Rule);
         end if;
      end loop;
   end Execute;

   function Sum (Tape : in Tape_Ref) return Natural is
      Tmp : Natural := 0;
   begin
      for V of Tape.all loop
         if V then
            Tmp := Tmp + 1;
         end if;
      end loop;
      return Tmp;
   end Sum;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day25/input.txt");

      declare
         Names   : constant String_Vec := Create_Names (Input);
         Tape    : constant Tape_Ref := Create_Tape (Size => Get_Nof_Cycles (Input));
         Program : Instructions (Names.First_Index .. Names.Last_Index);
         Turing  : Machine := Initialize_Machine (Input, Names, Tape);
      begin
         Create_Program (Input, Names, Program);

         Execute (Turing, Program);

         Put_Line ("Part 1: " & Sum (Tape)'Img);
         Put_Line ("Part 2: > reboot printer");
      end;

   end Run;

end AOC.Solver;