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
      (Soueeend, Set, Add, Multiply, Modulus, Recovers, Jump);

   type Instruction_Type is record
      Kind : Instruction_Kind;
      X, Y : Immediate_Reg;
   end record;

   type Asm_List is array (Natural range <>) of Instruction_Type;

   type Program_Type (Max_Idx : Natural) is record 
      Asm : Asm_List (0 .. Max_Idx);
      PC  : Natural;
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
      if Op = "snd" then
         return Soueeend;
      elsif Op = "set" then
         return Set;
      elsif Op = "add" then
         return Add;
      elsif Op = "mul" then
         return Multiply;
      elsif Op = "mod" then
         return Modulus;
      elsif Op = "rcv" then
         return Recovers;
      elsif Op = "jgz" then
         return Jump;
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

   procedure Execute (Program      : in out Program_Type;
                      Registers    : in out Reg_Array;
                      Snd_Callback : access procedure (Value : in  Reg_Data);
                      Rcv_Callback : access procedure (Value    : out Reg_Data;
                                                       Do_Abort : out Boolean);
                      Is_Part2     : in     Boolean := False)
   is
      function Get (V_Or_R : in Immediate_Reg) return Reg_Data is
         (Get_Value (Registers, V_Or_R));

      procedure Set (Reg   : in Natural;
                     Value : in Immediate_Reg)
      is begin
         Set_Value (Registers, Reg, Value);
      end Set;

      Do_Abort : Boolean := False;
   begin
      while (Program.PC in Program.Asm'Range) loop
         declare
            I : constant Instruction_Type := Program.Asm (Program.PC);
         begin
            Trace ("Executing " & I.Kind'Img & 
                   "    " & Image (I.X) &
                   "    " & Image (I.Y));
            case I.Kind is
               when Soueeend =>
                  Snd_Callback.all (Get (I.X));
               when Set =>
                  Set (Reg   => I.X.Reg,
                       Value => I.Y);
               when Add =>
                  Set (Reg   => I.X.Reg,
                       Value => (Immediate, Get (I.X) + Get (I.Y)));
               when Multiply =>
                  Set (Reg   => I.X.Reg,
                       Value => (Immediate, Get (I.X) * Get (I.Y)));
               when Modulus =>
                  Set (Reg   => I.X.Reg,
                       Value => (Immediate, Get (I.X) mod Get (I.Y)));
               when Recovers =>
                  if Is_Part2 or Get (I.X) /= 0 then
                     declare
                        V : Reg_Data;
                     begin
                        Rcv_Callback.all (V, Do_Abort);
                        if not Do_Abort then
                           Set (Reg   => I.X.Reg,
                                Value => (Immediate, V));
                        end if;
                     end;
                  end if;
               when Jump =>
                  if Get (I.X) > 0 then
                     Program.PC := Program.PC + Integer (Get (I.Y)) - 1;
                  end if;
            end case;
         end;
         
         exit when Do_Abort;

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
         Rcv : Reg_Data := -1;

         procedure Snd_Cb (Value : in Reg_Data) is
         begin
            Rcv := Value;
         end Snd_Cb;

         procedure Rcv_Cb (Value    : out Reg_Data;
                           Do_Abort : out Boolean) is
         begin
            Do_Abort := True;
            Value    := Rcv;
         end Rcv_Cb;
      begin
         Execute (Program, Registers, Snd_Cb'Access, Rcv_Cb'Access);

         return Rcv;
      end;
   end Part_1;

   function Part_2 (Input : in String_Vec)
                    return Natural
   is
      Name_Map : String_Vec;
      Id_Reg_Name : constant UString := To_UString ("p");
   begin
      Name_Map.Append (Id_Reg_Name);

      declare
         Program_0 : Program_Type := 
            Create_Program (Input, Name_Map);
         Program_1 : Program_Type := Program_0;

         Registers_0, Registers_1 : Reg_Array 
            (Name_Map.First_Index .. Name_Map.Last_Index) := (others => 0);
         
         Id_Reg : constant Natural := 
            Get_Register_Index (Name_Map, Id_Reg_Name);

         Rx_Buffer_0, Rx_Buffer_1 : Integer_Vec;

         Nof_Snd_1 : Natural := 0;

         Program_0_Waiting, Program_1_Waiting : Boolean := False;
         
         procedure Snd_Cb_0 (V : in Reg_Data) is
         begin
            Rx_Buffer_1.Append (Integer (V));
            Program_1_Waiting := False;
         end Snd_Cb_0;

         procedure Rcv_Cb_0 (V        : out Reg_Data;
                             Do_Abort : out Boolean) is
         begin
            Do_Abort := (Integer (Rx_Buffer_0.Length) = 0);
            if not Do_Abort then
               V := Reg_Data (Rx_Buffer_0.First_Element);
               Rx_Buffer_0.Delete_First;
            end if;
            Program_0_Waiting := Do_Abort;
         end Rcv_Cb_0;

         procedure Snd_Cb_1 (V : in Reg_Data) is
         begin
            Rx_Buffer_0.Append (Integer (V));
            Nof_Snd_1 := Natural'Succ (Nof_Snd_1);
            Program_0_Waiting := False;
         end Snd_Cb_1;

         procedure Rcv_Cb_1 (V        : out Reg_Data;
                             Do_Abort : out Boolean) is
         begin
            Do_Abort := (Integer (Rx_Buffer_1.Length) = 0);
            if not Do_Abort then
               V := Reg_Data (Rx_Buffer_1.First_Element);
               Rx_Buffer_1.Delete_First;
            end if;
            Program_1_Waiting := Do_Abort;
         end Rcv_Cb_1;

      begin
         Set_Value (Registers_0, Id_Reg, (Immediate, 0));
         Set_Value (Registers_1, Id_Reg, (Immediate, 1));

         while not (Program_0_Waiting and Program_1_Waiting) loop
            Execute 
               (Program_0, Registers_0, Snd_Cb_0'Access, Rcv_Cb_0'Access, True);
            Trace ("Task switch 0 -> 1");
            Execute 
               (Program_1, Registers_1, Snd_Cb_1'Access, Rcv_Cb_1'Access, True);
            Trace ("Task switch 1 -> 0");
         end loop;

         return Nof_Snd_1;
      end;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day18/input.txt");

      Put_Line ("Not a very clean solution...");
      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;