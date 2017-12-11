%
% Day 11, Advent of code 2017 (Jonas Nockert / @lemonad)
%

assert(hexdist('ne,ne,ne') == 3)
assert(hexdist('ne,ne,sw,sw') == 0)
assert(hexdist('ne,ne,s,s') == 2)
assert(hexdist('se,sw,se,sw,sw') == 3)

%
% Part one and two
%

fp = fopen('day11.in');
data = fread(fp);
fclose(fp);

cdata = strtrim(char(data'));
[dist, maxdist] = hexdist(cdata);
fprintf('Total distance: %d (max distance: %d)\n', dist, maxdist);
assert(dist == 720 && maxdist == 1485);


function [dist, maxdist] = hexdist(directions)
%HEXDIST Given a number of moves, returns final distance and max distance.
    % Example: hexdist('ne,ne,n')
    %
    % Note that we're using cube coordinates here with
    % flat-topped hexagons (i.e. there are no moves to
    % the east or west).

    % Deltas for N, NE, SE moves (S = -N, SW = -NE, NW = -SE).
    delta = [[0 1 -1]; [1 0 -1]; [1 -1 0]];
    directions = strsplit(directions, ',');
    pos = [0 0 0];
    maxdist = 0;

    for d = directions
        d = d{1};
        switch(d)
            case 'n'
                pos = pos + delta(1, :);
            case 's'
                pos = pos - delta(1, :);
            case 'ne'
                pos = pos + delta(2, :);
            case 'nw'
                pos = pos - delta(3, :);
            case 'se'
                pos = pos + delta(3, :);
            case 'sw'
                pos = pos - delta(2, :);
            otherwise
                error('What direction is this: "%s"?', d);
        end
        maxdist = max([maxdist, max(abs(pos))]);
    end
    dist = max(abs(pos));
end
