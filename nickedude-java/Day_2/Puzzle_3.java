import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Puzzle_3 {

    public static void main (String[] args) {
        if(args == null || args[0] == null) {
            System.out.println("No argument provided :-(");
        }
        try {
            Scanner sc = new Scanner(new File(args[0]));
            ArrayList<ArrayList<Integer>> list = new ArrayList<>();

            while(sc.hasNextLine())  {
                ArrayList<Integer> innerList = new ArrayList<>();
                list.add(innerList);
                String s = sc.nextLine();
                Scanner sc2 = new Scanner(s);
                while(sc2.hasNextInt()) {
                    innerList.add(sc2.nextInt());
                }
            }

            int checksum =0;

            for(ArrayList<Integer> l : list) {
                int max = Integer.MIN_VALUE;
                int min = Integer.MAX_VALUE;

                for(Integer i : l) {
                    if(i < min) {
                        min = i;
                    }
                    if(i > max) {
                        max = i;
                    }
                }

                checksum += max - min;
            }

            System.out.println(checksum);
        }
        catch(FileNotFoundException e) {
            System.out.println("No file found :-(");
        }
    }
}
