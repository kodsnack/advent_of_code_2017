%
% Day 8, Advent of code 2017 (Jonas Nockert / @lemonad)
%

fp = fopen('day8.in');
day8data = fread(fp);
fclose(fp);
[largest, highest] = solve(day8data);
fprintf("Largest value in any register after completing the instructions: %d.\n", largest);
fprintf("Highest value held in any register during this process: %d.\n", highest);

%
% Tests
%

assert(largest == 4902)
assert(highest == 7037)

sample_data = ["b inc 5 if a > 1", ...
               "a inc 1 if b < 5", ... 
               "c dec -10 if a >= 1", ...
               "c inc -20 if c == 10"];
[h, ih] = solve(sample_data);
assert(h == 1)
assert(ih == 10)
           

%
% Helpers
%

function [largest, intermediate_largest] = solve(data)
%SOLVE Solves puzzle for December 8.
    regs = containers.Map('KeyType', 'char', 'ValueType', 'int64');

    cdata = char(data);
    instr = textscan(cdata, '%s %s %d if %s %s %d');
    N = length(instr{1});

    % Create all registers before running instructions.
    for i = 1:N
        regs(char(instr{1}(i))) = 0;
    end

    % Execute all instructions.
    intermediate_largest = 0;
    for i = 1:N
        reg = char(instr{1}(i));
        incdec = instr{2}(i);
        amount = int64(instr{3}(i));
        cond_reg = char(instr{4}(i));
        cond_op = char(instr{5}(i));
        cond_val = int64(instr{6}(i));

        % Change amount to 'inc'.
        if strcmp(incdec, 'dec')
            amount = -amount;
        end

        switch cond_op
            case '=='
                op = @eq;
            case '!='
                op = @ne;
            case '<'
                op = @lt;
            case '<='
                op = @le;
            case '>'
                op = @gt;
            case '>='
                op = @ge;
        end

        if op(regs(cond_reg), cond_val)
            regs(reg) = regs(reg) + amount;
        end

        if regs(reg) > intermediate_largest
            intermediate_largest = regs(reg);
        end
    end

    largest = max(cell2mat(values(regs)));
end
