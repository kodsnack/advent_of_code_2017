import java.util.LinkedList;

public class Puzzle_21 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args! :-(");
            return;
        }

        String steps[] = args[0].split(",");
        int stepcount = 0;

        int n = 0;
        int s = 0;
        int ne = 0;
        int se = 0;
        int nw = 0;
        int sw = 0;

        for(String str : steps) {
            switch(str) {
                case "n": n++; break;
                case "s": s++; break;
                case "ne": ne++; break;
                case "se": se++; break;
                case "nw": nw++; break;
                case "sw": sw++; break;
                default: System.out.println("Somethings wrong"); break;
            }
        }

        while(n > 0 && s > 0) {
            n--;
            s--;
        }

        while(ne > 0 && sw > 0) {
            ne--;
            sw--;
        }

        while(nw > 0 && se > 0) {
            nw--;
            se--;
        }

        while(ne > 0 && s > 0) {
            ne--;
            s--;
            stepcount++;
        }

        while(nw > 0 && s > 0) {
            nw--;
            s--;
            stepcount++;
        }

        while(se > 0 && n > 0) {
            se--;
            n--;
            stepcount++;
        }

        while(sw > 0 && n > 0) {
            sw--;
            n--;
            stepcount++;
        }

        while(se > 0 && sw > 0) {
            se--;
            sw--;
            stepcount++;
        }

        while(nw > 0 && ne > 0) {
            nw--;
            ne--;
            stepcount++;
        }

        stepcount += n + s + se + sw + nw + ne;

        System.out.println(stepcount);
    }
}
