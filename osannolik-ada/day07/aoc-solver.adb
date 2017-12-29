with Ada.Text_IO;

package body AOC.Solver is

   type Node_Type is record
      Name : UString;
      Nodes : String_Vec;
   end record;

   package V_Nodes is new Ada.Containers.Vectors
      (Natural,
       Node_Type);

   subtype Nodes_Vec is V_Nodes.Vector;

   procedure Create_Nodes (Nodes : in out Nodes_Vec;
                           Input : in     String_Vec)
   is
      Splitted_Row : String_Vec;
      Node : Node_Type;
   begin
      for Row of Input loop
         Split_String_At_Char 
            (S       => To_String (Row),
             Char    => '>',
             Strings => Splitted_Row);

         if Integer (Splitted_Row.Length) > 1 then
            Split_String_At_Char 
               (S       => To_String (Splitted_Row.Last_Element),
                Char    => ',',
                Strings => Splitted_Row);

            for N of Splitted_Row loop
               Node.Nodes.Append (Trim (N, Ada.Strings.Both));
            end loop;
         end if;

         Split_String_At_Char 
            (S       => To_String (Row),
             Char    => ' ',
             Strings => Splitted_Row);

         Node.Name := Splitted_Row.First_Element;

         Nodes.Append (Node);
      end loop;
   end Create_Nodes;

   function Part_1 (Nodes_List : in Nodes_Vec)
                    return String
   is
      Has_Parent : String_Vec;
      Has_No_Parent : String_Vec;
   begin
      for Node of Nodes_List loop
         for Child of Node.Nodes loop
            Has_Parent.Append (Child);
         end loop;
      end loop;

      for Node of Nodes_List loop
         if not Has_Parent.Contains (Node.Name) then
            Has_No_Parent.Append (Node.Name);
         end if;
      end loop;

      return To_String (Has_No_Parent.First_Element);
   end Part_1;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
      Nodes_List : Nodes_Vec;
   begin
      AOC.Get_File_Rows (Input, "day07/input.txt");

      Create_Nodes (Nodes_List, Input);

      -- for N of Nodes_List loop
      --    Put_Line (To_String (N.Name));
      --    for M of N.Nodes loop
      --       Put_Line ("  -> " & To_String (M));
      --    end loop;
      -- end loop;

      Put_Line ("Part 1: " & Part_1 (Nodes_List));
   end Run;

end AOC.Solver;