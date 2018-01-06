with Ada.Text_IO;

package body AOC.Solver is

   type Gen_Value is mod 2147483647;

   type Generator is record
      Factor : Gen_Value;
      Value  : Gen_Value;
   end record;

   procedure Update_Mod_N (G : in out Generator;
                           N : in     Gen_Value)
   is
   begin
      loop
         G.Value := G.Factor * G.Value;
         exit when (G.Value mod N) = 0;
      end loop;
   end Update_Mod_N;

   function Judge (A, B : in Gen_Value)
                   return Boolean
   is
   begin
      return (A and 16#FFFF#) = (B and 16#FFFF#);
   end Judge;

   function Part_2 return Natural
   is
      Generator_A : Generator := 
         (Factor => 16807, 
          Value  => 618);
      Generator_B : Generator := 
         (Factor => 48271, 
          Value  => 814);
      Count : Natural := 0;
   begin
      for I in 1 .. 5_000_000 loop
         Update_Mod_N (Generator_A, 4);
         Update_Mod_N (Generator_B, 8);

         if Judge (Generator_A.Value, Generator_B.Value) then
            Count := Natural'Succ (Count);
         end if;
      end loop;

      return Count;
   end Part_2;

   function Part_1 return Natural
   is
      Generator_A : Generator := 
         (Factor => 16807, 
          Value  => 618);
      Generator_B : Generator := 
         (Factor => 48271, 
          Value  => 814);

      Count : Natural := 0;
   begin
      for I in 1 .. 40_000_000 loop
         Update_Mod_N (Generator_A, 1);
         Update_Mod_N (Generator_B, 1);

         if Judge (Generator_A.Value, Generator_B.Value) then
            Count := Natural'Succ (Count);
         end if;
      end loop;

      return Count;
   end Part_1;

   procedure Run is
      use Ada.Text_IO;
   begin
      Put_Line ("Part 1: " & Part_1'Img);
      Put_Line ("Part 2: " & Part_2'Img);
   end Run;

end AOC.Solver;