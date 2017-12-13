import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Puzzle_14 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        HashMap<String,Node> tree = new HashMap<>();

        try {
            Scanner sc = new Scanner(new File(args[0]));

            while(sc.hasNextLine()) {
                Scanner sc2 = new Scanner(sc.nextLine());
                String name = sc2.next();
                String weight = sc2.next();
                int w = Integer.parseInt(weight.substring(1,weight.length()-1));
                Node n = new Node(name,w);
                tree.put(name,n);
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

            System.out.println(checkBalance(tree));
        }
        catch(FileNotFoundException e) {
            System.out.println("No parse!");
        }

    }

    public static int checkBalance(HashMap<String,Node> tree) {
        Node root = findRoot(tree.values());

        checkBalanceHelp(root, tree);
        return 0;
    }

    //Not very pretty

    public static int checkBalanceHelp(Node n, HashMap<String,Node> tree) {
        LinkedList<Integer> kidsBalance = new LinkedList<>();

        for(String kid : n.kids) {
            kidsBalance.add(checkBalanceHelp(tree.get(kid), tree));
        }

        if(kidsBalance.size() > 1) {
            printUnbalanced(tree, kidsBalance, n);
        }

        int sum = 0;
        for(int i = 0; i < kidsBalance.size(); i++) {
            sum += kidsBalance.get(i);
        }
        return sum+n.weight;
    }

    public static void printUnbalanced(HashMap<String,Node> tree, List<Integer> kidsBalance, Node n) {
        HashMap<Integer,Integer> occurences = new HashMap<>();
        for(Integer i : kidsBalance) {
            if(occurences.get(i) == null) {
                occurences.put(i,1);
            }
            else{
                occurences.put(i,occurences.get(i)+1);
            }
        }

        if(occurences.keySet().size() > 1) {
            int leastOccuring = -1;
            int mostOccuring = -1;
            for(Integer k : occurences.keySet()) {
                if(occurences.get(k) == 1 && leastOccuring == -1) {
                    leastOccuring = k;
                }
                else {
                    mostOccuring = k;
                }
            }

            for(int i = 0; i < kidsBalance.size(); i++) {
                int cur = kidsBalance.get(i);
                if(cur == leastOccuring) {
                    int diff = (cur > mostOccuring) ? cur - mostOccuring : mostOccuring - cur;
                    System.out.println("Unbalanced kids found!");
                    System.out.println("Kid " + i + " needs to change weight to " + (tree.get(n.kids.get(i)).weight-diff));
                }
            }
        }
    }

    public static Node findRoot(Collection<Node> s) {
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
