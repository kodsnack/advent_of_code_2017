import java.util.LinkedList;
import java.math.BigInteger;

public class Puzzle_27 {

    public static void main(String[] args) {
        KnotHash k = new KnotHash();
        String input = "jzgqcdpd";
        String[] inputArr = new String[128];
        int[][] grid = new int[128][128];
        int[][] regions = new int[128][128];
        for(int i = 0; i < regions.length; i++) {
            for(int j = 0; j < regions[i].length; j++) {
                regions[i][j] = -1;
            }
        }
        int counter = 0;
        for(int i = 0; i < inputArr.length; i++) {
            inputArr[i] = input + "-" + Integer.toString(i);
            String result = k.hash(new String[]{inputArr[i]});
            String binStr = hexStrToBinStr(result);
            char[] c = binStr.toCharArray();
            for(int j = 0; j < c.length; j++) {
                if(c[j] == '1') {
                    grid[i][j] = 1;
                    counter++;
                }
                else {
                    grid[i][j] = 0;
                }
            }
        }
        System.out.println(counter);

        int r = 0;
        for(int i = 0; i < grid.length; i++) {
            for(int j = 0; j < grid[i].length; j++) {
                if (grid[i][j] == 0) {
                    regions[i][j] = -1;
                }
                else if ((grid[i][j] == 1) && (regions[i][j] == -1)){
                    setRegions(grid, regions, i, j, r);
                    r++;
                }
            }
        }
        System.out.println(r);
    }

    public static String hexStrToBinStr(String input) {
        char[] out = new char[input.length()*4];
        String result = "";
        for(int i = 0; i < input.length(); i++) {

            String k = input.substring(i,i+1);
            String binStr = new BigInteger(k, 16).toString(2);
            while(binStr.length() < 4) {
                binStr = "0" + binStr;
            }
            result = result + binStr;
        }
        return result;
    }


    public static void setRegions(int[][] g, int[][] r, int i1, int j1, int rc) {

        LinkedList<Pair> q = new LinkedList<>();
        r[i1][j1] = rc;
        q.add(new Pair(i1, j1));

        while(!q.isEmpty()) {
            Pair p = q.poll();
            int i = p.i;
            int j = p.j;

            if((i-1 > -1) && (g[i-1][j] == 1) && (r[i-1][j] == -1)) {
                q.add(new Pair(i-1,j));
                r[i-1][j] = rc;
            }
            if((i+1 < g.length) && (g[i+1][j] == 1) && (r[i+1][j] == -1)) {
                q.add(new Pair(i+1,j));
                r[i+1][j] = rc;
            }
            if((j+1 < g[0].length) && (g[i][j+1] == 1) && (r[i][j+1] == -1)) {
                q.add(new Pair(i,j+1));
                r[i][j+1] = rc;
            }
            if((j-1 > -1) && (g[i][j-1] == 1) && (r[i][j-1] == -1)) {
                q.add(new Pair(i,j-1));
                r[i][j-1] = rc;
            }
        }
    }

    static class Pair {
        int i;
        int j;

        Pair(int i, int j) {
            this.i = i;
            this.j = j;
        }
    }


    static class KnotHash {

        public String hash(String[] args) {
            if(args.length == 0) {
                System.out.println("No args :-(");
                return "";
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

            String ret = "";
            for(Integer i : dense) {
                String s = Integer.toHexString(i);
                if(s.length() == 1) {
                    s = "0" + s;
                }
                ret = ret + s;
            }
            return ret;

        }

        void reverse(int[] a, int curpos, int length) {
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

}
