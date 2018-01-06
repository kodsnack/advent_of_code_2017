with Ada.Text_IO;
with AOC.Hash; 

package body AOC.Solver is
   use AOC.Hash;

   function To_Boolean_Array (S : in String)
                              return Boolean_Array
   is
      BA : Boolean_Array (0 .. S'Length - 1);
      J : Natural := S'First;
   begin
      for I in BA'Range loop
         BA (I) := (S (J) /= '0');
         J := J + 1;
      end loop;
      return BA;
   end To_Boolean_Array;

   type Disk_Grid is array (Natural range 0 .. 127) of Boolean_Array (0 .. 127);

   function Calculate_Disk_Grid (Input : in String)
                                 return Disk_Grid
   is
      Disk : Disk_Grid;
   begin
      for Row in Disk'Range loop
         declare
            Row_Key : constant String := Input & "-" & Image (Row);
            Hash    : constant Dense_Hash_List_Type := Knot_Hash_Of_String (Row_Key);
            Hash_Bin : UString;
         begin
            for H of Hash loop
               Hash_Bin := Hash_Bin & Integer_To_Bin (Integer (H));
            end loop;
            Disk (Row) := To_Boolean_Array (To_String (Hash_Bin));
         end;
      end loop;

      return Disk;
   end;

   function Part_1 (Disk : in Disk_Grid)
                    return Natural
   is
      Nof_1s : Natural := 0;
   begin
      for Row of Disk loop
         for B of Row loop
            if B then
               Nof_1s := Nof_1s + 1;
            end if;
         end loop;
      end loop;

      return Nof_1s;
   end Part_1;

   procedure Run is
      use Ada.Text_IO;

      Input : constant String := 
         Get_File_String ("day14/input.txt");

      Disk : constant Disk_Grid := Calculate_Disk_Grid (Input);
   begin
      Put_Line ("Part 1: " & Part_1 (Disk)'Img);
   end Run;

end AOC.Solver;