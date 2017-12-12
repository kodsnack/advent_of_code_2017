import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Scanner;

public class Puzzle_24 {

    public static void main (String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }
        try {
            HashMap<Integer,HashSet<Integer>> map = new HashMap<>();
            Scanner sc = new Scanner(new File(args[0]));
            while(sc.hasNextLine()) {
                String s = sc.nextLine();
                Scanner sc2 = new Scanner(s);
                int current = sc2.nextInt();
                map.put(current, new HashSet<>());
                if(sc2.hasNext()) {
                    sc2.next();
                    while(sc2.hasNext()) {
                        String s3 = sc2.next();
                        if(s3.charAt(s3.length()-1) == ',') {
                            s3 = s3.substring(0,s3.length()-1);
                        }
                        map.get(current).add(Integer.parseInt(s3));
                    }
                }
            }
            HashSet<Integer> inGroup = new HashSet<>();
            LinkedList<Integer> todo = new LinkedList<>();
            int groups = 0;
            for(Integer i : map.keySet()) {
                todo.add(i);
            }

            while(!todo.isEmpty()) {
                int j = todo.poll();
                if(!inGroup.contains(j)) {
                    groups++;
                    LinkedList<Integer> queue = new LinkedList<>();
                    HashSet<Integer> visited = new HashSet<>();
                    queue.add(j);

                    while(!queue.isEmpty()) {
                        int current = queue.poll();
                        visited.add(current);
                        inGroup.add(current);

                        for(Integer i : map.get(current)) {
                            if(!visited.contains(i)) {
                                queue.add(i);
                            }
                        }
                    }
                }
            }

            System.out.println(groups);
        }
        catch(FileNotFoundException e) {
            System.out.println("No parse");
        }
    }
}
