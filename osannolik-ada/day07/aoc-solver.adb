with Ada.Text_IO;

package body AOC.Solver is

   type Node_Type is record
      Name         : UString;
      Weight       : Integer;
      Nodes        : String_Vec;
      Total_Weight : Integer;
      Branch_Nr    : Natural;
   end record;

   Empty_Node : constant Node_Type := 
      (Null_Unbounded_String,
       0,
       V_String.Empty_Vector,
       0,
       0);

   package V_Nodes is new Ada.Containers.Vectors
      (Natural,
       Node_Type);

   subtype Nodes_Vec is V_Nodes.Vector;

   procedure Create_Nodes (Nodes : in out Nodes_Vec;
                           Input : in     String_Vec)
   is
      Tmp : String_Vec;
      Node : Node_Type;
   begin
      for Row of Input loop
         Node.Nodes.Clear;

         Split_String_At_Char 
            (S       => To_String (Row),
             Char    => '>',
             Strings => Tmp);

         if Integer (Tmp.Length) > 1 then
            Split_String_At_Char 
               (S       => To_String (Tmp.Last_Element),
                Char    => ',',
                Strings => Tmp);

            for N of Tmp loop
               Node.Nodes.Append (Trim (N, Ada.Strings.Both));
            end loop;
         end if;

         Split_String_At_Char 
            (S       => To_String (Row),
             Char    => ' ',
             Strings => Tmp);

         Node.Name := Tmp.First_Element;
         
         declare
            Weight : constant String :=
               To_String (Tmp.Element (Tmp.First_Index + 1));
         begin
            Node.Weight := 
               Integer'Value (Weight (Weight'First + 1 .. Weight'Last - 1));
         end;
         
         Node.Total_Weight := 0;
         Node.Branch_Nr := 0;

         Nodes.Append (Node);
      end loop;
   end Create_Nodes;

   function Part_1 (Nodes_List : in Nodes_Vec)
                    return Node_Type
   is
      Has_Parent : String_Vec;
      Head_Node : Node_Type;
   begin
      for Node of Nodes_List loop
         for Child of Node.Nodes loop
            Has_Parent.Append (Child);
         end loop;
      end loop;

      for Node of Nodes_List loop
         if not Has_Parent.Contains (Node.Name) then
            Head_Node := Node;
            exit;
         end if;
      end loop;

      return Head_Node;
   end Part_1;

   function Get_Node (Nodes_List : in Nodes_Vec;
                      Node_Name  : in UString)
                      return Node_Type
   is
   begin
      --  Simple but inefficient
      for Node of Nodes_List loop
         if Node.Name = Node_Name then
            return Node;
         end if;
      end loop;

      return Empty_Node;
   end Get_Node;

   function Is_Unbalanced (Nodes_List : in out Nodes_Vec;
                           Node       : in     Node_Type)
                           return Boolean
   is
      C : Node_Type;
      Weights : Integer_Array 
         (Node.Nodes.First_Index .. Node.Nodes.Last_Index);
   begin
      for I in Weights'Range loop
         C := Get_Node (Nodes_List, Node.Nodes.Element (I));
         Weights (I) := C.Total_Weight;
      end loop;

      for W of Weights loop
         if Weights (Weights'First) /= W then
            return True;
         end if;
      end loop;

      return False;
   end Is_Unbalanced;

   function Calculate_Weights (Nodes_List     : in out Nodes_Vec;
                               Node           : in     Node_Type;
                               Branch_Counter : in     Natural := 0)
                               return Integer
   is
      C        : Node_Type;
      Node_Tmp : Node_Type := Node;

      procedure Update_Node_In_List (Element : in out Node_Type)
      is begin
         Element := Node_Tmp;
      end Update_Node_In_List;
   begin
      Node_Tmp.Total_Weight := Node.Weight;
      Node_Tmp.Branch_Nr := Branch_Counter;

      for Child_Name of Node.Nodes loop
         C := Get_Node (Nodes_List, Child_Name);
         Node_Tmp.Total_Weight := Node_Tmp.Total_Weight + 
            Calculate_Weights (Nodes_List, C, Branch_Counter + 1);
      end loop;

      Nodes_List.Update_Element 
         (Nodes_List.Find_Index (Node), Update_Node_In_List'Access);

      return Node_Tmp.Total_Weight;
   end Calculate_Weights;

   --  Wow, this got nasty...
   function Part_2 (Nodes_List : in out Nodes_Vec;
                    Head_Node  : in     Node_Type)
                    return Integer
   is
      Total_Weight : constant Integer :=
         Calculate_Weights 
            (Nodes_List       => Nodes_List, 
             Node             => Head_Node);
      pragma Unreferenced (Total_Weight);

      Unbalanced_Nodes : Nodes_Vec;
      Branch_Numbers   : Integer_Vec;
   begin
      for N of Nodes_List loop
         if Is_Unbalanced (Nodes_List, N) then
            Unbalanced_Nodes.Append (N);
            Branch_Numbers.Append (N.Branch_Nr);
         end if;
      end loop;

      declare
         I : Integer;
         B : constant Natural := Max (To_Integer_Array (Branch_Numbers), I);
         N : constant Node_Type := Unbalanced_Nodes.Element (I);
         CI, CJ : Node_Type;
         Nof_Other_Weights : Integer_Array 
            (N.Nodes.First_Index .. N.Nodes.Last_Index) := (others => 0);
         pragma Unreferenced (B);
      begin
         --  Assume only one is incorrect...
         for I in Nof_Other_Weights'Range loop
            CI := Get_Node (Nodes_List, N.Nodes.Element (I));
            for J in Nof_Other_Weights'Range loop
               CJ := Get_Node (Nodes_List, N.Nodes.Element (J));
               if I /= J and CI.Total_Weight = CJ.Total_Weight then
                  Nof_Other_Weights (I) := Nof_Other_Weights (I) + 1;
               end if;
            end loop;
         end loop;
         
         declare
            I_Most, I_Least : Integer;
            Most_Occur  : constant Integer := Max (Nof_Other_Weights, I_Most);
            Least_Occur : constant Integer := Min (Nof_Other_Weights, I_Least);
            C_Most : constant Node_Type := 
               Get_Node (Nodes_List, N.Nodes.Element (I_Most));
            C_Least : constant Node_Type := 
               Get_Node (Nodes_List, N.Nodes.Element (I_Least));
            pragma Unreferenced (Most_Occur, Least_Occur);
         begin
            return C_Least.Weight - (C_Least.Total_Weight - C_Most.Total_Weight);
         end;
      end;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input      : String_Vec;
      Nodes_List : Nodes_Vec;
      Head_Node  : Node_Type;
   begin
      AOC.Get_File_Rows (Input, "day07/input.txt");

      Create_Nodes (Nodes_List, Input);

      Head_Node := Part_1 (Nodes_List);

      Put_Line ("Part 1: " & To_String (Head_Node.Name));
      Put_Line ("Part 2: " & Part_2 (Nodes_List, Head_Node)'Img);

   end Run;

end AOC.Solver;