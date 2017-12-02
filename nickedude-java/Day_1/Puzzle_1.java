public class Puzzle_1 {

    public static void main(String[] args) {
        if(args[0] == null) {
            System.out.println("No puzzle provided");
            return;
        }

        String s = args[0];
        char[] c = s.toCharArray();
        int[]  p = new int[c.length];

        for(int i = 0; i < c.length; i++) {
            p[i] = Character.getNumericValue(c[i]);
        }

        int count = 0;
        for(int i = 0; i < p.length; i++) {
            int next = (i+1) % p.length;
            if(p[i] == p[next]) {
                count+= p[i];
            }
        }

        System.out.println(count);
    }
}
