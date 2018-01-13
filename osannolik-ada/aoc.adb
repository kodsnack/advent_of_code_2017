with Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;

package body AOC is

   function "+" (P1, P2 : in Point) return Point
   is
   begin
      return Point'(X => P1.X + P2.X, Y => P1.Y + P2.Y);
   end "+";

   function "+" (P1, P2 : in Point3) return Point3
   is
   begin
      return Point3'(X => P1.X + P2.X, Y => P1.Y + P2.Y, Z => P1.Z + P2.Z);
   end "+";

   function Image (P : in Point) return String
   is
   begin
      return P.X'Img & "," & P.Y'Img;
   end Image;

   function Image (P : in Point3) return String
   is
   begin
      return P.X'Img & "," & P.Y'Img & "," & P.Z'Img;
   end Image;

   function Manhattan_Distance (P1 : in Point;
                                P2 : in Point := (0, 0))
                                return Natural
   is
   begin
      return abs (P1.X - P2.X) + abs (P1.Y - P2.Y);
   end Manhattan_Distance;

   function Manhattan_Distance (P1 : in Point3;
                                P2 : in Point3 := (0, 0, 0))
                                return Natural
   is
   begin
      return abs (P1.X - P2.X) + abs (P1.Y - P2.Y) + abs (P1.Z - P2.Z);
   end Manhattan_Distance;

   function Image (IV : in V_Integer.Vector)
                   return String
   is
      Tmp : UString;
   begin
      for I in IV.First_Index .. IV.Last_Index loop
         Tmp := Tmp & To_Unbounded_String (IV.Element (I)'Img);
         if I /= IV.Last_Index then
            Tmp := Tmp & To_Unbounded_String (",");
         end if;
      end loop;
      return To_String (Tmp);
   end Image;

   function Max (IA    : in  Integer_Array;
                 Index : out Integer)
                 return Integer
   is
      Value : Integer;
   begin
      if IA'Length = 0 then
         raise Constraint_Error;
      end if;

      Index := IA'First;
      Value := IA (Index);
      
      for I in IA'First + 1 .. IA'Last loop
         if IA (I) > Value then
            Index := I;
            Value := IA (I);
         end if;
      end loop;

      return Value;
   end Max;
   
   function Max (IA : in Integer_Array)
                 return Integer
   is
      Tmp : Integer := IA (IA'First);
   begin
      for I of IA loop
         Tmp := Integer'Max (Tmp, I);
      end loop;

      return Tmp;
   end Max;

   function Min (IA    : in  Integer_Array;
                 Index : out Integer)
                 return Integer
   is
      Value : Integer;
   begin
      if IA'Length = 0 then
         raise Constraint_Error;
      end if;

      Index := IA'First;
      Value := IA (Index);
      
      for I in IA'First + 1 .. IA'Last loop
         if IA (I) < Value then
            Index := I;
            Value := IA (I);
         end if;
      end loop;

      return Value;
   end Min;

   function Integer_To_Hex (I     : in Integer; 
                            Width : in Positive := 2)
                            return String
   is
      Hex_Prefix_Length : constant := 3;
      Hexa   : String (1 .. Hex_Prefix_Length + Width + 1);
      Result : String (1 .. Width);
      Start  : Natural;
   begin
      Ada.Integer_Text_IO.Put (Hexa, I, 16);
      Start := Ada.Strings.Fixed.Index (Source => Hexa, Pattern => "#");
      Ada.Strings.Fixed.Move
         (Source  => Hexa (Start + 1 .. Hexa'Last - 1),
          Target  => Result,
          Justify => Ada.Strings.Right,
          Pad     => '0');

     return Result;
   end Integer_To_Hex;

   function Integer_To_Bin (I     : in Integer; 
                            Width : in Positive := 8)
                            return String
   is
      Bin_Prefix_Length : constant := 2;
      Bin    : String (1 .. Bin_Prefix_Length + Width + 1);
      Result : String (1 .. Width);
      Start  : Natural;
   begin
      Ada.Integer_Text_IO.Put (Bin, I, 2);
      Start := Ada.Strings.Fixed.Index (Source => Bin, Pattern => "#");
      Ada.Strings.Fixed.Move
         (Source  => Bin (Start + 1 .. Bin'Last - 1),
          Target  => Result,
          Justify => Ada.Strings.Right,
          Pad     => '0');

     return Result;
   end Integer_To_Bin;

   function To_Boolean_Array (S : in String)
                              return Boolean_Array
   is
      BA : Boolean_Array (0 .. S'Length - 1);
      J : Natural := S'First;
   begin
      for I in BA'Range loop
         BA (I) := (S (J) /= '0');
         J := J + 1;
      end loop;
      return BA;
   end To_Boolean_Array;

   function To_Integer_Array (IV : in V_Integer.Vector)
                              return Integer_Array
   is
      IA : Integer_Array (IV.First_Index .. IV.Last_Index);
      I : Integer := IV.First_Index;
   begin
      for Value of IV loop
         IA (I) := Value;
         I := Integer'Succ (I);
      end loop;

      return IA;
   end To_Integer_Array;

   function To_Integer_Array (SV : in V_String.Vector)
                              return Integer_Array
   is
   begin
      return To_Integer_Array (To_Integer_Vector (SV));
   end To_Integer_Array;

   function To_String_Array (SV : in V_String.Vector)
                             return String_Array
   is
      SA : String_Array (SV.First_Index .. SV.Last_Index);
      I : Integer := SV.First_Index;
   begin
      for Value of SV loop
         SA (I) := Value;
         I := Integer'Succ (I);
      end loop;

      return SA;
   end To_String_Array;

   function To_Integer_Vector (SV : in V_String.Vector)
                               return V_Integer.Vector
   is
      IV : V_Integer.Vector;
   begin
      for Value of SV loop
         IV.Append (Integer'Value (To_String (Value)));
      end loop;

      return IV;
   end To_Integer_Vector;

   function To_Integer_Vector (IA : in Integer_Array)
                               return V_Integer.Vector
   is
      IV : V_Integer.Vector;
   begin
      for Value of IA loop
         IV.Append (Value);
      end loop;

      return IV;
   end To_Integer_Vector;

   procedure Split_String_At_Char (S       : in     String;
                                   Char    : in     Character;
                                   Strings : in out V_String.Vector)
   is
      Start : Integer := S'First;
   begin
      Strings.Clear;

      for I in S'Range loop
         if S (I) = Char then
            Strings.Append 
               (To_Unbounded_String (S (Start .. I - 1)));
            Start := I + 1;
         end if;
      end loop;

      Strings.Append (To_Unbounded_String (S (Start .. S'Last)));
   end Split_String_At_Char;

   procedure Get_File_Rows (V         : in out V_Integer.Vector;
                            File_Name : in     String)
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      while not End_Of_File (Input) loop
         declare
            Row_Data : constant String := Get_Line (Input);
         begin
            V.Append (Integer'Value (Row_Data));
         end;
      end loop;

      Close (Input);

   exception
      when End_Error =>
         if Is_Open (Input) then
            Close (Input);
         end if;
   end Get_File_Rows;

   function Get_File_Integer_Vec (File_Name : in String)
                                  return V_Integer.Vector
   is
      use Ada.Text_IO;

      Input : File_Type;
      Output : Integer_Vec;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      declare
         --  Assume single line file...
         Content : constant String := Get_Line (Input);
         Splitted : String_Vec;
      begin

         Split_String_At_Char (Content, ',', Splitted);

         for S of Splitted loop
            Output.Append (Integer'Value (To_String (S)));
         end loop;

         Close (Input);

         return Output;
      end;

   exception
      when End_Error =>
         if Is_Open(Input) then
            Close (Input);
         end if;

      return Output;
   end Get_File_Integer_Vec;

   function To_Ascii_Vec (S : in String)
                          return V_Integer.Vector
   is
      Ascii_Nr : V_Integer.Vector;
   begin
      for C of S loop
         Ascii_Nr.Append (Character'Pos (C));
      end loop;
      return Ascii_Nr;
   end To_Ascii_Vec;

   function Get_File_Ascii (File_Name : in String)
                            return V_Integer.Vector
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      declare
         --  Assume single line file...
         Ascii_Nr : constant V_Integer.Vector := 
            To_Ascii_Vec (Get_Line (Input));
      begin
         Close (Input);

         return Ascii_Nr;
      end;

   exception
      when End_Error =>
         if Is_Open(Input) then
            Close (Input);
         end if;

      return To_Ascii_Vec ("");
   end Get_File_Ascii;

   procedure Get_File_Rows (V         : in out V_String.Vector;
                            File_Name : in     String)
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      while not End_Of_File (Input) loop
         V.Append (Ada.Strings.Unbounded.Text_IO.Get_Line (Input));
      end loop;

      Close (Input);

   exception
      when End_Error =>
         if Is_Open (Input) then
            Close (Input);
         end if;
   end Get_File_Rows;

   function Get_File_String (File_Name : in String)
                             return String
   is
      use Ada.Text_IO;

      Input : File_Type;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      declare
         --  Assume single line file...
         Content : constant String := Get_Line (Input);
      begin
         Close (Input);

         return Content;
      end;

   exception
      when End_Error =>
         if Is_Open(Input) then
            Close (Input);
         end if;

      return "";
   end Get_File_String;

   function To_Integer (C : in Character) 
                        return Integer
   is
   begin
      return Integer'Value (String' (1 => C));
   end To_Integer;

   function Image (I : in Integer)
                   return String
   is
      S : constant String := I'Img;
   begin
      --  Remove first blank...
      return S (S'First + 1 .. S'Last);
   end Image;

   function To_Integer (US : in UString)
                        return Integer
   is
   begin
      return Integer'Value (To_String (US));
   end To_Integer;

   function First_Char (S : in String)
                        return Character
   is
   begin
      return S (S'First);
   end First_Char;

end AOC;