with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package AOC is

   subtype UString is Unbounded_String;

   function To_UString (S : in String) return UString
      renames To_Unbounded_String;

   type Point is record
      X, Y : Integer := 0;
   end record;

   type Point3 is record
      X, Y, Z : Integer := 0;
   end record;

   function "+" (P1, P2 : in Point) return Point;

   function "+" (P1, P2 : in Point3) return Point3;

   function Image (P : in Point) return String;

   function Image (P : in Point3) return String;

   function Manhattan_Distance (P1 : in Point;
                                P2 : in Point := (0, 0))
                                return Natural;

   function Manhattan_Distance (P1 : in Point3;
                                P2 : in Point3 := (0, 0, 0))
                                return Natural;

   package V_String is new Ada.Containers.Vectors
      (Natural,
       Unbounded_String);

   package V_Integer is new Ada.Containers.Vectors
      (Natural,
       Integer);

   subtype Integer_Vec is V_Integer.Vector;
   subtype String_Vec is V_String.Vector;

   type Boolean_Array is array (Natural range <>) of Boolean;
   type Integer_Array is array (Integer range <>) of Integer;
   type String_Array is array (Integer range <>) of Unbounded_String;

   type Natural_2D is array (Integer range <>, Integer range <>) of Natural;

   function Image (IV : in V_Integer.Vector)
                   return String;

   function Max (IA    : in  Integer_Array;
                 Index : out Integer)
                 return Integer;

   function Max (IA : in  Integer_Array)
                 return Integer;

   function Min (IA    : in  Integer_Array;
                 Index : out Integer)
                 return Integer;

   function Integer_To_Hex (I     : in Integer; 
                            Width : in Positive := 2)
                            return String;

   function Integer_To_Bin (I     : in Integer; 
                            Width : in Positive := 8)
                            return String;

   function To_Boolean_Array (S : in String)
                              return Boolean_Array;
                              
   function To_Integer_Vector (SV : in V_String.Vector)
                               return V_Integer.Vector;
   
   function To_Integer_Vector (IA : in Integer_Array)
                               return V_Integer.Vector;

   function To_Integer_Array (IV : in V_Integer.Vector)
                              return Integer_Array;

   function To_Integer_Array (SV : in V_String.Vector)
                              return Integer_Array;

   function To_String_Array (SV : in V_String.Vector)
                             return String_Array;

   function To_Ascii_Vec (S : in String)
                          return V_Integer.Vector;

   procedure Split_String_At_Char (S       : in     String;
   	                               Char    : in     Character;
   	                               Strings : in out V_String.Vector);

   procedure Get_File_Rows (V         : in out V_Integer.Vector;
                            File_Name : in     String);

   function Get_File_Integer_Vec (File_Name : in String)
                                  return V_Integer.Vector;

   function Get_File_Ascii (File_Name : in String)
                            return V_Integer.Vector;

   procedure Get_File_Rows (V         : in out V_String.Vector;
   	                        File_Name : in     String);

   function Get_File_String (File_Name : in String)
                             return String;

   function Image (I : in Integer)
                   return String;

   function To_Integer (C : in Character) 
                        return Integer;

   function To_Integer (US : in UString)
                        return Integer;

   function First_Char (S : in String)
                        return Character;
                        
end AOC;