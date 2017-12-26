%
% Day 24, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

filename = 'day24.in';
% filename = 'sample.in';
[used, ports] = parseInput(filename);
[s, l_s, ~] = formBridge(ports, used, 0);
fprintf('Strength of the strongest bridge: %d\n', s);
fprintf('Strength of the longest bridge: %d\n', l_s);
assert(s == 1940)
assert(l_s == 1928)


function [used, ports] = parseInput(filename)
    content = fileread(filename);
    lines = splitlines(strtrim(content));
    N = length(lines);

    used = containers.Map;
    ports = containers.Map('KeyType', 'int32', 'ValueType', 'any');

    for i = 1:N
        line = char(lines(i));
        portsline = textscan(line, '%d/%d');
        port1 = portsline{1};
        port2 = portsline{2};
        if isKey(ports, port1)
            ports(port1) = [ports(port1); port2];
        else
            ports(port1) = port2;
        end
        if isKey(ports, port2)
            ports(port2) = [ports(port2); port1];
        else
            ports(port2) = port1;
        end
    end
end

function [max_strength, max_longest_strength, max_length] = ...
                        formBridge(ports, used, adapter)
    plist = ports(adapter);
    max_strength = 0;
    max_length = 0;
    max_longest_strength = 0;

    for j = 1:length(plist)
        used_str = char(sprintf('%d %d', ...
            min(adapter, plist(j)), max(adapter, plist(j))));
        if isKey(used, used_str)
            continue
        end

        used(used_str) = true;
        [s, l_s, l] = formBridge(ports, used, plist(j));
        remove(used, used_str);
        s = s + adapter + plist(j);
        l_s = l_s + adapter + plist(j);
        l = l + 1;

        if s > max_strength
            max_strength = s;
        end

        if l >= max_length
            max_length = l;
            max_longest_strength = l_s;
        end
    end
end
