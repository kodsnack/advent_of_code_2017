%
% Day 1, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

assert(get_sum('1122', @next_index) == 3)
assert(get_sum('1111', @next_index) == 4)
assert(get_sum('1234', @next_index) == 0)
assert(get_sum('91212129', @next_index) == 9)

part1_sum = get_sum(fileread('Day1.in'), @next_index);
fprintf('Part1 sum: %d\n', part1_sum);
assert(get_sum(fileread('Day1.in'), @next_index) == 1044)


%
% Part two.
%

assert(get_sum('1212', @halfway_index) == 6)
assert(get_sum('1221', @halfway_index) == 0)
assert(get_sum('123425', @halfway_index) == 4)
assert(get_sum('123123', @halfway_index) == 12)
assert(get_sum('12131415', @halfway_index) == 4)

part2_sum = get_sum(fileread('Day1.in'), @halfway_index);
fprintf('Part2 sum: %d\n', part2_sum);
assert(get_sum(fileread('Day1.in'), @halfway_index) == 1054)


%
% Helper functions.
%

function s = get_sum(str, get_next_f)
%GET_SUM Sums current digit with next digit if equal
%   Provided a string of digits and a function for retrieving
%   a second index based on the current index, sums all digits
%   where digits for both indexes are equal.
    digits = parse(str);
    N = length(digits);
    total_sum = 0;
    for n = 1:N
        compare_index = get_next_f(n, N);
        if digits(n) == digits(compare_index)
            total_sum = total_sum + digits(n);
        end
    end
    s = total_sum;
end

function nix = next_index(n, N)
% NEXT_INDEX Gets next index (+1) based on the current
    nix = mod(n, N) + 1;
end

function nix = halfway_index(n, N)
% HALFWAY_INDEX Gets next index (+N/2) based on the current
    nix = mod(n - 1 + N/2, N) + 1;
end

function digits = parse(str)
% PARSE Parses a string of digits into a vector
    C = textscan(str, '%1d');
    digits = cell2mat(C);
end
