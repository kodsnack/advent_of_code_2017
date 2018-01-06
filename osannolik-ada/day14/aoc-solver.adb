with Ada.Text_IO;
with AOC.Hash; 

package body AOC.Solver is
   use AOC.Hash;

   type Square is record
      Value : Boolean;
      Group : Natural;
      Visited : Boolean;
   end record;

   type Disk_Grid is array
       (Natural range 0 .. 127, Natural range 0 .. 127) of Square;

   function Calculate_Disk_Grid (Input : in String)
                                 return Disk_Grid
   is
      Disk : Disk_Grid;
   begin
      for Row in Disk'Range (1) loop
         declare
            Row_Key : constant String := Input & "-" & Image (Row);
            Hash    : constant Dense_Hash_List_Type := Knot_Hash_Of_String (Row_Key);
            Hash_Bin : UString;
         begin
            for H of Hash loop
               Hash_Bin := Hash_Bin & Integer_To_Bin (Integer (H));
            end loop;
            declare
               BA : constant Boolean_Array := 
                  To_Boolean_Array (To_String (Hash_Bin));
            begin
               for Elt in Disk'Range (2) loop
                  Disk (Row, Elt) := (Value   => BA (Elt),
                                      Group   => 0,
                                      Visited => False);
               end loop;
            end;
         end;
      end loop;

      return Disk;
   end Calculate_Disk_Grid;

   function Part_1 (Disk : in Disk_Grid)
                    return Natural
   is
      Nof_1s : Natural := 0;
   begin
      for Sq of Disk loop
         if Sq.Value then
            Nof_1s := Nof_1s + 1;
         end if;
      end loop;

      return Nof_1s;
   end Part_1;

   procedure Assign_Connected_Squares_To_Group 
      (Disk         : in out Disk_Grid;
       Row          : in     Natural;
       Elt          : in     Natural;
       Group        : in     Natural;
       Nof_Assigned :    out Natural)
   is
      Adjs : constant array (Natural range <>) of Point :=
         ((Row + 1, Elt),     (Row - 1, Elt), 
          (Row,     Elt + 1), (Row,     Elt - 1));
      Adjs_Assigned : Natural;
   begin
      Nof_Assigned := 0;

      if Disk (Row, Elt).Visited then
         return;
      end if;

      Disk (Row, Elt).Visited := True;

      if not Disk (Row, Elt).Value then
         return;
      end if;

      Disk (Row, Elt).Group := Group;
      Nof_Assigned := 1;

      for P of Adjs loop
         if P.X in Disk'Range (1) and
            P.Y in Disk'Range (2) 
         then
            Assign_Connected_Squares_To_Group
               (Disk         => Disk,
                Row          => P.X,
                Elt          => P.Y,
                Group        => Group,
                Nof_Assigned => Adjs_Assigned);

            Nof_Assigned := Nof_Assigned + Adjs_Assigned;
         end if;
      end loop;
   end Assign_Connected_Squares_To_Group;

   function Part_2 (Disk : in out Disk_Grid)
                    return Natural
   is
      Group : Positive := 1;
      Nof_Assigned : Natural;
   begin
      for Row in Disk'Range (1) loop
         for Elt in Disk'Range (2) loop
            Assign_Connected_Squares_To_Group
               (Disk         => Disk,
                Row          => Row,
                Elt          => Elt,
                Group        => Group,
                Nof_Assigned => Nof_Assigned);

            if Nof_Assigned > 0 then
               Group := Positive'Succ (Group);
            end if;
         end loop;
      end loop;

      return Group - 1;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Disk : Disk_Grid := 
         Calculate_Disk_Grid (Get_File_String ("day14/input.txt"));
   begin
      Put_Line ("Part 1: " & Part_1 (Disk)'Img);
      Put_Line ("Part 2: " & Part_2 (Disk)'Img);
   end Run;

end AOC.Solver;