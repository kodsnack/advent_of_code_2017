import java.awt.*;

public class Puzzle_5 {

    public static void main (String[] args) {
        if(args.length == 0 || args[0] == null) {
            System.out.println("No args :-(");
            return;
        }

        int n = Integer.parseInt(args[0]);
        int b = (int) Math.ceil(Math.sqrt(n));
        if(b%2 == 0) {
            b++;
        }

        int l = (b-2)*(b-2);
        int a = n - l;

        Point pos = new Point();

        if(a <= (b-1)) {
            pos.y = -(b/2);
            pos.x = (b/2);
            pos.y += a;
        }
        else if((b <= a) && (a <= ((b-1)*2))) {
            pos.y = (b/2);
            pos.x = (b/2);
            pos.x -= a-(b-1);
        }
        else if(((b*2) <= a) && (a <= (b-1)*3)) {
            pos.y = (b/2);
            pos.x = -(b/2);
            pos.y -= (a-(2*(b-1)));
        }
        else{
            pos.y = -(b/2);
            pos.x = -(b/2);
            pos.x += (a -((b-1)*3));
        }
        int dist = Math.abs(pos.x) + Math.abs(pos.y);
        System.out.println(dist);
    }
}
