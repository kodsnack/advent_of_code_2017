import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Scanner;

public class Puzzle_13 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        HashSet<Node> tree = new HashSet<>();

        try {
            Scanner sc = new Scanner(new File(args[0]));

            while(sc.hasNextLine()) {
                Scanner sc2 = new Scanner(sc.nextLine());
                String name = sc2.next();
                String weight = sc2.next();
                int w = Integer.parseInt(weight.substring(1,weight.length()-1));
                Node n = new Node(name,w);
                tree.add(n);
                if(sc2.hasNext()) {
                    sc2.next();
                    while(sc2.hasNext()) {
                        String s = sc2.next();
                        char end = s.charAt(s.length()-1);
                        if(end == ',') {
                            s = s.substring(0,s.length()-1);
                        }
                        n.kids.add(s);
                    }
                }
            }

            System.out.println(findRoot(tree).name);
        }
        catch(FileNotFoundException e) {
            System.out.println("No parse!");
        }

    }

    public static Node findRoot(HashSet<Node> s) {
        LinkedList<Node> candidates = new LinkedList<>();
        for(Node n : s) {
            if(n.kids.size() != 0) {
                candidates.add(n);
            }
        }
        for(Node n1 : candidates) {
            boolean found = true;
            for(Node n2 : candidates) {
                if(n1.equals(n2)) {
                    continue;
                }

                if(n2.kids.contains(n1.name)) {
                    found = false;
                }
            }

            if(found) {
                return n1;
            }
        }

        return null;
    }
}

class Node {
    String name;
    int weight;
    LinkedList<String> kids;

    public Node(String name, int weight) {
        this.name = name;
        this.weight = weight;
        kids = new LinkedList<>();
    }

    public void addKid(String kid) {
        kids.add(kid);
    }
}
