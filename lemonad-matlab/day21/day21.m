%
% Day 21, Advent of code 2017 (Jonas Nockert / @lemonad)
%

% Part one.

[rules2, rules3] = readRulesFromFile('day21.in');
n_iters = 5;
n_pixels_on = getPixelsOn(n_iters, rules2, rules3);
fprintf('Total pixels on after %d iterations: %d\n', n_iters, n_pixels_on);
assert(n_pixels_on == 162)

% Part two

n_iters = 18;
n_pixels_on = getPixelsOn(n_iters, rules2, rules3);
fprintf('Total pixels on after %d iterations: %d\n', n_iters, n_pixels_on);
assert(n_pixels_on == 2264586)


function [rules2, rules3] = readRulesFromFile(filename)
    rules2 = containers.Map;
    rules3 = containers.Map;

    content = fileread(filename);
    lines = splitlines(strtrim(content));
    N = length(lines);
    for i = 1:N
        line = char(lines(i));

        line = strrep(line, ' => ', '/');
        line = strrep(line, '.', '0');
        line = strrep(line, '#', '1');
        rule = split(line, '/');
        % becomes [{'000'}; {'000'}; {'000'}; {'0110'}; {'0110'}; ... }

        src_size = floor(length(rule) / 2);
        dest_size = src_size + 1;
        src = cell2mat(rule(1:src_size));
        dest = cell2mat(rule(dest_size:dest_size + src_size));

        % Add symmetries of the square (except diagonal flip)
        % for each map (we need two since the matrix sizes
        % are different).
        if src_size == 2
            addSquareSymmetries(rules2, src, dest);
        else
            addSquareSymmetries(rules3, src, dest);
        end
    end
end

function n_pixels_on = getPixelsOn(n_iters, rules2, rules3)
    img = ['010';'001';'111'];
    img_size = length(img);

    for iter = 1:n_iters
        if mod(img_size, 2) == 0
            % Image size is a multiple of two.
            out_size = (img_size / 2) * 3;
            out = char(ones(out_size) * '0');

            for y = 1:2:img_size
                for x = 1:2:img_size
                    M = img(y:y + 1, x:x + 1);
                    out_y = 1 + (y - 1) / 2 * 3;
                    out_x = 1 + (x - 1) / 2 * 3;
                    out(out_y:out_y + 2, out_x:out_x + 2) = rules2(M);
                end
            end
        else
            % Image size is a multiple of three.
            out_size = (img_size / 3) * 4;
            out = char(ones(out_size) * '0');

            for y = 1:3:img_size
                for x = 1:3:img_size
                    M = img(y:y + 2, x:x + 2);
                    out_y = 1 + (y - 1) / 3 * 4;
                    out_x = 1 + (x - 1) / 3 * 4;
                    out(out_y:out_y + 3, out_x:out_x + 3) = rules3(M);
                end
            end
        end
        img = out;
        img_size = out_size;
    end
    n_pixels_on = sum(sum(img - '0'));
end

function addSquareSymmetries(map, src, dest)
    map(src) = dest;
    map(rot90(src)) = dest;
    map(rot90(src, 2)) = dest;
    map(rot90(src, 3)) = dest;
    map(fliplr(src)) = dest;
    map(flipud(src)) = dest;
    map(src') = dest;
    % For some reason, the below is incorrectly (?) marked with red?
    map(rot90(src', 2)) = dest;
end
