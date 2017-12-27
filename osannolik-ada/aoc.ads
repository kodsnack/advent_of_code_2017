with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package AOC is

   package V_String is new Ada.Containers.Vectors
      (Natural,
       Unbounded_String);

   package V_Integer is new Ada.Containers.Vectors
      (Natural,
       Integer);

   type Integer_Array is array (Integer range <>) of Integer;

   function To_Integer_Array (IV : in V_Integer.Vector)
                              return Integer_Array;

   procedure Split_String_At_Char (S       : in     String;
   	                               Char    : in     Character;
   	                               Strings : in out V_String.Vector);

   procedure Get_File_Rows (V         : in out V_String.Vector;
   	                        File_Name : in     String);

   function Get_File_String (File_Name : in String)
                             return String;

   function To_Integer (C : in Character) 
                        return Integer;

end AOC;