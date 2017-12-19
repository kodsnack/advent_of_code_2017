%
% Day 19, Advent of code 2017 (Jonas Nockert / @lemonad)
%

fp = fopen('day19.in');
%fp = fopen('sample.in');
T = fscanf(fp, '%c');
fclose(fp);
lines = char(splitlines(T));
start_x = strfind(lines(1, :), '|');

pos_x = start_x;
pos_y = 2;
dir = pi / 2;
last_node = '|';
word = '';
steps = 1;

while true
    node = lines(pos_y, pos_x);

    if (last_node == '|' && node == '|') || ...
           (last_node == '|' && node == '-') || ...
           (last_node == '-' && node == '-') || ...
           (last_node == '-' && node == '|')
       % Continue in the direction we're heading.
    elseif last_node == '|' && isletter(node)
        % Pretend the letter is a vertical line and
        % continue in the direction we're heading.
        word = [word node];
        node = '|';
    elseif last_node == '-' && isletter(node)
        % Pretend the letter is a horizontal line and
        % continue in the direction we're heading.
        word = [word node];
        node = '-';
    elseif (last_node == '|' && node == '+')
        % Vertical to horizontal turn.
        new_dir = dir - pi / 2;
        next_node = lines(pos_y + round(sin(new_dir)), ...
                          pos_x + round(cos(new_dir)));
        if next_node == '-' || isletter(next_node)
            node = '-';
            dir = new_dir;
        else
            node = '-';
            dir = dir + pi / 2;
        end
    elseif (last_node == '-' && node == '+')
        % Horizontal to vertical turn.
        new_dir = dir - pi / 2;
        next_node = lines(pos_y + round(sin(new_dir)), ...
                          pos_x + round(cos(new_dir)));
        if next_node == '|' || isletter(next_node)
            node = '|';
            dir = new_dir;
        else
            node = '|';
            dir = dir + pi / 2;
        end
    elseif node == ' '
        % We've reached the end of the line.
        break
    else
        fprintf('Incorrect char: "%c" (%c)\n', node, last_node);
        break
    end

    pos_y = pos_y + round(sin(dir));
    pos_x = pos_x + round(cos(dir));
    last_node = node;
    steps = steps + 1;
end

fprintf('Found word: %s\n', word);
assert(isequal(word, 'LXWCKGRAOY'));
fprintf('Number of steps: %d\n', steps);
assert(steps == 17302);
