%
% Day 9, Advent of code 2017 (Jonas Nockert / @lemonad)
%

runtests('day9Test.m');

[s, g] = solve();
fprintf("Total score for all groups in input: %d\n", s);
fprintf("Number of non-canceled characters within garbage in input?: %d\n", g);
assert(s == 9251)
assert(g == 4322)


%
% Helpers
%

function [score, garbage_count] = solve()
    score = 0;
    garbage_count = 0;
    fp = fopen('day9.in');
    line = fgetl(fp);
    while ischar(line)
        [subscore, count] = parseSequence(line);
        score = score + subscore;
        garbage_count = garbage_count + count;
        line = fgetl(fp);
    end
end
