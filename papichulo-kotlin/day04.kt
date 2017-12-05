class day04 {
    fun puzzle1(input: String): Boolean {
        val words = input.split(" ")
        val uniqueWords = words.toSet()
        return words.size == uniqueWords.size
    }

    fun solvePuzzle1(input: String): Int {
        var numberOfCorrect = 0
        input.lines()
                .forEach { if (puzzle1(it)) numberOfCorrect++ }
        return numberOfCorrect
    }

    fun puzzle2(input: String): Boolean {
        val words = input.split(" ")
        val uniqueWords = words.toSet()
        if (words.size != uniqueWords.size) {
            return false
        }
        val uniqueSortedWords = words.map { word -> word.toList().sorted().toString() }.toSet()
        return uniqueSortedWords.size == uniqueWords.size
    }

    fun solvePuzzle2(input: String): Int {
        var numberOfCorrect = 0
        input.lines()
                .forEach { if (puzzle2(it)) numberOfCorrect++ }
        return numberOfCorrect
    }
}