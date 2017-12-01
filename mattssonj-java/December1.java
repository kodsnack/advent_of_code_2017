package com.company;

/**
 * Mitt mål med lösningen var att kunna använda samma loop för båda uträkningarna och därav blev
 * det flera parametrar.
 *
 * Då jag visste vad min sträng skulle vara orkade jag inte göra några Exceptions.
 */

public class December1 {

    private static int sumForAssignment(String captchaString, int loopLength,
                                        int addToIndex, int multiplier, boolean checkFirst) {
        int sum = 0;
        for (int i = 0; i < loopLength; i++) {
            char number = captchaString.charAt(i);
            if (i + addToIndex >= captchaString.length()) {
                break;
            }
            if (number == captchaString.charAt(i + addToIndex)) {
                sum += convertCharToInt(number);
            }
        }

        if (checkFirst) {
            char firstChar = captchaString.charAt(0);
            if (firstChar == captchaString.charAt(captchaString.length() - 1)) {
                sum += convertCharToInt(firstChar);
            }
        }

        return sum * multiplier;
    }

    private static int sumForAssignment(String captchaString, int loopLength,
                                       int addToIndex, int multiplier) {
        return sumForAssignment(captchaString, loopLength, addToIndex, multiplier, false);
    }

    private static int convertCharToInt(char c) {
        String character = String.valueOf(c);
        return Integer.valueOf(character);
    }

    /**
     * Solution for first assignment
     * @param captchaString
     * @return
     */
    public static int sumForAssignment(String captchaString) {
        return sumForAssignment(captchaString, captchaString.length(), 1, 1, true);
    }

    /**
     * Solution for second assignment
     * @param captchaString
     * @return
     */
    public static int sumForAssignment2(String captchaString) {
        int assignment2Length = captchaString.length();
        return sumForAssignment(captchaString,
                assignment2Length / 2,
                assignment2Length / 2,
                2);
    }
}
