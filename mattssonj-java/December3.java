import java.util.HashMap;

public class December3 {

    // assign 1
    public static int getNumberOfSteps(int startPosition) {

        if (startPosition <= 1) return 0; // base case

        int gridWidth = getGridSize(startPosition);
        return stepsFromToOne(gridWidth, startPosition);
    }

    /**
     * Räknar ut hur stor matrisen måste vara
     * @param neededMaxValue
     * @return
     */
    private static int getGridSize(int neededMaxValue) {
        int gridWidth = 3; // case where 1 is already gone
        int maxValue = gridWidth * gridWidth;
        while (maxValue <= neededMaxValue) {
            gridWidth += 2;
            maxValue = (int) Math.pow(gridWidth, 2);
        }
        return gridWidth;
    }

    /**
     * räknar ut vilken sida, höger vänster över under av 1an den är.
     * Räknar sedan ut stegen från mitten av den raden eller kolumnen och sedan vet jag redan stegen från 1
     * ut till den raden/kolumnen.
     * @param gridWidth
     * @param index
     * @return
     */
    private static int stepsFromToOne(int gridWidth, int index) {
        int innerGridMaxValue = (int) Math.pow((gridWidth - 2), 2);

        // checking on what side of grid we are at
        innerGridMaxValue += gridWidth - 1;
        while (innerGridMaxValue < index) innerGridMaxValue += (gridWidth - 1);

        // we now know the maxvalue on the row or column.
        // math shows we can calculate the steps no
        int lengthOfHalfSide = (gridWidth - 1) / 2;
        int middleOfSide = innerGridMaxValue - lengthOfHalfSide;
        int steps = Math.abs(middleOfSide - index) + lengthOfHalfSide;
        return steps;
    }

    // assign 2
    public static int getNextValueOf(int value) {
        int absoluteMaxWidth = getGridSize(value);

        int[][] matrix = new int[absoluteMaxWidth][absoluteMaxWidth];
        Vector vector = new Vector(absoluteMaxWidth / 2, absoluteMaxWidth / 2);
        matrix[vector.y][vector.x] = 1; // start value

        for (int i = 2; i < absoluteMaxWidth; i += 2) {
            vector.x++; // go one step to the right

            vector.y++;
            for (int j = 0; j < i; j++) { // going i steps up
                vector.y--;
                int nextValue = addNextValue(matrix, vector);
                if (nextValue > value) {
                    return nextValue;
                }
            }

            for (int j = 0; j < i; j++) { // going i steps to the left
                vector.x--;
                int nextValue = addNextValue(matrix, vector);
                if (nextValue > value) {
                    return nextValue;
                }
            }

            for (int j = 0; j < i; j++) { // going i steps down
                vector.y++;
                int nextValue = addNextValue(matrix, vector);
                if (nextValue > value) {
                    return nextValue;
                }
            }

            for (int j = 0; j < i; j++) { // going i steps to the left
                vector.x++;
                int nextValue = addNextValue(matrix, vector);
                if (nextValue > value) {
                    return nextValue;
                }
            }
        }
        return 0;
    }

    private static int addNextValue(int[][] matrix, Vector vector) {
        int nextValue = sumNeighbours(matrix, vector.y, vector.x);
        matrix[vector.y][vector.x] = nextValue;
        return nextValue;
    }



    private static int sumNeighbours(int[][] matrix, int y, int x) {
        int sum = 0;

        // checking neighbours
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                try {
                    sum += matrix[y - 1 + i][x - 1 + j];
                } catch (Exception e) { // if oob just keep going
                    continue;
                }
            }
        }

        return sum;
    }

    private static class Vector {
        public int x, y;

        public Vector(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

}
