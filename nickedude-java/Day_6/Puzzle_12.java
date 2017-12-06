import java.util.ArrayList;

public class Puzzle_12 {

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

        ArrayList<ArrayCyclePair> seen = new ArrayList<>();
        int counter = 0;
        while(true) {
            seen.add(new ArrayCyclePair(a.clone(),counter));
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
            maxIndex = newMaxIndex;
            counter++;
            int result = seenBefore(a,seen);
            if(result > 0) {
                System.out.println(counter - result);
                return;
            }
        }
    }



    public static int seenBefore(int[] a, ArrayList<ArrayCyclePair> seen) {
        for(ArrayCyclePair p : seen) {
            int[] b = p.arr;
            boolean s = true;
            for(int i = 0; i < a.length; i++) {
                if(a[i] != b[i]) {
                    s = false;
                    break;
                }
            }
            if(s) {
                return p.cycle;
            }
        }
        return -1;
    }
}

class ArrayCyclePair {
    public int[] arr;
    public int cycle;

    public ArrayCyclePair(int[] arr, int cycle) {
        this.arr = arr;
        this.cycle = cycle;
    }
}
