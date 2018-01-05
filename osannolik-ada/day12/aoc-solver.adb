with Ada.Text_IO;

package body AOC.Solver is

   type Vert is record
      Is_Marked : Boolean := False;
      Vertices  : Integer_Vec;
   end record;

   type Graph_Type is array (Natural range <>) of Vert;

   function Create_Graph (Input : in String_Vec)
                          return Graph_Type
   is
      G : Graph_Type (Input.First_Index .. Input.Last_Index);
      Splitted : String_Vec;
   begin
      for Row of Input loop
         Split_String_At_Char (To_String (Row), ' ', Splitted);
         declare
            Id : constant Natural := To_Integer (Splitted.Element (0));
         begin
            Split_String_At_Char (To_String (Row), '>', Splitted);
            Split_String_At_Char (To_String (Splitted.Element (1)), ',', Splitted);
            G (Id) := (Is_Marked => False,
                       Vertices  => To_Integer_Vector (Splitted));
         end;
      end loop;

      return G;
   end Create_Graph;

   procedure Mark_Connected_Vertices (Graph : in out Graph_Type;
                                      Id    : in     Natural)
   is
   begin
      Graph (Id).Is_Marked := True;

      for Vertex_Id of Graph (Id).Vertices loop
         if not Graph (Vertex_Id).Is_Marked then
            Mark_Connected_Vertices (Graph, Vertex_Id);
         end if;
      end loop;
   end Mark_Connected_Vertices;

   function Get_Degree (Graph : in Graph_Type)
                        return Natural
   is
      Count : Natural := 0;
   begin
      for Vertex of Graph loop
         if Vertex.Is_Marked then
            Count := Natural'Succ (Count);
         end if;
      end loop;

      return Count;
   end Get_Degree;

   function Part_1 (Input : in String_Vec)
                    return Natural
   is
      Graph : Graph_Type := Create_Graph (Input);
   begin
      Mark_Connected_Vertices (Graph, 0);
      return Get_Degree (Graph);
   end Part_1;

   function Part_2 (Input : in String_Vec)
                    return Natural
   is
      Graph : Graph_Type := Create_Graph (Input);
      Nof_Groups : Natural := 0;
      Start_Id : Natural := 0;
   begin
      while Get_Degree (Graph) < Graph'Length loop
         for Id in Graph'Range loop
            if not Graph (Id).Is_Marked then
               Start_Id := Id;
            end if;
         end loop;

         Mark_Connected_Vertices (Graph, Start_Id);

         Nof_Groups := Natural'Succ (Nof_Groups);
      end loop;

      return Nof_Groups;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day12/input.txt");

      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;