import java.util.LinkedList;

public class Puzzle_20 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        char[] c = args[0].toCharArray();
        int[] lengths = new int[c.length + 5];
        for(int i = 0; i < c.length; i++) {
            lengths[i] = (int) c[i];
        }
        lengths[c.length] = 17;
        lengths[c.length+1] = 31;
        lengths[c.length+2] = 73;
        lengths[c.length+3] = 47;
        lengths[c.length+4] = 23;

        int[] data = new int[256];
        for(int i = 0; i < 256; i++) {
            data[i] = i;
        }

        int curpos = 0;
        int skip = 0;

        for(int i = 0; i < 64; i++) {
            for (int l : lengths) {
                reverse(data, curpos, l);
                curpos = (curpos + (l + skip)) % data.length;
                skip++;
            }
        }

        int[] dense = new int[16];
        for(int i = 0; i < 16; i++) {
            int sum = data[i*16];
            for(int j = 1; j < 16; j++) {
                sum = sum ^ data[(i*16)+j];
            }
            dense[i] = sum;
        }

        int counter = 0;
        for(Integer i : dense) {
            String s = Integer.toHexString(i);
            if(s.length() == 1) {
                s = "0" + s;
            }
            System.out.print(s);
        }

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
