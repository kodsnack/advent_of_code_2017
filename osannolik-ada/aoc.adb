with Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;

package body AOC is

   function Get_File_Rows (File_Name : in String)
                           return String_Array
   is
      use Ada.Text_IO;

      Input : File_Type;
      N     : Natural := 0;
   begin
      Open (File => Input,
            Mode => In_File,
            Name => File_Name);

      while not End_Of_File (Input) loop
         N := Natural'Succ (N);
         Skip_Line (Input);
      end loop;

      Reset (Input);

      declare
         Rows : String_Array (1 .. N);
      begin
         N := Rows'First;

         while not End_Of_File (Input) loop
            Rows (N) := Ada.Strings.Unbounded.Text_IO.Get_Line (Input);
            N := Natural'Succ (N);
         end loop;

         Close (Input);

         return Rows;
      end;

   exception
      when End_Error =>
         if Is_Open (Input) then
            Close (Input);
         end if;

      return Empty;
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