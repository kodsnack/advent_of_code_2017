public class December5 {

    public static int getNumberOfSteps(int[] offsets) {
        int position = 0, sum = 0, tmp;

        while (position < offsets.length) {
            tmp = offsets[position];
            offsets[position]++;
             sum++;
            position += tmp;
        }

        return sum;
    }

    public static int getNumberOfStepsAssign2(int[] offsets) {
        int position = 0, sum = 0, tmp;

        while (position < offsets.length) {
            tmp = offsets[position];
            if (tmp >= 3) {
                offsets[position]--;
            } else {
                offsets[position]++;
            }
            sum++;
            position += tmp;
        }

        return sum;
    }
}
