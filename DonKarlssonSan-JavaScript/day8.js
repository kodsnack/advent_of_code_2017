module.exports = class Registers {
    constructor() {
        this.registers = new Map();
        this.max = Number.NEGATIVE_INFINITY;
    }

    processAndReturnHighestRegister (input) {
        let endOfLine = require('os').EOL;
        let rows = input.split(endOfLine);
        rows.forEach(row => {
            if(this.evaluate(row)) {
                this.executeInstruction(row);
            }
        });
        //console.log('Part 2: ' + this.max);
        return Math.max(...Array.from(this.registers.values()));
    }

    getValue(name) {
        if(this.registers.has(name)) {
            return this.registers.get(name);
        } else {
            this.registers.set(name, 0);
            return 0;
        }
    }

    evaluate(row) {
        let cols = row.split(' ');
        let register = cols[4];
        let registerValue = this.getValue(register);
        let ifIndex = row.indexOf('if ');
        let expr = row.substr(ifIndex + 3);
        expr = expr.replace(register, registerValue);
        return eval(expr);
    }

    executeInstruction(row) {
        let ifIndex = row.indexOf('if ');
        let instruction = row.substr(0, ifIndex);
        let instructionParts = instruction.split(' ');
        let register = instructionParts[0];
        let registerValue = this.getValue(register);
        let op = instructionParts[1];
        let value = parseInt(instructionParts[2]);
        if(op === 'inc') {
            registerValue += value;
        } else if (op === 'dec') {
            registerValue -= value;
        }
        if(registerValue > this.max) {
            this.max = registerValue;
        }
        this.registers.set(register, registerValue);
    }
}
