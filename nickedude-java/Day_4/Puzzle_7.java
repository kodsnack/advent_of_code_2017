import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Puzzle_7 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }
        try {
            Scanner sc = new Scanner(new File(args[0]));
            int counter = 0;
            while(sc.hasNextLine()) {
                HashMap<String, Integer> h = new HashMap<>();
                String s = sc.nextLine();
                String[] l = s.split("\\s+");
                for (int i = 0; i < l.length; i++) {
                    if (h.get(l[i]) == null) {
                        h.put(l[i], 1);
                    } else {
                        h.put(l[i], h.get(l[i]) + 1);
                    }
                }

                boolean duplicate = false;
                for (String t : h.keySet()) {
                    if (h.get(t) != 1) {
                        duplicate = true;
                    }
                }
                if(!duplicate) {
                    counter++;
                }
            }
            System.out.println(counter);
        }
        catch(FileNotFoundException e) {
            System.out.println("No file found :-(");
        }
    }
}
