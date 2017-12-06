import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Puzzle_10 {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        try {
            Scanner sc = new Scanner(new File(args[0]));
            ArrayList<Integer> l = new ArrayList<>();
            while(sc.hasNextLine()) {
                String s = sc.nextLine();
                l.add(Integer.parseInt(s));
            }

            int i = 0;
            int counter = 0;

            while(i > -1 && i < l.size()) {
                int steps = l.get(i);
                if(steps >= 3) {
                    l.set(i, steps - 1);
                }
                else {
                    l.set(i, steps + 1);
                }
                counter++;
                i += steps;
            }

            System.out.println(counter);
        }
        catch (FileNotFoundException e) {
            System.out.println("File not found :-(");
        }
    }
}
