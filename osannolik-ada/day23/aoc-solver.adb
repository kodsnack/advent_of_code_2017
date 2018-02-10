with Ada.Text_IO;

package body AOC.Solver is

   Syntax_Error : Exception;

   type Reg_Data is range -(2**63) .. +(2**63 - 1);

   type Reg_Array is array (Integer range <>) of Reg_Data;
   
   type Reg_Value_Kind is (Immediate, Register);

   type Immediate_Reg (Kind : Reg_Value_Kind := Immediate) is record
      case Kind is
         when Immediate =>
            Imm : Reg_Data;
         when Register =>
            Reg : Natural;
      end case;
   end record; 

   function Image (R_Or_V : in Immediate_Reg) return String
   is
   begin
      case R_Or_V.Kind is
         when Immediate =>
            return "V" & Integer (R_Or_V.Imm)'Img;
         when Register =>
            return "R" & Integer (R_Or_V.Reg)'Img;
      end case;
   end Image;

   type Instruction_Kind is 
      (Set, Sub, Multiply, Jumpz);

   type Instruction_Type is record
      Kind : Instruction_Kind;
      X, Y : Immediate_Reg;
   end record;

   type Asm_List is array (Natural range <>) of Instruction_Type;

   type Calls_Array is array (Instruction_Kind'Range) of Reg_Data;

   type Program_Type (Max_Idx : Natural) is record 
      Asm       : Asm_List (0 .. Max_Idx);
      PC        : Natural;
      Nof_Calls : Calls_Array := (others => 0);
   end record;

   function Get_Value (Registers : in Reg_Array;
                       V_Or_R    : in Immediate_Reg)
                       return Reg_Data
   is
   begin
      case V_Or_R.Kind is
         when Immediate =>
            return V_Or_R.Imm;
         when Register =>
            return Registers (V_Or_R.Reg);
      end case;
   end Get_Value;

   procedure Set_Value (Registers : in out Reg_Array;
                        Reg       : in     Natural;
                        Value     : in     Immediate_Reg)
   is
   begin
      Registers (Reg) := Get_Value (Registers, Value);
   end Set_Value;

   function Get_Register_Index (Name_Map : in out String_Vec;
                                Name     : in     UString)
                                return Natural
   is
   begin
      if not Name_Map.Contains (Name) then
         Name_Map.Append (Name);
         return Name_Map.Last_Index;
      end if;

      return Name_Map.Find_Index (Name);
   end Get_Register_Index;

   function Create_Imm_Or_Reg (S        : in     UString;
                               Name_Map : in out String_Vec)
                               return Immediate_Reg
   is
      Tmp : constant String := To_String (S);
   begin
      if Tmp (Tmp'First) in 'a' .. 'z' then
         return (Kind => Register,
                 Reg  => Get_Register_Index (Name_Map, S));
      else
         return (Kind => Immediate,
                 Imm  => Reg_Data (To_Integer (S)));
      end if;
   end Create_Imm_Or_Reg;

   function Get_Instruction_Kind (Op : in UString)
                                  return Instruction_Kind
   is
   begin
      if Op = "set" then
         return Set;
      elsif Op = "sub" then
         return Sub;
      elsif Op = "mul" then
         return Multiply;
      elsif Op = "jnz" then
         return Jumpz;
      else
         raise Syntax_Error;
      end if;
   end Get_Instruction_Kind;

   function Create_Program (Input    : in     String_Vec;
                            Name_Map : in out String_Vec)
                            return Program_Type
   is
      Args : String_Vec;
      Program : Program_Type (Input.Last_Index);
   begin
      for R in Program.Asm'Range loop
         Split_String_At_Char (To_String (Input.Element (R)), ' ', Args);
         declare
            Op : constant UString := Args.First_Element;
         begin
            Args.Delete_First;
            Program.Asm (R) := 
               (Kind => Get_Instruction_Kind (Op),
                X    => Create_Imm_Or_Reg (Args.First_Element, Name_Map),
                Y    => Create_Imm_Or_Reg (Args.Last_Element, Name_Map));
         end;
      end loop;

      Program.PC := Program.Asm'First;

      return Program;
   end Create_Program;

   procedure Trace (S : in String; Enabled : in Boolean := False) is
   begin
      if Enabled then
         Ada.Text_IO.Put_Line (S);
      end if;
   end Trace;

   procedure Execute (Program   : in out Program_Type;
                      Registers : in out Reg_Array)
   is
      function Get (V_Or_R : in Immediate_Reg) return Reg_Data is
         (Get_Value (Registers, V_Or_R));

      procedure Set (Reg   : in Natural;
                     Value : in Immediate_Reg)
      is begin
         Set_Value (Registers, Reg, Value);
      end Set;

   begin
      while (Program.PC in Program.Asm'Range) loop
         declare
            I : constant Instruction_Type := Program.Asm (Program.PC);
         begin
            Trace ("Executing " & I.Kind'Img & 
                   "    " & Image (I.X) &
                   "    " & Image (I.Y));
            Program.Nof_Calls (I.Kind) := Program.Nof_Calls (I.Kind) + 1;
            case I.Kind is
               when Set =>
                  Set (Reg   => I.X.Reg,
                       Value => I.Y);
               when Sub =>
                  Set (Reg   => I.X.Reg,
                       Value => (Immediate, Get (I.X) - Get (I.Y)));
               when Multiply =>
                  Set (Reg   => I.X.Reg,
                       Value => (Immediate, Get (I.X) * Get (I.Y)));
               when Jumpz =>
                  if Get (I.X) /= 0 then
                     Program.PC := Program.PC + Integer (Get (I.Y)) - 1;
                  end if;
            end case;
         end;

         Program.PC := Natural'Succ (Program.PC);
      end loop;
   end Execute;

   function Part_1 (Input : in String_Vec)
                    return Reg_Data
   is
      Name_Map : String_Vec;
   begin
      declare
         Program : Program_Type := 
            Create_Program (Input, Name_Map);
         Registers : Reg_Array 
            (Name_Map.First_Index .. Name_Map.Last_Index) := (others => 0);

      begin
         Execute (Program, Registers);

         Ada.Text_IO.Put_Line
            (Registers (Get_Register_Index (Name_Map, To_UString ("h")))'Img);

         return Program.Nof_Calls (Multiply);
      end;
   end Part_1;

   function Part_2 return Natural
   is
      --  Analyzing the instructions gives the following
      --  program.
      --  Some optimizations makes it take a reasonable
      --  amount of time to run.
      --  Further optimizations probably possible.
      B : Natural := 93;
      C : Natural := B;
      D, H : Natural := 0;
      F : Boolean;
   begin
      --  a = 1 =>
      B := 100 * B + 100_000;
      C := B + 17_000;

      loop
         F := False;
         D := 2; -- Instead of 1

         loop
            -- E := 2;
            -- loop
            --    if E = B / D then
            --       F := 0;
            --    end if;
            --    E := E + 1;
            --    exit when E = B;
            -- end loop;

            -- The above can be replaced by:
            if (B mod D) = 0 then
               F := True;
            end if;

            D := D + 1;
            exit when F or else D = B;
         end loop;

         if F then
            H := H + 1;
         end if;

         exit when B = C;

         B := B + 17;

      end loop;

      return H;

   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day23/input.txt");

      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2'Img);
   end Run;

end AOC.Solver;