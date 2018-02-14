with Ada.Text_IO;
with Interfaces;

package body AOC.Solver is
   use Interfaces;

   type C_Map is array (Natural range <>, Natural range <>) of Character;

   subtype C_Map3 is C_Map (0 .. 2, 0 .. 2);
   subtype C_Map4 is C_Map (0 .. 3, 0 .. 3);

   subtype Key is Interfaces.Unsigned_32;

   Empty : constant C_Map (1 .. 0, 1 .. 0) := (others => (others => ' '));

   Initial : constant UString := To_UString (".#./..#/###");

   function To_String (M : in C_Map)
                       return UString
   is
      Tmp : UString;
   begin
      for IY in M'Range (2) loop
         for IX in M'Range (1) loop
            Tmp := Tmp & String' (1 => M (IX, IY));
         end loop;
         if IY /= M'Last (2) then
            Tmp := Tmp & "/";
         end if;
      end loop;
      return Tmp;
   end To_String;

   type Enhance_Rules_2 is array (Key range 0 .. 2 ** 4 - 1) of C_Map3;
   type Enhance_Rules_3 is array (Key range 0 .. 2 ** 9 - 1) of C_Map4;

   type Enhancement_Rules is record
      Enhance_From_2 : Enhance_Rules_2;
      Enhance_From_3 : Enhance_Rules_3;
   end record;

   function Image (M : in C_Map) return String
   is
      Tmp : UString;
   begin
      for IY in M'Range (2) loop
         for IX in M'Range (1) loop
            Tmp := Tmp & String' (1 => M (IX, IY));
            if IX /= M'Last (1) then
               Tmp := Tmp & " ";
            end if;
         end loop;
         if IY /= M'Last (2) then
            Tmp := Tmp & Ascii.Lf;
         end if;
      end loop;
      return To_String (Tmp);
   end Image;

   pragma Unreferenced (Image);

   function Rotate (Map : in C_Map)
                    return C_Map
   is
      Tmp : C_Map (Map'Range (1), Map'Range (2));
      Last_Index : constant Natural := Map'Last (1); -- square
      Y : Integer;
   begin
      for IX in Map'Range (1) loop
         Y := Last_Index;
         for IY in Map'Range (2) loop
            Tmp (IX, Y) := Map (IY, IX);
            Y := Y - 1;
         end loop;
      end loop;
      return Tmp;
   end Rotate;

   function Flip_X (Map : in C_Map)
                    return C_Map
   is
      Tmp : C_Map (Map'Range (1), Map'Range (2));
      X : Integer;
   begin
      for IY in Map'Range (2) loop
         X := Map'Last (1);
         for I in Map'Range (1) loop
            Tmp (X, IY) := Map (I, IY);
            X := X - 1;
         end loop;
      end loop;
      return Tmp;
   end Flip_X;

   function Create_Map (Input : in UString)
                        return C_Map
   is
      Splitted : String_Vec;
   begin
      Split_String_At_Char (To_String (Input), '/', Splitted);
      declare
         Size : constant Natural := Natural (Splitted.Length);
         Map  : C_Map (0 .. Size - 1, 0 .. Size - 1);
      begin
         for X in Map'Range (1) loop
            declare
               S : constant String := To_String (Splitted.Element (X));
            begin
               for Y in Map'Range (2) loop
                  Map (X, Y) := S (S'First + Y);
               end loop;
            end;
         end loop;
         return Map;
      end;
   end Create_Map;

   function To_Key (M : in C_Map) return Key
   is
      K : Key := 0;
   begin
      for C of M loop
         K := Shift_Left (K, 1);
         if C = '#' then
            K := K or 1;
         end if;
      end loop;
      return K;
   end To_Key;

   function Create_Rules (Input : in String_Vec)
                          return Enhancement_Rules
   is
      Splitted : String_Vec;
      Rules    : Enhancement_Rules;

      procedure Add_Flip_Rotate (List : in out Enhancement_Rules;
                                 From : in     C_Map;
                                 To   : in     C_Map) is

         procedure Add (M : in C_Map) is begin
            if M'Length (1) = 2 then
               List.Enhance_From_2 (To_Key (M)) := To;
            elsif M'Length (1) = 3 then
               List.Enhance_From_3 (To_Key (M)) := To;
            end if;
         end Add;

         Tmp : C_Map := From;
      begin
         for Rot in 1 .. 4 loop
            Add (Tmp);
            Add (Flip_X (Tmp));
            Tmp := Rotate (Tmp);
         end loop;
      end Add_Flip_Rotate;

   begin
      for Row of Input loop
         Split_String_At_Char (To_String (Row), ' ', Splitted);
         declare
            From : constant C_Map := Create_Map (Splitted.First_Element);
            To   : constant C_Map := Create_Map (Splitted.Last_Element);
         begin
            Add_Flip_Rotate (Rules, From, To);
         end;
      end loop;

      return Rules;
   end Create_Rules;

   function Get_Sub_Map (M : in C_Map;
                         X : in Natural;
                         Y : in Natural;
                         N : in Natural) 
                         return C_Map
   is
      Tmp : C_Map (0 .. N - 1, 0 .. N - 1);
      XI : Integer := X;
      YI : Integer;
   begin
      for I in Tmp'Range (1) loop
         YI := Y;
         for J in Tmp'Range (2) loop
            Tmp (I, J) := M (XI, YI);
            YI := YI + 1;
         end loop;
         XI := XI + 1;
      end loop;
      return Tmp;
   end Get_Sub_Map;

   procedure Set_Sub_Map (M     : in out C_Map;
                          M_Set : in     C_Map;
                          X     : in     Natural;
                          Y     : in     Natural)
   is
      XI : Integer := X;
      YI : Integer;
   begin
      for I in M_Set'Range (1) loop
         YI := Y;
         for J in M_Set'Range (2) loop
            M (XI, YI) := M_Set (I, J);
            YI := YI + 1;
         end loop;
         XI := XI + 1;
      end loop;
   end Set_Sub_Map;

   function Enhance (M     : in C_Map;
                     Rules : in Enhancement_Rules)
                     return C_Map
   is
      Size : constant Natural := M'Length (1);
      N2   : constant Natural := Size / 2;
      N3   : constant Natural := Size / 3;
   begin
      if Size mod 2 = 0 then
         --  Break up into 2x2 maps
         declare
            Merged : C_Map (0 .. 3 * N2 - 1, 0 .. 3 * N2 - 1);
         begin
            for I in 0 .. N2 - 1 loop
               for J in 0 .. N2 - 1 loop
                  declare
                     F : constant C_Map := Get_Sub_Map (M, 2 * I, 2 * J, 2);
                     T : constant C_Map := Rules.Enhance_From_2 (To_Key (F));
                  begin
                     Set_Sub_Map (Merged, T, 3 * I, 3 * J);
                  end;
               end loop;
            end loop;

            return Merged;
         end;
      elsif Size mod 3 = 0 then
        --  Break up into 3x3 maps
         declare
            Merged : C_Map (0 .. 4 * N3 - 1, 0 .. 4 * N3 - 1);
         begin
            for I in 0 .. N3 - 1 loop
               for J in 0 .. N3 - 1 loop
                  declare
                     F : constant C_Map := Get_Sub_Map (M, 3 * I, 3 * J, 3);
                     T : constant C_Map := Rules.Enhance_From_3 (To_Key (F));
                  begin
                     Set_Sub_Map (Merged, T, 4 * I, 4 * J);
                  end;
               end loop;
            end loop;

            return Merged;
         end;
      end if;

      return Empty;
   end Enhance;

   function Count (M : in C_Map;
                   C : in Character)
                   return Natural
   is
      Cnt : Natural := 0;
   begin
      for X of M loop
         if X = C then
            Cnt := Cnt + 1;
         end if;
      end loop;
      return Cnt;
   end Count;

   function Part_1 (Rules : in Enhancement_Rules)
                    return Natural
   is
      Tmp : UString := Initial;
   begin
      for I in 1 .. 5 loop
         Tmp := To_String (Enhance (Create_Map (Tmp), Rules));
      end loop;

      return Count (Create_Map (Tmp), '#');
   end Part_1;

   function Part_2 (Rules : in Enhancement_Rules)
                    return Natural
   is
      --  Quick and dirty way to handle unknown sizes of M...
      --  Saving the map state as an unbounded string between 
      --  each iteration as in Part_1 is way too slow!
      M1  : constant C_Map := Enhance (Create_Map (Initial), Rules);
      M2  : constant C_Map := Enhance (M1,  Rules);
      M3  : constant C_Map := Enhance (M2,  Rules);
      M4  : constant C_Map := Enhance (M3,  Rules);
      M5  : constant C_Map := Enhance (M4,  Rules);
      M6  : constant C_Map := Enhance (M5,  Rules);
      M7  : constant C_Map := Enhance (M6,  Rules);
      M8  : constant C_Map := Enhance (M7,  Rules);
      M9  : constant C_Map := Enhance (M8,  Rules);
      M10 : constant C_Map := Enhance (M9,  Rules);
      M11 : constant C_Map := Enhance (M10, Rules);
      M12 : constant C_Map := Enhance (M11, Rules);
      M13 : constant C_Map := Enhance (M12, Rules);
      M14 : constant C_Map := Enhance (M13, Rules);
      M15 : constant C_Map := Enhance (M14, Rules);
      M16 : constant C_Map := Enhance (M15, Rules);
      M17 : constant C_Map := Enhance (M16, Rules);
      M18 : constant C_Map := Enhance (M17, Rules);
   begin
     return Count (M18, '#');
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day21/input.txt");

      declare
         Rules : constant Enhancement_Rules := Create_Rules (Input);
      begin
         Put_Line ("Part 1: " & Part_1 (Rules)'Img);
         Put_Line ("Part 2: " & Part_2 (Rules)'Img);
      end;
   end Run;

end AOC.Solver;