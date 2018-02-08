with Ada.Text_IO;

package body AOC.Solver is

   type Direction_Type is (Up, Right, Down, Left);

   function Turn_Right (Dir : in Direction_Type)
                        return Direction_Type is
   begin
      if Dir = Left then
         return Up;
      else
         return Direction_Type'Succ (Dir);
      end if;
   end Turn_Right;

   function Turn_Left (Dir : in Direction_Type)
                       return Direction_Type is
   begin
      if Dir = Up then
         return Left;
      else
         return Direction_Type'Pred (Dir);
      end if;
   end Turn_Left;

   type Virus_State is record
      Position     : Point          := (0, 0);
      Direction    : Direction_Type := Up;
      Nof_Infected : Natural        := 0;
   end record;

   package V_Nodes is new Ada.Containers.Vectors (Positive, Point);

   subtype Nodes_Vec is V_Nodes.Vector;

   function Initialize_Map (Input : in String_Vec)
                            return Nodes_Vec
   is
      Nodes  : Nodes_Vec;
      Width  : constant Positive := Length (Input.First_Element);
      Height : constant Positive := Positive (Input.Length);
      W : Integer;
      H : Integer := (Height - 1) / 2;
   begin
      if (Width mod 2) = 0 or (Height mod 2) = 0 then
         raise Constraint_Error;
      end if;

      for Row of Input loop
         W := -(Width - 1) / 2;
         for C of To_String (Row) loop
            if C = '#' then
               Nodes.Append ((W, H));
            end if;
            W := W + 1;
         end loop;
         H := H - 1;
      end loop;

      return Nodes;
   end Initialize_Map;

   function Move (Virus : in Virus_State)
                  return Virus_State
   is
      D_Pos : constant array (Direction_Type'Range) of Point :=
         (Up => (0, 1), Right => (1, 0), Down => (0, -1), Left => (-1, 0));
      Tmp : Virus_State := Virus;
   begin
      Tmp.Position := Virus.Position + D_Pos (Virus.Direction);
      return Tmp;
   end Move;

   procedure Infection_Burst
      (Virus          : in out Virus_State;
       Infected_Nodes : in out Nodes_Vec)
   is
      Index : constant Natural :=
         Infected_Nodes.Find_Index (Virus.Position);
   begin
      if Index /= 0 then
         Infected_Nodes.Delete (Index);
         Virus.Direction := Turn_Right (Virus.Direction);
      else
         Infected_Nodes.Append (Virus.Position);
         Virus.Direction := Turn_Left (Virus.Direction);
         Virus.Nof_Infected := Virus.Nof_Infected + 1;
      end if;

      Virus := Move (Virus);
   end Infection_Burst;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day22/input.txt");

      declare
         Infected_Nodes : Nodes_Vec := Initialize_Map (Input);
         Virus : Virus_State;
      begin
         for I in 1 .. 10_000 loop
            Infection_Burst (Virus          => Virus,
                             Infected_Nodes => Infected_Nodes);
         end loop;

         Put_Line ("Part 1: " & Virus.Nof_Infected'Img);
      end;

   end Run;

end AOC.Solver;