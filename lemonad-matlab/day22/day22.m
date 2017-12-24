%
% Day 22, Advent of code 2017 (Jonas Nockert / @lemonad)
%

content = fileread('day22.in');
lines = splitlines(strtrim(content));
start_grid = char(lines);

[n_infections, ~] = getInfections(start_grid, 10000, @updatePartOne);
fprintf('Number of burst that caused infection: %d\n', n_infections);
assert(n_infections == 5565)

[n_infections, ~] = getInfections(start_grid, 10000000, @updatePartTwo);
fprintf('Number of burst that caused infection: %d\n', n_infections);
assert(n_infections == 2511978)


%
% Tests
%

content = fileread('sample.in');
lines = splitlines(strtrim(content));
start_grid = char(lines);

[~, grid] = getInfections(start_grid, 70, @updatePartOne);
grid_ref = ['..........'; ...
            '....##....'; ...
            '...#..#...'; ...
            '..#....#..'; ...
            '.#.#...#..'; ...
            '.#.#..#...'; ...
            '....##....'; ...
            '..........'; ...
            '..........'];
assert(isequal(grid, grid_ref))

[infections, ~] = getInfections(start_grid, 70, @updatePartOne);
assert(infections == 41)


[~, grid] = getInfections(start_grid, 7, @updatePartTwo); % 00000
grid_ref = ['......'; ...
            '.WW.#.'; ...
            '.#.W..'; ...
            '......'; ...
            '......'];
assert(isequal(grid, grid_ref))

[infections, ~] = getInfections(start_grid, 100, @updatePartTwo);
assert(infections == 26)


function [node, direction_delta, infected_delta] = updatePartOne(node)
    infected_delta = 0;
    if node == '.'
        % Clean (so infect and move left)
        node = '#';
        direction_delta = -1i;
        infected_delta = 1;
    else
        % Infected (so clean and move right)
        node = '.';
        direction_delta = 1i;
    end
end


function [node, direction_delta, infected_delta] = updatePartTwo(node)
    infected_delta = 0;
    if node == '.'
        % Clean (so weaken and move left)
        node = 'W';
        direction_delta = -1i;
    elseif node == 'W'
        % Weakened (so infect)
        node = '#';
        infected_delta = 1;
        direction_delta = 1;
    elseif node == '#'
        % Infected
        node = 'F';
        direction_delta = 1i;
    else
        % Flagged (so clean)
        node = '.';
        direction_delta = -1;
    end
end


function [infections, grid] = getInfections(grid, n_iters, updateFunc)
    [m, n] = size(grid);
    current_pos = floor(m / 2) + 1 + (floor(n / 2) + 1) * 1i;
    direction = -1i;
    infections = 0;

    for i = 1:n_iters
        if imag(current_pos) <= 1
            grid = [ones(1, n) * '.'; grid];
            m = m + 1;
            current_pos = current_pos + 1i;
        elseif imag(current_pos) >= m - 1
            grid = [grid; ones(1, n) * '.'];
            m = m + 1;
        end

        if real(current_pos) <= 1
            grid = [ones(m, 1) * '.', grid];
            n = n + 1;
            current_pos = current_pos + 1;
        elseif real(current_pos) >= n - 1
            grid = [grid, ones(m, 1) * '.'];
            n = n + 1;
        end

        x = real(current_pos);
        y = imag(current_pos);
        node = grid(y, x);
        [node, direction_delta, infected_delta] = updateFunc(grid(y, x));
        grid(y, x) = node;
        direction = direction * direction_delta;
        infections = infections + infected_delta;

        % Move forward.
        current_pos = current_pos + direction;
    end
end
