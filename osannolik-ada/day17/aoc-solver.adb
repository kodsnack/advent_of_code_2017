with Ada.Text_IO;

package body AOC.Solver is

   Step_Size : constant := 328; --  Puzzle input

   type Spin_Lock is record
      Buffer        : Integer_Vec;
      Position      : Natural;
      Length        : Natural;
      Value_After_0 : Natural;
   end record;

   procedure Initialize (SL : in out Spin_Lock)
   is
   begin
      SL.Buffer.Clear;
      SL.Buffer.Append (0);
      SL.Length := 1;
      SL.Position := SL.Buffer.First_Index;
   end Initialize;

   procedure Iterate_P1 (SL : in out Spin_Lock)
   is
   begin
      SL.Position := ((SL.Position + Step_Size) mod Integer (SL.Buffer.Length)) + 1;
      SL.Buffer.Insert (SL.Position, SL.Length);
      SL.Length := Natural'Succ (SL.Length);
   end Iterate_P1;

   procedure Iterate_P2 (SL : in out Spin_Lock)
   is
   begin --  Faster version optimized for finding value after 0...
      SL.Position := ((SL.Position + Step_Size) mod Integer (SL.Length)) + 1;

      if SL.Position = 1 then
         SL.Value_After_0 := SL.Length;
      end if;

      SL.Length := Natural'Succ (SL.Length);
   end Iterate_P2;

   function Get_Value_After (SL    : in Spin_Lock;
                             Value : in Natural)
                             return Natural
   is
   begin
      return SL.Buffer.Element (SL.Buffer.Find_Index (Value) + 1);
   end Get_Value_After;

   procedure Run is
      use Ada.Text_IO;
      
      Lock : Spin_Lock;
   begin
      Initialize (Lock);

      while Lock.Length < 2018 loop
         Iterate_P1 (Lock);
      end loop;

      Put_Line ("Part 1: " & Get_Value_After (Lock, 2017)'Img);

      Initialize (Lock);

      while Lock.Length < 50_000_000 loop
         Iterate_P2 (Lock);
      end loop;

      Put_Line ("Part 2: " & Lock.Value_After_0'Img);
   end Run;

end AOC.Solver;