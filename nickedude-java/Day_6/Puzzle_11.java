import java.util.ArrayList;

public class Puzzle_11 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        int[] a = new int[args.length];

        for(int i = 0; i < args.length; i++) {
            a[i] = Integer.parseInt(args[i]);
        }

        int max = Integer.MIN_VALUE;
        int maxIndex = 0;

        for(int i = 0; i < a.length; i++) {
            if(a[i] > max) {
                max = a[i];
                maxIndex = i;
            }
        }

        ArrayList<int[]> seen = new ArrayList<>();
        int counter = 0;
        while(true) {
            seen.add(a.clone());
            int content = a[maxIndex];
            a[maxIndex] = 0;

            int addToAll = 0;
            while(content > a.length) {
                addToAll++;
                content -= a.length;
            }
            int newMaxIndex = 0;
            max = Integer.MIN_VALUE;
            for(int i = 1; i < a.length+1; i++) {
                int j = (i+maxIndex)%a.length;
                int toAdd = addToAll + ((content-- > 0)? 1 : 0);
                a[j] += toAdd;
                if(a[j] > max) {
                    max = a[j];
                    newMaxIndex = j;
                }
                else if(a[j] == max && j < newMaxIndex) {            //Lowest index must be prioritized
                    newMaxIndex = j;
                }
            }

            counter++;
            maxIndex = newMaxIndex;
            if(seenBefore(a,seen)) {
                System.out.println(counter);
                return;
            }
        }
    }

    public static boolean seenBefore(int[] a, ArrayList<int[]> seen) {
        boolean result = false;
        for(int[] b : seen) {
            boolean s = true;
            for(int i = 0; i < a.length; i++) {
                if(a[i] != b[i]) {
                    s = false;
                    break;
                }
            }
            result = result || s;
        }
        return result;
    }
}
