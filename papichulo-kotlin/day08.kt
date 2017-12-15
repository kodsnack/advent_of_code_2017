class day08 {
    val register = HashMap<String, Int>()
    fun puzzle1(input: String): Int {
        val lines = input.lines()
        for (line in lines) {
            val values = line.split(" ")
            val registerPosition = values[0]
            val action = values[1]
            val amount = values[2].toInt()
            val conditionRegister = values[4]
            val conditionComparator = values[5]
            val conditionAmount = values[6].toInt()
            if (checkCondition(conditionRegister, conditionComparator, conditionAmount)) {
                if ("inc".equals(action)) {
                    register.put(registerPosition, getRegisterValue(registerPosition) + amount)
                } else {
                    register.put(registerPosition, getRegisterValue(registerPosition) - amount)
                }
            }
        }
        return register.values.max()!!
    }

    fun puzzle2(input: String): Int {
        var maxValue = 0
        val lines = input.lines()
        for (line in lines) {
            val values = line.split(" ")
            val registerPosition = values[0]
            val action = values[1]
            val amount = values[2].toInt()
            val conditionRegister = values[4]
            val conditionComparator = values[5]
            val conditionAmount = values[6].toInt()
            if (checkCondition(conditionRegister, conditionComparator, conditionAmount)) {
                var newValue: Int
                if ("inc".equals(action)) {
                    newValue = getRegisterValue(registerPosition) + amount
                } else {
                    newValue = getRegisterValue(registerPosition) - amount
                }
                register.put(registerPosition, newValue)
                if (newValue > maxValue) {
                    maxValue = newValue
                }
            }
        }
        return maxValue
    }

    fun checkCondition(conditionRegister: String, comparator: String, amount: Int): Boolean {
        val value = getRegisterValue(conditionRegister)
        if (">".equals(comparator)) {
            return value > amount
        }
        if ("<".equals(comparator)) {
            return value < amount
        }
        if ("==".equals(comparator)) {
            return value == amount
        }
        if (">=".equals(comparator)) {
            return value >= amount
        }
        if ("<=".equals(comparator)) {
            return value <= amount
        }
        if ("!=".equals(comparator)) {
            return value != amount
        }
        return false
    }

    private fun getRegisterValue(conditionRegister: String): Int {
        var value = register.get(conditionRegister)
        if (value == null) {
            value = 0
            register.put(conditionRegister, value)
        }
        return value
    }
}
