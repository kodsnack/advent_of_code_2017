import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Puzzle_4 {

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

            int sum =0;

            for(ArrayList<Integer> l : list) {
                for(int k = 0; k < l.size(); k++) {
                    int i  = l.get(k);
                    for(int p = 0; p < l.size(); p++) {
                        int j = l.get(p);
                        if(((i % j) == 0) && (p != k)) {
                            sum += (i/j);
                        }
                    }
                }
            }

            System.out.println(sum);
        }
        catch(FileNotFoundException e) {
            System.out.println("No file found :-(");
        }
    }
}
