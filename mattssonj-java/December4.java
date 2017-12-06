import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class December4 {

    // Assign 1
    public static int day4Step1(String string) {
        List<String> words = Arrays.asList(string.split("\n\r|\n"));
        int totalRows = 0;
        int sum = 0;
        for (String s : words) {
            totalRows++;
            if (isValid(s)) sum++;
        }
        System.out.println(totalRows);
        return sum;
    }

    private static boolean isValid(String row) {
        List<String> words = Arrays.asList(row.split(" "));
        List<String> checkedWords = new ArrayList<>();

        for (String s : words) {
            if (checkedWords.contains(s)) return false;
            checkedWords.add(s);
        }
        return true;
    }

    // Assign 2
    public static int day4Step2(String string) {
        List<String> rows = Arrays.asList(string.split("\n\r|\n"));
        int sum = 0;
        for (String row : rows) {
            if (isSecurityValid(row)) sum++;
        }
        return sum;
    }

    private static boolean isSecurityValid(String row) {
        List<String> words = Arrays.asList(row.split(" "));
        List<String> checkedWords = new ArrayList<>();

        for (String s : words) {
            if (containsSameLetters(checkedWords, s)) return false;
            checkedWords.add(s);
        }
        return true;

    }

    private static boolean containsSameLetters(List<String> words, String currentWord) {
        for (String s : words) {
            if (isPalindrome(s, currentWord)) {
                return true;
            }
        }
        return false;
    }

    private static boolean isPalindrome(String first, String second) {
        if (first.length() != second.length()) return false;
        char[] checkAndReplace = second.toCharArray();
        char[] array = first.toCharArray();

        for (int i = 0; i < second.length(); i++) {
            char checkC = array[i];
            for (int j = 0; j < second.length(); j++) {
                if (checkC == checkAndReplace[j]) {
                    checkAndReplace[j] = '_';
                }
            }
        }

        for (char c : checkAndReplace) {
            if (c != '_') {
                return false;
            }
        }
        return true;
    }
}
