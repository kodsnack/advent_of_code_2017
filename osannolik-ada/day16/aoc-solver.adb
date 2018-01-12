with Ada.Text_IO;

package body AOC.Solver is

   subtype Program_Names is Character range 'a' .. 'p';

   type Move_Type is (Spin, Exchange, Partner);
 
   I_DONT_KNOW_THAT_MOVE : Exception;

   type Dance_Move (Move : Move_Type := Spin) is record
      case Move is
         when Spin =>
            X : Natural;
         when Exchange =>
            X_A : Natural;
            X_B : Natural;
         when Partner =>
            P_A : Program_Names;
            P_B : Program_Names;
      end case;
   end record;

   type Dance_Routine is array (Natural range <>) of Dance_Move;

   subtype Dancers_Type is String (1 .. 16);

   function Dancers_Init return Dancers_Type
   is
      Dancers : Dancers_Type;
      I : Natural := Dancers'First;
   begin
      for Name in Program_Names'Range loop
         Dancers (I) := Name;
         I := I + 1;
      end loop;
      return Dancers;
   end Dancers_Init;

   function Create_Dance_Move (MS : in String)
                               return Dance_Move
   is
      First    : constant Character := First_Char (MS);
      Cmd      : constant String := MS (MS'First + 1 .. MS'Last);
      Splitted : String_Vec;
   begin
      if First = 's' then
         return Dance_Move' 
            (Move => Spin, 
             X    => Integer'Value (Cmd));
      elsif First = 'x' then
         Split_String_At_Char (Cmd, '/', Splitted);
         return Dance_Move'
            (Move => Exchange, 
             X_A  => 1 + To_Integer (Splitted.First_Element),
             X_B  => 1 + To_Integer (Splitted.Last_Element));
      elsif First = 'p' then
         Split_String_At_Char (Cmd, '/', Splitted);
         return Dance_Move'
            (Move => Partner, 
             P_A  => First_Char (To_String (Splitted.First_Element)),
             P_B  => First_Char (To_String (Splitted.Last_Element)));
      else
         raise I_DONT_KNOW_THAT_MOVE;
      end if;
   end;

   function Create_Dance_Routine (Input : in String)
                                  return Dance_Routine
   is
      Splitted : String_Vec;
      
   begin
      Split_String_At_Char (Input, ',', Splitted);

      declare
         Dance : Dance_Routine (Splitted.First_Index .. Splitted.Last_Index);
      begin
         for I in Dance'Range loop
            Dance (I) := 
               Create_Dance_Move (To_String (Splitted.Element (I)));
         end loop;

         return Dance;
      end;
   end Create_Dance_Routine;

   procedure Do_A_Little_Move (Dancers  : in out Dancers_Type;
                               The_Move : in     Dance_Move)
   is
   begin
      case The_Move.Move is
         when Spin =>
            Dancers := Dancers (Dancers'Last - The_Move.X + 1 .. Dancers'Last) & 
                       Dancers (Dancers'First .. Dancers'Last - The_Move.X);

         when Exchange => 
            declare
               Tmp : constant Character := Dancers (The_Move.X_A);
            begin
               Dancers (The_Move.X_A) := Dancers (The_Move.X_B);
               Dancers (The_Move.X_B) := Tmp;
            end;

         when Partner =>
            for I in Dancers'Range loop
               if Dancers (I) = The_Move.P_A then
                  Dancers (I) := The_Move.P_B;
               elsif Dancers (I) = The_Move.P_B then
                  Dancers (I) := The_Move.P_A;
               end if;
            end loop;

      end case;
   end Do_A_Little_Move;

   procedure Do_A_Little_Dance (Dancers : in out Dancers_Type;
                                Moves   : in     Dance_Routine)
   is
   begin
      for Move of Moves loop
         Do_A_Little_Move (Dancers, Move);
      end loop;
   end Do_A_Little_Dance;

   function Part_1 (Dance : in Dance_Routine)
                    return Dancers_Type
   is
      Dancers : Dancers_Type := Dancers_Init;
   begin
      Do_A_Little_Dance (Dancers, Dance);

      return Dancers;
   end Part_1;

   function Calculate_Cycle_Length (Dance : in Dance_Routine;
                                    Start : in Dancers_Type)
                                    return Natural
   is
      Dancers : Dancers_Type := Start;
      N       : Natural := 0;
   begin
      loop
         Do_A_Little_Dance (Dancers, Dance);
         N := N + 1;
         exit when Start = Dancers;
      end loop;
      return N;
   end Calculate_Cycle_Length;

   function Part_2 (Dance : in Dance_Routine)
                    return Dancers_Type
   is
      Dancers : Dancers_Type := Dancers_Init;
      Cycle_Length : constant Natural := 
         Calculate_Cycle_Length (Dance, Dancers_Init);
   begin
      for I in 1 .. (1_000_000_000 mod Cycle_Length) loop
         Do_A_Little_Dance (Dancers, Dance);
      end loop;

      return Dancers;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Dance : constant Dance_Routine :=
         Create_Dance_Routine (Get_File_String ("day16/input.txt"));
   begin
      Put_Line ("Part 1: " & Part_1 (Dance));
      Put_Line ("Part 2: " & Part_2 (Dance));
   end Run;

end AOC.Solver;