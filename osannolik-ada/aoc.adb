with Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;

package body AOC is

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

end AOC;