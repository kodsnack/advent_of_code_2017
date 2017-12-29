%
% Day 24, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

filename = 'day24.in';
% filename = 'sample.in';
[used, components] = parseInput(filename);
tic;
[s, l_s, ~] = formBridge(components, 0);
toc;
fprintf('Strength of the strongest bridge: %d\n', s);
fprintf('Strength of the longest bridge: %d\n', l_s);
assert(s == 1940)
assert(l_s == 1928)


function [used, components] = parseInput(filename)
    content = fileread(filename);
    lines = splitlines(strtrim(content));
    N = length(lines);

    used = containers.Map;
    components = containers.Map('KeyType', 'int32', 'ValueType', 'any');

    for i = 1:N
        line = char(lines(i));
        componentsline = textscan(line, '%d/%d');
        port1 = componentsline{1};
        port2 = componentsline{2};
        if isKey(components, port1)
            components(port1) = [components(port1); port2];
        else
            components(port1) = port2;
        end
        if isKey(components, port2)
            components(port2) = [components(port2); port1];
        else
            components(port2) = port1;
        end
    end
end

function [max_strength, max_longest_strength, max_length] = ...
                        formBridge(components, port1)
    max_strength = 0;
    max_length = 0;
    max_longest_strength = 0;

    plist = components(port1);

    for j = 1:length(plist)
        port2 = plist(j);
        
        % Remove component we're about to use.
        plist_copy = plist;
        plist_copy(plist_copy==port2) = [];
        components(port1) = plist_copy;
        if port1 ~= port2
            plist2 = components(port2);
            plist2(plist2==port1) = [];
            components(port2) = plist2;
        end

        [s, l_s, l] = formBridge(components, port2);
        
        % add component back.
        components(port1) = plist_copy;
        if port1 ~= port2
            components(port2) = [plist2; port1];
        end

        max_strength = max(s + port1 + port2, max_strength);
        if l + 1 >= max_length
            max_length = l + 1;
            max_longest_strength = l_s + port1 + port2;
        end
    end
end
