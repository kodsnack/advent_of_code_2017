package body AOC.Hash is

   function Create_Hash_List return Hash_List_Type
   is
      Hash_List : Hash_List_Type;
   begin
      for I in Hash_List'Range loop
         Hash_List (I) := Hash_Value (I);
      end loop;

      return Hash_List;
   end Create_Hash_List;

   function Create_Length_List (Input : in Integer_Vec)
                                return Length_List_Type
   is
      List : Length_List_Type (Input.First_Index .. Input.Last_Index);
   begin
      for I in List'Range loop
         List (I) := List_Index (Input.Element (I));
      end loop;

      return List;
   end Create_Length_List;

   function Length (From, To : in List_Index)
                    return List_Index
   is
   begin
      if To >= From then
         return To - From + 1;
      else
         return (List_Index'Last + 1 - From) + (1 + To);
      end if;
   end Length;

   procedure Initialize (KH : in out Knot_Hash_Type)
   is
   begin
      KH.List := Create_Hash_List;
   end Initialize;

   procedure Knot_Sparse_Hash_Round (KH    : in out Knot_Hash_Type;
                                     Input : in     Length_List_Type)
   is
      procedure Reverse_Subarray 
         (List : in out Hash_List_Type;
          From : in     List_Index;
          To   : in     List_Index)
      is
         Tmp : Hash_Value;
         I   : List_Index := 0;
      begin
         while I < Length (From, To) / 2 loop
            Tmp := List (From + I);
            List (From + I) := List (To - I);
            List (To - I) := Tmp;
            I := I + 1;
         end loop;
      end Reverse_Subarray;
   begin
      for Length of Input loop
         Reverse_Subarray (List => KH.List,
                           From => KH.Current,
                           To   => KH.Current + Length - 1);

         KH.Current := KH.Current + Length + KH.Skip_Size;
         KH.Skip_Size := KH.Skip_Size + 1;
      end loop;
   end Knot_Sparse_Hash_Round;

   function Create_Representation (IA : in Dense_Hash_List_Type)
                                   return String
   is
      Repr : UString;
   begin
      for Val of IA loop
         Repr := Repr & Integer_To_Hex (Integer (Val));
      end loop;
      return To_String (Repr);
   end Create_Representation;

   function Get_Dense_Hash_16 (KH : in Knot_Hash_Type)
                               return Dense_Hash_List_Type
   is
      function Xor_Sum (IA : in Dense_Hash_List_Type)
                    return Hash_Value
      is
         Tmp : Hash_Value := IA (IA'First);
      begin
         for I in IA'First + 1 .. IA'Last loop
            Tmp := Tmp xor IA (I);
         end loop;
         return Tmp;
      end Xor_Sum;

      Dense : Dense_Hash_List_Type;
      B : List_Index := 0;
   begin
      for Block in Dense'Range loop
         Dense (Block) := 
            Xor_Sum (Dense_Hash_List_Type (KH.List (B .. B + Nof_Dense_Elt - 1)));
         B := B + Nof_Dense_Elt;
      end loop;

      return Dense;
   end Get_Dense_Hash_16;

   function Knot_Hash_Of_String (S : in String)
                                 return Dense_Hash_List_Type
   is
      Knot_Hash : Knot_Hash_Type;
      Tail : constant Integer_Vec := 
         To_Integer_Vector ((17, 31, 73, 47, 23));
      Data : Integer_Vec := To_Ascii_Vec (S);
   begin
      Data.Append (Tail);

      Initialize (Knot_Hash);

      declare
         Input : constant Length_List_Type :=
            Create_Length_List (Data);
      begin
         for Round in 1 .. 64 loop
            Knot_Sparse_Hash_Round (Knot_Hash, Input);
         end loop;
      end;

      return Get_Dense_Hash_16 (Knot_Hash);
   end Knot_Hash_Of_String;

   function Knot_Hash_Of_String (S : in String)
                                 return String
   is
   begin
      return Create_Representation (Knot_Hash_Of_String (S));
   end Knot_Hash_Of_String;

end AOC.Hash;