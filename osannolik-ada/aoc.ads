with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package AOC is

   type String_Array is array (Positive range <>) of Unbounded_String;

   Empty : constant String_Array (1 .. 0) := 
      (others => Null_Unbounded_String);

   function Get_File_Rows (File_Name : in String)
                           return String_Array;

   function Get_File_String (File_Name : in String)
                             return String;

   function To_Integer (C : in Character) 
                        return Integer;

end AOC;