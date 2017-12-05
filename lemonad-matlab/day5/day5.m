%
% Day 5, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

steps_one = solve_part_one();
fprintf('Number of steps: %d\n', steps_one);


%
% Part two (takes a while!).
%


steps_two = solve_part_two();
fprintf('Number of steps: %d\n', steps_two);


%
% Tests
%

assert(plus_one(2) == 3)    
assert(jump_n_step([0; 3; 0; 1; -3], @plus_one) == 5)
assert(steps_one == 387096)

assert(plus_one_or_minus_one(2) == 3)
assert(plus_one_or_minus_one(3) == 2)
assert(plus_one_or_minus_one(4) == 3)
assert(plus_one_or_minus_one(5) == 4)
assert(jump_n_step([0; 3; 0; 1; -3], @plus_one_or_minus_one) == 10)
assert(steps_two == 28040648)


%
% Helpers
%

function result = solve_part_one()
%SOLVE_PART_ONE Adding one to jump table at current ip.
    jump_table = dlmread('day5.in');
    result = jump_n_step(jump_table, @plus_one);
end

function result = solve_part_two()
%SOLVE_PART_TWO Adding or subtracting one to jump table at current ip.
    jump_table = dlmread('day5.in');
    result = jump_n_step(jump_table, @plus_one_or_minus_one);
end

function steps = jump_n_step(jumps, mod_func)
%JUMP_N_STEP Run program with a given table modification function.
    ip = 0;
    steps = 0;
    while ip >= 0 && ip < length(jumps)
        next_ip = ip + jumps(ip + 1);
        jumps(ip + 1) = mod_func(jumps(ip + 1));
        ip = next_ip;
        steps = steps + 1;
    end
end

function new_offset = plus_one(offset)
%PLUS_ONE Adds one to the offset.
    new_offset = offset + 1;
end

function new_offset = plus_one_or_minus_one(offset)
    if abs(offset) >= 3
        new_offset = offset - sign(offset);
    else
        new_offset = offset + 1;
    end
end
