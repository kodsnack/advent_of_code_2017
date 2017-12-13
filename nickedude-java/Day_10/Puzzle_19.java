import java.util.LinkedList;

public class Puzzle_19 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }


        int[] lengths = new int[args.length];
        for(int i = 0; i < args.length; i++) {
            lengths[i] = Integer.parseInt(args[i]);
        }

        int[] data = new int[256];
        for(int i = 0; i < 256; i++) {
            data[i] = i;
        }

        int curpos = 0;
        int skip = 0;

        for(int l : lengths) {
            reverse(data, curpos, l);
            curpos = (curpos + (l + skip))%data.length;
            skip++;
        }

        System.out.println(data[0] * data[1]);

    }

    public static void reverse(int[] a, int curpos, int length) {
        LinkedList<Integer> stack = new LinkedList<>();
        for(int i = curpos; i < curpos+length; i++) {
            int index = i % a.length;
            stack.addLast(a[index]);
        }
        for(int i = curpos+length-1; i > curpos-1; i--) {
            int index = i % a.length;
            a[index] = stack.removeFirst();
        }
    }
}
