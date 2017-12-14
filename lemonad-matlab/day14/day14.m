%
% Day 14, Advent of code 2017 (Jonas Nockert / @lemonad)
%
% Note: Needs functions from day10 in path!
%

[n_squares_used, n_regions] = solve('wenycdww');
fprintf('Number of used squares: %d\n', n_squares_used);
fprintf('Number of regions: %d\n', n_regions);
assert(n_squares_used == 8226 && n_regions == 1128)


%
% Test sample given in problem description.
%

[n_squares_used, n_regions] = solve('flqrgnkx');
assert(n_squares_used == 8108 && n_regions == 1242)


function [n_used, n_regions] = solve(input_str)
%SOLVE Solves part one and part two.
    M = zeros(128);

    % Each row is the bits corresponding to a knot hash.
    for row = 1:128
        s = strcat(input_str, '-', num2str(row - 1));
        hash_str = hashString(s);

        for hash_index = 1:32
            col = (hash_index - 1) * 4 + 1;

            % E.g. 'd' => [1 1 1 0].
            nibble = hex2dec(hash_str(hash_index));
            M(row, col:col+3) = dec2bin(nibble, 4) == '1';
        end
    end

    n_used = sum(sum(M(:, :) == 1));

    % If we consider the matrix a binary image, we can get the
    % connected components.
    [~, n_regions] = bwlabel(M, 4);
end
