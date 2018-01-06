package AOC.Hash is

   type List_Index is mod 256;
   type Hash_Value is mod 256;

   type Hash_List_Type is array (List_Index'Range) of Hash_Value;

   type Length_List_Type is array (Natural range <>) of List_Index;

   Nof_Dense_Elt : constant List_Index := 16;

   type Dense_Hash_List_Type is array (0 .. Nof_Dense_Elt - 1) of Hash_Value;

   type Knot_Hash_Type is record
      List      : Hash_List_Type;
      Current   : List_Index := 0;
      Skip_Size : List_Index := 0;
   end record;


   function Knot_Hash_Of_String (S : in String)
                                 return String;

   function Knot_Hash_Of_String (S : in String)
                                 return Dense_Hash_List_Type;

   procedure Initialize (KH : in out Knot_Hash_Type);

   function Create_Length_List (Input : in Integer_Vec)
                                return Length_List_Type;

   procedure Knot_Sparse_Hash_Round (KH    : in out Knot_Hash_Type;
                                     Input : in     Length_List_Type);

end AOC.Hash;