with Ada.Text_IO;

package body AOC.Solver is

   type Particle_State is record
      Pos, Vel, Acc : Point3;
      Has_Collided : Boolean := False;
   end record;

   type Particle_List is array (Natural range <>) of Particle_State;

   function Create_Initial_State (Input : in String_Vec)
                                  return Particle_List
   is
      Particles : Particle_List (Input.First_Index .. Input.Last_Index);
      Splitted : String_Vec;

      function Get_State (S : in String) return Point3
      is
         Splitted : String_Vec;
      begin
         Split_String_At_Char (S, '<', Splitted);
         Split_String_At_Char (To_String (Splitted.Element (1)), '>', Splitted);
         Split_String_At_Char (To_String (Splitted.Element (0)), ',', Splitted);
         return (X => To_Integer (Splitted.Element (0)),
                 Y => To_Integer (Splitted.Element (1)),
                 Z => To_Integer (Splitted.Element (2)));
      end Get_State;
   begin
      for Row in Particles'Range loop
         Split_String_At_Char (To_String (Input.Element (Row)), ' ', Splitted);
         for Sub of Splitted loop
            declare
               FSub : constant String := To_String (Sub);
            begin
               if First_Char (FSub) = 'p' then
                  Particles (Row).Pos := Get_State (FSub);
               elsif First_Char (FSub) = 'v' then
                  Particles (Row).Vel := Get_State (FSub);
               elsif First_Char (FSub) = 'a' then
                  Particles (Row).Acc := Get_State (FSub);
               else
                  raise Constraint_Error;
               end if;
            end;
         end loop;
      end loop;

      return Particles;
   end Create_Initial_State;

   procedure Create_Initial_Magnitudes (Input : in     String_Vec;
                                        Acc   :    out Integer_Vec;
                                        Vel   :    out Integer_Vec;
                                        Pos   :    out Integer_Vec)
   is
      Particles : constant Particle_List := Create_Initial_State (Input);
   begin
      for P of Particles loop
         Pos.Append (Manhattan_Distance (P.Pos));
         Vel.Append (Manhattan_Distance (P.Vel));
         Acc.Append (Manhattan_Distance (P.Acc));
      end loop;
   end Create_Initial_Magnitudes;

   procedure Update_Particles (Particles : in out Particle_List)
   is
   begin
      for P of Particles loop
         if not P.Has_Collided then
            P.Vel := P.Vel + P.Acc;
            P.Pos := P.Pos + P.Vel;
         end if;
      end loop;
   end Update_Particles;

   procedure Detect_Collisions (Particles          : in out Particle_List;
                                Nof_Coll_Particles :    out Natural)
   is
   begin
      Nof_Coll_Particles := 0;
      for I in Particles'Range loop
         if not Particles (I).Has_Collided then
            for J in Particles'Range loop
               if not Particles (J).Has_Collided then
                  if I /= J and then 
                     Particles (I).Pos = Particles (J).Pos
                  then
                     if Particles (I).Has_Collided then
                        -- I already collided with another J
                        Nof_Coll_Particles := Nof_Coll_Particles + 1;
                     else
                        Nof_Coll_Particles := Nof_Coll_Particles + 2;
                     end if;
                     Particles (I).Has_Collided := True;
                     Particles (J).Has_Collided := True;
                  end if;
               end if;
            end loop;
         end if;
      end loop;
   end Detect_Collisions;

   function Find_Minimums (IV : in Integer_Vec) 
                           return Integer_Vec
   is
      Min_First_Index : Integer;
      Min_Val : constant Integer := 
         Min (To_Integer_Array (IV), Min_First_Index);
      Min_Indices : Integer_Vec;
   begin
      for I in Min_First_Index .. IV.Last_Index loop
         if IV.Element (I) = Min_Val then
            Min_Indices.Append (I);
         end if;
      end loop;
      return Min_Indices;
   end Find_Minimums;

   function Sel (IV   : in Integer_Vec;
                 Elts : in Integer_Vec)
                 return Integer_Vec
   is
      Tmp : Integer_Vec;
   begin
      for I of Elts loop
         if I in IV.First_Index .. IV.Last_Index then
            Tmp.Append (IV.Element (I));
         end if;
      end loop;
      return Tmp;
   end Sel;

   function Part_1 (Input : in String_Vec) 
                    return Natural
   is
      Acc_Mag, Vel_Mag, Pos_Mag : Integer_Vec;
      Acc_Min_idx, Vel_Min_idx, Pos_Min_Idx : Integer_Vec;
   begin
      -- All particles with nonzero acceleration will move away from origin.
      -- The ones with the lowest acceleration will remain closest for t-> inf.
      -- If several particles have zero acceleration, the ones with
      -- the lowest initial velocity will remain closest to the origin. 
      -- If several particles have zero initial velocity, the ones with
      -- the lowest initial distance will remain closest to the origin. 

      Create_Initial_Magnitudes (Input, Acc_Mag, Vel_Mag, Pos_Mag);

      Acc_Min_idx := Find_Minimums (Acc_Mag);
      Vel_Min_Idx := Find_Minimums (Sel (Vel_Mag, Acc_Min_idx));
      Pos_Min_Idx := Find_Minimums (Sel (Pos_Mag, Vel_Min_idx));

      return Acc_Min_idx.Element 
         (Vel_Min_idx.Element (Pos_Min_Idx.First_Element));
   end Part_1;

   function Part_2 (Input : in String_Vec)
                    return Natural
   is
      Particles : Particle_List := Create_Initial_State (Input);
      Nof_Alive : Natural := Particles'Length;
      Nof_Coll_Particles : Natural;
      Ticks : Natural := 0;
   begin
      -- Brute force naive-isch solution
      -- Break when no collisions has been detected for some time...
      while Ticks < 50 loop
         Detect_Collisions (Particles, Nof_Coll_Particles);
         Nof_Alive := Nof_Alive - Nof_Coll_Particles;
         if Nof_Coll_Particles /= 0 then
            Ticks := 0;
         else
            Ticks := Ticks + 1;
         end if;
         Update_Particles (Particles);
      end loop;

      return Nof_Alive;
   end Part_2;

   procedure Run is
      use Ada.Text_IO;

      Input : String_Vec;
   begin
      Get_File_Rows (Input, "day20/input.txt");

      Put_Line ("Part 1: " & Part_1 (Input)'Img);
      Put_Line ("Part 2: " & Part_2 (Input)'Img);
   end Run;

end AOC.Solver;