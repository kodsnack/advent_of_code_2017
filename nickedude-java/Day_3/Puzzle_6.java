import java.awt.*;
import java.util.ArrayList;

public class Puzzle_6 {

    public static void main(String[] args) {
        if(args.length == 0) {
            System.out.println("No args :-(");
            return;
        }

        int input = Integer.parseInt(args[0]);
        int[][] arr = new int[101][101];
        arr[50][50] = 1;
        int cntr = 2;
        int b = 3;
        Point pos = new Point(1,0);

        while(cntr < (arr.length*arr.length)) {
            if(cntr > b*b) {
                b += 2;
            }

            int l = (b-2)*(b-2);
            int a = cntr - l;

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
            else if((((b-1)*2) < a) && (a <= (b-1)*3)) {
                pos.y = (b/2);
                pos.x = -(b/2);
                pos.y -= (a-(2*(b-1)));
            }
            else{
                pos.y = -(b/2);
                pos.x = -(b/2);
                pos.x += (a -((b-1)*3));
            }

            ArrayList<Integer> neighbours = getNeighbours(pos, arr);
            int sum = 0;
            for(Integer i : neighbours) {
                sum += i;
            }

            arr[pos.y+50][pos.x+50] = sum;
            if(sum > input) {
                System.out.println(sum);
                return;
            }
            cntr++;
        }

    }

    public static ArrayList<Integer> getNeighbours(Point pos, int [][] arr) {
        int x = pos.x + 50;
        int y = pos.y + 50;
        ArrayList<Integer> list = new ArrayList<>();
        for(int i = y-1; i < y+2; i++) {
            for(int j = x-1; j < x+2; j++) {
                if(i == y && j == x) {
                    continue;
                }
                if((i < arr.length) && (i > -1) && (j > -1) && (j < arr.length) && (arr[i][j] != 0)) {
                    list.add(arr[i][j]);
                }
            }
        }


        return list;
    }
}
