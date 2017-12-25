%
% Day 23, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

program0 = program(0, 'day23.in', 8);
program0.run();
mul_counter = program0.getCounter();
fprintf('Number of multiplications: %d.\n', mul_counter);
assert(mul_counter == 3969)

%
% Part two.
%
% An analysis of the program reveals it has pseudocode
%
%     h = 0
%     for b = 106500:17:123500
%       flag = true
%       for d = 2 : b
%         for e = 2 : b
%           if d * e - b == 0
%             flag = false
%           end
%         end
%       end
%       if flag
%         h = h + 1
%       end
%     end
%
% which means that, for each b, if there are no numbers n1 >= 2,
% n2 >= 2 where n1 * n2 == b, we increase h.
%
% In short, we increase h if b is not a prime number.

h_counter = 0;
for b = 106500:17:123500
    if ~isprime(b)
        h_counter = h_counter + 1;
    end
end
fprintf('Value left in register h: %d.\n', h_counter);
assert(h_counter == 917)
