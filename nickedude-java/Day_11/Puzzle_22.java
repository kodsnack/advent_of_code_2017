import java.util.LinkedList;

public class Puzzle_22 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args! :-(");
            return;
        }

        String steps[] = args[0].split(",");
        int maxStep = Integer.MIN_VALUE;

        int ntot = 0;
        int stot = 0;
        int netot = 0;
        int setot = 0;
        int nwtot = 0;
        int swtot = 0;

        for(String str : steps) {
            switch (str) {
                case "n":
                    ntot++;
                    break;
                case "s":
                    stot++;
                    break;
                case "ne":
                    netot++;
                    break;
                case "se":
                    setot++;
                    break;
                case "nw":
                    nwtot++;
                    break;
                case "sw":
                    swtot++;
                    break;
                default:
                    System.out.println("Somethings wrong");
                    break;
            }

            int stepcount = 0;
            int n = ntot;
            int s = stot;
            int ne = netot;
            int nw = nwtot;
            int sw = swtot;
            int se = setot;

            while (n > 0 && s > 0) {
                n--;
                s--;
            }

            while (ne > 0 && sw > 0) {
                ne--;
                sw--;
            }

            while (nw > 0 && se > 0) {
                nw--;
                se--;
            }

            while (ne > 0 && s > 0) {
                ne--;
                s--;
                stepcount++;
            }

            while (nw > 0 && s > 0) {
                nw--;
                s--;
                stepcount++;
            }

            while (se > 0 && n > 0) {
                se--;
                n--;
                stepcount++;
            }

            while (sw > 0 && n > 0) {
                sw--;
                n--;
                stepcount++;
            }

            while (se > 0 && sw > 0) {
                se--;
                sw--;
                stepcount++;
            }

            while (nw > 0 && ne > 0) {
                nw--;
                ne--;
                stepcount++;
            }

            stepcount += n + s + se + sw + nw + ne;
            if(stepcount > maxStep) {
                maxStep = stepcount;
            }
        }

        System.out.println(maxStep);
    }
}
