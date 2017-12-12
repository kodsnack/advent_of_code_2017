import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Puzzle_17 {

    public static void main (String[] args) {
        if(args.length == 0) {
            System.out.println("No args! :-(");
            return;
        }

        try {
            Scanner sc = new Scanner(new File(args[0]));
            String s = sc.nextLine();
            char[] c = s.toCharArray();
            System.out.println(getScore(c));
        }
        catch(FileNotFoundException e) {
            System.out.println("No file found :-(");
        }
    }

    public static int getScore(char[] c) {
        int score = scoreHelp(c, 0, 0).score;
        return score;
    }

    public static Pair scoreHelp(char[] c, int low, int baseScore) {
        int localScore = 0;
        while(low < c.length) {
            if(c[low] == '{') {
                Pair p = scoreHelp(c, low+1, baseScore+1);
                low = p.index;
                localScore += p.score;
            }
            else if(c[low] == '}') {
                return new Pair(low+1, baseScore + localScore);
            }
            else if(c[low] == '!') {
                low += 2;
            }
            else if(c[low] == '<') {
                while(c[low] != '>') {
                    if(c[low] == '!') {
                        low += 2;
                    }
                    else {
                        low++;
                    }
                }
                low++;
            }
            else if(c[low] == ',') {
                low++;
            }
        }

        return new Pair(low+1,baseScore + localScore);
    }
}

class Pair {
    int index;
    int score;

    public Pair(int index, int score) {
        this.index = index;
        this.score = score;
    }
}

