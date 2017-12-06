import java.util.Arrays;
import java.util.HashMap;

public class December6 {

    /**
     * Eftersom jag använder en array som inparameter låter jag den i assign 1 loopa igenom och ge mig talet.
     * I uppgift 2, eftersom ursprungsarrayen då kommer vara ändrat till den senast hittade i uppgift 1 slänger jag
     * in den arrayen på nytt.
     * @param memoryBanks
     * @return
     */
    public static int getNumberOfIteration(int[] memoryBanks) {
        HashMap<Integer, int[]> states = new HashMap<>();

        int currentHash = Arrays.hashCode(memoryBanks), sum = 0, startIndex;

        while (!states.containsKey(currentHash)) {
            states.put(currentHash, memoryBanks.clone());
            startIndex = getHighestIndex(memoryBanks);
            int value = memoryBanks[startIndex];
            memoryBanks[startIndex] = 0;
            for (int i = 0; i < value; i++) {
                if (++startIndex == memoryBanks.length) {
                    startIndex = 0;
                }
                memoryBanks[startIndex]++;
            }
            currentHash = Arrays.hashCode(memoryBanks);
            sum++;
        }

        return sum;
    }

    private static int getHighestIndex(int[] array) {
        if (array.length <= 0) return -1;
        int higest = array[0], index = 0;
        for (int i = 1; i < array.length; i++) {
            if (higest < array[i]) {
                higest = array[i];
                index = i;
            }
        }
        return index;
    }

}
