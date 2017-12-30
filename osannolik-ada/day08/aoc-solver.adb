with Ada.Text_IO;

package body AOC.Solver is

   type Compare_Type is (Eq, Not_Eq, Lt, Lt_Or_Eq, Gt, Gt_Or_Eq);
   type Operation_Type is (Inc, Dec);

   type Instruction is record
      Modified_Register : Natural;
      Compared_Register : Natural;
      Operation         : Operation_Type;
      Comparison        : Compare_Type;
      Compare_Value     : Integer;
      Modify_Value      : Integer;
   end record;

   package V_Instruction is new Ada.Containers.Vectors
      (Natural,
       Instruction);
   
   subtype Instruction_Vec is V_Instruction.Vector;

   function Get_Comparison (Cmp : in UString)
                            return Compare_Type
   is
      Comparison : constant String := To_String (Cmp);
   begin
      if Comparison = "==" then
         return Eq;
      elsif Comparison = "!=" then
         return Not_Eq;
      elsif Comparison = "<" then
         return Lt;
      elsif Comparison = "<=" then
         return Lt_Or_Eq;
      elsif Comparison = ">" then
         return Gt;
      elsif Comparison = ">=" then
         return Gt_Or_Eq;
      else
         raise Constraint_Error;
      end if;
   end Get_Comparison;

   function Get_Operation (Op : in UString)
                           return Operation_Type
   is
      Operation : constant String := To_String (Op);
   begin
      if Operation = "inc" then
         return Inc;
      else
         return Dec;
      end if;
   end Get_Operation;

   function Get_Register_Index (R_Names : in out String_Vec;
                                Name       : in     UString)
                                return Natural
   is
   begin
      if not R_Names.Contains (Name) then
         R_Names.Append (Name);
         return R_Names.Last_Index;
      end if;

      return R_Names.Find_Index (Name);
   end Get_Register_Index;

   function Create_Instruction (Input_Row  : in     String;
                                R_Names : in out String_Vec)
                                return Instruction
   is
      Splitted_Row : String_Vec;
   begin
      Split_String_At_Char (S       => Input_Row,
                            Char    => ' ',
                            Strings => Splitted_Row);
      declare
         Mod_Reg : constant UString := Splitted_Row.Element (0);
         Op      : constant UString := Splitted_Row.Element (1);
         Mod_Val : constant UString := Splitted_Row.Element (2);
         Cmp_Reg : constant UString := Splitted_Row.Element (4);
         Cmp     : constant UString := Splitted_Row.Element (5);
         Cmp_Val : constant UString := Splitted_Row.Element (6);
      begin
         return (Modified_Register => Get_Register_Index (R_Names, Mod_Reg),
                 Compared_Register => Get_Register_Index (R_Names, Cmp_Reg),
                 Operation         => Get_Operation (Op),
                 Comparison        => Get_Comparison (Cmp),
                 Compare_Value     => Integer'Value (To_String (Cmp_Val)),
                 Modify_Value      => Integer'Value (To_String (Mod_Val)));
      end;
   end Create_Instruction;

   function Compare (Cmp : in Compare_Type;
                     Lhs : in Integer;
                     Rhs : in Integer)
                     return Boolean
   is
   begin
      case Cmp is
         when Eq =>
            return Lhs = Rhs;
         when Not_Eq =>
            return Lhs /= Rhs;
         when Lt =>
            return Lhs < Rhs;
         when Lt_Or_Eq =>
            return Lhs <= Rhs;
         when Gt =>
            return Lhs > Rhs;
         when Gt_Or_Eq =>
            return Lhs >= Rhs;
      end case;
   end Compare;

   procedure Modify (Register     : in out Integer;
                     Operation    : in     Operation_Type;
                     Modify_Value : in     Integer)
   is
   begin
      case Operation is
         when Inc =>
            Register := Register + Modify_Value;
         when Dec =>
            Register := Register - Modify_Value;
      end case;
   end Modify;

   procedure Execute (Registers     : in out Integer_Array;
                      Instructions  : in     Instruction_Vec;
                      Maximum_Value :    out Integer)
   is
   begin
      Maximum_Value := Max (Registers);
      for I of Instructions loop
         if Compare (Cmp => I.Comparison,
                     Lhs => Registers (I.Compared_Register),
                     Rhs => I.Compare_Value)
         then
            Modify (Register     => Registers (I.Modified_Register),
                    Operation    => I.Operation,
                    Modify_Value => I.Modify_Value);
            Maximum_Value := Integer'Max 
               (Maximum_Value, Max (Registers));
         end if;
      end loop;
   end Execute;

   procedure Run is
      use Ada.Text_IO;

      Input        : String_Vec;
      R_Names      : String_Vec;
      Instructions : Instruction_Vec;
   begin
      AOC.Get_File_Rows (Input, "day08/input.txt");

      for Row of Input loop
         Instructions.Append 
            (Create_Instruction (To_String (Row), R_Names));
      end loop;

      declare
         Registers : Integer_Array 
            (R_Names.First_Index .. R_Names.Last_Index) := (others => 0);
         Max_Stop_Val : Integer;
         Max_Ever_Val : Integer;
      begin
         Execute (Registers, Instructions, Max_Ever_Val);

         Max_Stop_Val := Max (Registers);

         Put_Line ("Part 1: " & Max_Stop_Val'Img);
         Put_Line ("Part 2: " & Max_Ever_Val'Img);
      end;
   end Run;

end AOC.Solver;