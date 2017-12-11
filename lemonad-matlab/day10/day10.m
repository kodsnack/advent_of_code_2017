%
% Day 10, Advent of code 2017 (Jonas Nockert / @lemonad)
%

runtests('day10Test.m');

indata_str = '230,1,2,221,97,252,168,169,57,99,0,254,181,255,235,167';

% Part one.
res = solve_part_one(indata_str, 0:255);
fprintf("Check value: %d\n", res);
assert(res == 2928)

% Part two.
hash_str = solve_part_two(indata_str);
fprintf("Hash: %s\n", hash_str);
assert(strcmp(hash_str, '0c2f794b2eb555f7830766bf8fb65a16'))


%
% Helpers
%

function res = solve_part_one(indata_str, L)
    indata = str2num(indata_str);
    sparse_hash = knotHash(indata, L);
    res = sparse_hash(1) * sparse_hash(2);
end

function hash_str = solve_part_two(indata)
    hash_str = hashString(indata);
end
