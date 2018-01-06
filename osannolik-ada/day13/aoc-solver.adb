with Ada.Text_IO;

package body AOC.Solver is

   type Layer is record
      Depth  : Natural;
      Rangen : Natural;
   end record;

   type Firewall_Type is array (Natural range <>) of Layer;

   function Create_Firewall (Input : in String_Vec)
                             return Firewall_Type
   is
      Splitted : String_Vec;
      Firewall : Firewall_Type (Input.First_Index .. Input.Last_Index);
   begin
      for L in Firewall'Range loop
         Split_String_At_Char (To_String (Input.Element (L)), ':', Splitted);
         Firewall (L) := Layer'(Depth  => To_Integer (Splitted.Element (0)),
                                  Rangen => To_Integer (Splitted.Element (1)));
      end loop;

      return Firewall;
   end Create_Firewall;

   function Calculate_Severity 
      (Firewall       : in     Firewall_Type;
       Initial_Delay  : in     Natural;
       Was_Hit        :    out Boolean;
       Abort_When_Hit : in     Boolean := False)
       return Natural
   is
      Severity : Natural := 0;
   begin
      Was_Hit := False;

      for Layer of Firewall loop
         if ((Layer.Depth + Initial_Delay) mod 
             (2 * (Layer.Rangen - 1))) = 0 
         then
            Was_Hit := True;
            Severity := Severity + Layer.Depth * Layer.Rangen;
            if Abort_When_Hit then
               return Severity;
            end if;
         end if;
      end loop;

      return Severity;
   end Calculate_Severity;

   function Part_1 (Input : in String_Vec)
                    return Natural
   is
      Firewall : constant Firewall_Type := Create_Firewall (Input);
      Was_Hit  : Boolean;
   begin
      return Calculate_Severity (Firewall      => Firewall,
                                 Initial_Delay => 0,
                                 Was_Hit       => Was_Hit);
   end Part_1;

   function Part_2 (Input : in String_Vec)
                    return Natural
   is
      Firewall : constant Firewall_Type := Create_Firewall (Input);
      Severity : Natural;
      Was_Hit  : Boolean;
      Initial_Delay : Natural := Natural'First;
   begin
      loop         
         Severity := Calculate_Severity 
            (Firewall       => Firewall,
             Initial_Delay  => Initial_Delay,
             Was_Hit        => Was_Hit,
             Abort_When_Hit => True);

         exit when not Was_Hit;

         Initial_Delay := Natural'Succ (Initial_Delay);
      end loop;

      pragma Unreferenced (Severity);

      return Initial_Delay;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day13/input.txt");

      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;