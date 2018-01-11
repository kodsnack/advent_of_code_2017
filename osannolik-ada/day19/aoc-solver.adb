with Ada.Text_IO;

package body AOC.Solver is

   type Routing_Map is array (Natural range <>, Natural range <>) of Character;
   --                           Y                 X
   --    +----->
   --    |       X
   --    |
   --    V
   --  Y 

   function Get (Map : in Routing_Map; 
                 P   : in Point)
                 return Character
   is
      Void : constant Character := ' ';
   begin
      if P.Y in Map'Range (1) and P.X in Map'Range (2) then
         return Map (P.Y, P.X);
      else
         return Void;
      end if;
   end Get;

   function Create_Routing_Map (Input : in String_Vec)
                                return Routing_Map
   is
      First_Row : constant String := To_String (Input.First_Element);
      Map : Routing_Map (Input.First_Index .. Input.Last_Index, 
                         First_Row'First   .. First_Row'Last);
   begin
      for Row in Map'Range (1) loop
         declare
            Row_Str : constant String := To_String (Input.Element (Row));
         begin
            for Char in Map'Range (2) loop
               Map (Row, Char) := Row_Str (Char);
            end loop;
         end;
      end loop;

      return Map;
   end Create_Routing_Map;

   type Direction_Type is (Down, Up, Left, Right);

   function Find_Entry (Map : in Routing_Map)
                        return Point
   is
   begin
      for I in Map'Range (2) loop
         if Map (Map'First (1), I) = '|' then
            return (Y => Map'First (1), X => I);
         end if;
      end loop;
      return (Y => -1, X => -1);
   end Find_Entry;

   type Packet_State is record
      Position  : Point;
      Direction : Direction_Type;
      Letters   : UString;
      Nof_Steps : Positive;
   end record;

   D_Pos : constant array (Direction_Type'Range) of Point :=
      (Down  => (Y => 1, X => 0), Up   => (Y => -1, X =>  0),
       Right => (Y => 0, X => 1), Left => (Y =>  0, X => -1));

   procedure Update_Position (P             : in out Packet_State;
                              Map           : in     Routing_Map;
                              Into_The_Void :    out Boolean)
   is
   begin
      P.Position := P.Position + D_Pos (P.Direction);
      Into_The_Void := (Get (Map, P.Position) = ' ');
      if not Into_The_Void then
         P.Nof_Steps := Positive'Succ (P.Nof_Steps);
      end if;
   end Update_Position;

   procedure Update_Direction (P   : in out Packet_State;
                               Map : in     Routing_Map)
   is
      Current_Char : constant Character := Get (Map, P.Position);
   begin
      if Current_Char = '+' then
         -- Assume only one possible path...
         case P.Direction is
            when Down | Up =>
               if Get (Map, P.Position + D_Pos (Right)) = '-' then
                  P.Direction := Right;
               elsif Get (Map, P.Position + D_Pos (Left)) = '-' then
                  P.Direction := Left;
               end if;

            when Right | Left =>
               if Get (Map, P.Position + D_Pos (Down)) = '|' then
                  P.Direction := Down;
               elsif Get (Map, P.Position + D_Pos (Up)) = '|' then
                  P.Direction := Up;
               end if;
         end case;
      elsif Current_Char in 'A' .. 'Z' then
         P.Letters := P.Letters & Current_Char;
      end if;
   end Update_Direction;

   function Create_Packet (Initial_Position : in Point)
                           return Packet_State
   is
   begin
      return (Position  => Initial_Position,
              Direction => Down,
              Letters   => To_UString (""),
              Nof_Steps => 1); -- Entry step
   end Create_Packet;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day19/input.txt");

      declare
         Map : constant Routing_Map := Create_Routing_Map (Input);
         Packet : Packet_State := Create_Packet (Find_Entry (Map));
         Into_The_Void : Boolean := False;
      begin
         while not Into_The_Void loop
            Update_Position (Packet, Map, Into_The_Void);
            Update_Direction (Packet, Map);
         end loop;

         Put_Line ("Part 1: " & To_String (Packet.Letters));
         Put_Line ("Part 2: " & Packet.Nof_Steps'Img);
      end;
   end Run;

end AOC.Solver;