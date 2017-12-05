import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class Puzzle_8 {

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

                int anagrams = 0;
                for(String s1 : h.keySet()) {
                    for(String s2 : h.keySet()) {
                        if(s1.equals(s2)) {
                            continue;
                        }
                        else if(s1.length() == s2.length()) {
                            List<Character> c1 = new ArrayList<>();
                            List<Character> c2 = new ArrayList<>();
                            for(Character c : s1.toCharArray()) {
                                c1.add(c);
                            }
                            for(Character c : s2.toCharArray()) {
                                c2.add(c);
                            }

                            boolean anagram = true;
                            for(Character c : s1.toCharArray()) {
                                if(c2.contains(c)) {
                                    c2.remove(c);
                                    c1.remove(c);
                                }
                                else {
                                    anagram = false;
                                    break;
                                }
                            }
                            if(anagram && c1.isEmpty() && c2.isEmpty()){
                                anagrams++;
                            }
                        }
                    }
                }

                if(!duplicate && !(anagrams > 0)) {
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
