%
% Day 12, Advent of code 2017 (Jonas Nockert / @lemonad)
%

content = fileread('day12.in');
[n_id0, n_groups] = solve(content);
fprintf('Number of programs in same group as id 0: %d\n', n_id0);
fprintf('Number of groups: %d\n', n_groups);
assert(n_id0 == 141 && n_groups == 171)


%
% Test sample given in problem description.
%
sample = ["0 <-> 2", ...
          "1 <-> 1", ...
          "2 <-> 0, 3, 4", ...
          "3 <-> 2, 4", ...
          "4 <-> 2, 3, 6", ...
          "5 <-> 6", ...
          "6 <-> 4, 5"];
[n_id0, n_groups] = solve(sample);
assert(n_id0 == 6 && n_groups == 2)


function [n_id0, n_groups] = solve(content)
%SOLVE Solves both part one and part two.
%   Creates a graph of all nodes and then uses the
%   connected components to figure out how many programs
%   are in the same group (component) as the program with
%   ID 0 as well as the total number of groups (components).
    lines = splitlines(strtrim(content));
    N = length(lines);
    G = graph(N, N);

    for i = 1:N
        line = char(lines(i));
        % We just want the numbers in a list.
        line = strrep(line, ' <-> ', ', ');
        pipes = textscan(line, '%d,');
        pipes = pipes{1} + 1;  % 1-based IDs.

        src_pipe = pipes(1);
        for dest_pipe = pipes(2:length(pipes))'
            if findedge(G, src_pipe, dest_pipe) == 0
                G = addedge(G, src_pipe, dest_pipe);
            end
        end
    end

    bins = conncomp(G);
	% Note that we have used 1-based node IDs above.
    n_id0 = sum(bins(:) == 1);
    n_groups = length(unique(bins));
end
