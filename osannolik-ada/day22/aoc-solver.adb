with Ada.Text_IO;

package body AOC.Solver is

   type Direction_Type is (Up, Right, Down, Left);

   Turn_Right : constant array (Direction_Type'Range) of Direction_Type :=
      (Up => Right, Right => Down, Down => Left, Left => Up);

   Turn_Left : constant array (Direction_Type'Range) of Direction_Type :=
      (Up => Left, Right => Up, Down => Right, Left => Down);

   Turn_Reverse : constant array (Direction_Type'Range) of Direction_Type :=
      (Up => Down, Right => Left, Down => Up, Left => Right);

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

   function Part_1 (Input : in String_Vec) return Natural
   is
      Infected_Nodes : Nodes_Vec := Initialize_Map (Input);
      Virus : Virus_State;
   begin
      for I in 1 .. 10_000 loop
         Infection_Burst (Virus          => Virus,
                          Infected_Nodes => Infected_Nodes);
      end loop;

      return Virus.Nof_Infected;
   end Part_1;

   function Part_2 (Input : in String_Vec) return Natural
   is -- Pretty slow version! Vectors...
      type States is (Clean, Weak, Infected, Flagged);
      type Node_Lists is array (Weak .. Flagged) of Nodes_Vec;

      Next : constant array (States'Range) of States :=
         (Clean    => Weak,    Weak    => Infected, 
          Infected => Flagged, Flagged => Clean);

      function Node_State (Node  : in     Point;
                           Nodes : in     Node_Lists;
                           Index :    out Natural) 
                           return States
      is
      begin
         for State in Nodes'Range loop
            Index := Nodes (State).Find_Index (Node);
            if Index /= 0 then
               return State;
            end if;
         end loop;
         return Clean;
      end Node_State;

      procedure Infection_Burst
         (Virus : in out Virus_State;
          Nodes : in out Node_Lists)
      is
         Index : Natural;
         Current_State : constant States :=
            Node_State (Virus.Position, Nodes, Index);
         Next_State : constant States :=
            Next (Current_State);
      begin
         case Current_State is
            when Clean =>
               Virus.Direction := Turn_Left (Virus.Direction);
            when Weak =>
               null;
            when Infected =>
               Virus.Direction := Turn_Right (Virus.Direction);
            when Flagged =>
               Virus.Direction := Turn_Reverse (Virus.Direction);
         end case;

         if Current_State in Nodes'Range then
            Nodes (Current_State).Delete (Index);
         end if;

         if Next_State in Nodes'Range then
            Nodes (Next_State).Append (Virus.Position);
         end if;

         if Current_State /= Infected and then
            Next_State = Infected then
            Virus.Nof_Infected := Virus.Nof_Infected + 1;
         end if;

         Virus := Move (Virus);
      end Infection_Burst;

      Nodes : Node_Lists;
      Virus : Virus_State;
   begin
      Nodes (Infected) := Initialize_Map (Input);

      for I in 1 .. 10_000_000 loop
         Infection_Burst (Virus => Virus,
                          Nodes => Nodes);
      end loop;

      return Virus.Nof_Infected;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day22/input.txt");

      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;