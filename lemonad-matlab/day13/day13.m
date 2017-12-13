%
% Day 13, Advent of code 2017 (Jonas Nockert / @lemonad)
%

content = fileread('day13.in');
[severity, delay] = solve(content);
fprintf("Severity: %d\n", severity);
fprintf("Delay: %d\n", delay);
assert(severity == 648 && delay == 3933124)


%
% Test sample given in problem description.
%

content = ["0: 3", "1: 2", "4: 4", "6: 4"];
[severity, delay] = solve(char(join(content)));
assert(severity == 24 && delay == 10)


function [severity, delay] = solve(content)
%SOLVE Solves both part one and part two.
    layers = cell2mat(textscan(content, '%d: %d'));

    % Part one.
    severity = getSeverity(layers);
    
    % Part two.
    delay = 0;
    while 1
        [~, is_caught] = getSeverity(layers, delay, true);
        if ~is_caught
            break
        end
        delay = delay + 1;
    end
end

function [severity, is_caught] = getSeverity(layers, delay, exit_when_caught)
%GETSEVERITY Gets severity given a list of firewall layers.
    if nargin < 3
        exit_when_caught = false;
    end
    if nargin < 2
        delay = 0;
    end

    N = length(layers);
    is_caught = false;

    severity = 0;
    for i = 1:N
        depth = layers(i, 1);
        range = layers(i, 2);

        % One loop is, e.g., 0 1 2 3 4 3 2 1 so all elements in
        % in range are visited twice except the end elements
        % (0 and 4 here), thus -2 below.
        if (mod(depth + delay, 2 * range - 2)) == 0
            is_caught = true;
            if exit_when_caught
                return
            end
            severity = severity + depth * range;
        end
    end
end
