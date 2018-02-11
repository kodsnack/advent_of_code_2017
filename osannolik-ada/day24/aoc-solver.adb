with Ada.Text_IO;

package body AOC.Solver is

   type Component is record
      L, R      : Natural;
      Strength  : Natural;
   end record;

   type Component_List is array (Natural range <>) of Component;

   function Create_Input_Components (Input : in String_Vec)
                                     return Component_List
   is
      Nof_Comp   : constant Natural := Natural (Input.Length);
      Components : Component_List (0 .. Nof_Comp - 1);
      Tmp        : String_Vec;
      L, R       : Integer;
   begin
      for I in Components'Range loop
         Split_String_At_Char 
            (S       => To_String (Input.Element (I)),
             Char    => '/',
             Strings => Tmp);

         L := To_Integer (Tmp.First_Element);
         R := To_Integer (Tmp.Last_Element);

         Components (I) := 
            (L         => L,
             R         => R,
             Strength  => L + R);
      end loop;

      return Components;
   end Create_Input_Components;

   function Calculate_Strength (Bridge : in Integer_Vec;
                                Comps  : in Component_List)
                                return Natural
   is
      Tmp : Natural := 0;
   begin
      for I of Bridge loop
         Tmp := Tmp + Comps (I).Strength;
      end loop;
      return Tmp;
   end Calculate_Strength;

   procedure Builder (Bridge    : in out Integer_Vec;
                      Strengths : in out Integer_Vec;
                      Lengths   : in out Integer_Vec;
                      Comps     : in     Component_List;
                      End_Port  : in     Natural)
   is
   begin
      for I in Comps'Range loop
         if not Bridge.Contains (I) then
            if End_Port = Comps (I).R then
               Bridge.Append (I);
               Builder (Bridge, Strengths, Lengths, Comps, Comps (I).L);
               Strengths.Append (Calculate_Strength (Bridge, Comps));
               Lengths.Append (Integer (Bridge.Length));
               Bridge.Delete_Last;
            elsif End_Port = Comps (I).L then
               Bridge.Append (I);
               Builder (Bridge, Strengths, Lengths, Comps, Comps (I).R);
               Strengths.Append (Calculate_Strength (Bridge, Comps));
               Lengths.Append (Integer (Bridge.Length));
               Bridge.Delete_Last;
            end if;
         end if;
      end loop;
   end Builder;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
      Bridge    : Integer_Vec;
      Strengths : Integer_Vec;
      Lengths   : Integer_Vec;
   begin
      Get_File_Rows (Input, "day24/input.txt");

      declare
         Comps : constant Component_List := Create_Input_Components (Input);
      begin
         Builder (Bridge    => Bridge,
                  Strengths => Strengths,
                  Lengths   => Lengths,
                  Comps     => Comps,
                  End_Port  => 0);

         Put_Line ("Part 1: " & Max (To_Integer_Array (Strengths))'Img);

         declare
            Max_S : Natural := 0;
            Max_L : constant Integer := Max (To_Integer_Array (Lengths));
         begin
            for I in Lengths.First_Index .. Lengths.Last_Index loop
               if Lengths.Element (I) = Max_L then
                  Max_S := Natural'Max (Max_S, Strengths.Element (I));
               end if;
            end loop;

            Put_Line ("Part 2: " & Max_S'Img);
         end;
      end;

   end Run;

end AOC.Solver;