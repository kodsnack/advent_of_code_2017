/**
 * Valde att ta in en int matrix. Skapade i projeketet en utils klass som
 * bygger om strängen till en int matrix. Se mitt repo för mer info.
 * Hade inte riktigt tid att göra koden snyggare idag
 */

public class December2 {

    // Assign 1
    public int getChecksum(int[][] matrix) {

        int lowest, highest;
        int[] row;
        int sum = 0;

        for (int i = 0; i < matrix.length; i++) {
            row = matrix[i];
            lowest = getLowestNum(row);
            highest = getHighestNum(row);
            sum += (highest - lowest);
        }

        return sum;
    }

    private int getHighestNum(int[] array) {
        int currentHighest = array[0];
        for (int i = 0; i < array.length; i++) {
            if (currentHighest < array[i]) currentHighest = array[i];
        }
        return currentHighest;
    }

    private int getLowestNum(int[] array) {
        int currentLowest = array[0];
        for (int i = 0; i < array.length; i++) {
            if (currentLowest > array[i]) currentLowest = array[i];
        }
        return currentLowest;
    }

    // Assign 2
    public int getDivideSum(int[][] matrix) {
        /**
         * We know there is only 2 divisible numbers
         */

        int num1, num2, quotient, index;
        int sum = 0;

        for (int i = 0; i < matrix.length; i++) {
            int[] row = matrix[i];

            for (int j = 0; j < matrix[i].length; j++) {
                index = getDivisible(row, j);
                if (index != -1) {
                    num1 = matrix[i][j];
                    num2 = matrix[i][index];

                    quotient = num1 > num2 ? (num1 / num2) : (num2 / num1);

                    sum += quotient;
                }
            }
        }
        return sum;
    }

    /**
     * returns -1 if not divisible, else returns index of divisible
     */
    private int getDivisible(int[] numbers, int startIndex) {
        int numberToDivideWith = numbers[startIndex];
        int remainder;
        for (int i = startIndex + 1; i < numbers.length; i++) {
            remainder = numberToDivideWith <= numbers[i] ?
                    (numbers[i] % numberToDivideWith) :
                    (numberToDivideWith % numbers[i]);
            if (remainder == 0) {
                return i;
            }
        }
        return -1;
    }


}
