%
% Day 24, Advent of code 2017 (Jonas Nockert / @lemonad)
%
% Alternative solution using a graph (takes 20 minutes to
% complete).
%

content = fileread('day24.in');
lines = splitlines(strtrim(content));
N = length(lines);

% Create graph
G = graph(N, N, 0);
for i = 1:N
    line = char(lines(i));
    portsline = textscan(line, '%d/%d');
    port1 = portsline{1} + 1;
    port2 = portsline{2} + 1;
    % We get weights from port numbers instead of edges.
    G = addedge(G, port1, port2, 1);
end

used = containers.Map('KeyType', 'int32', 'ValueType', 'logical');
tic;
[s, l_s, ~] = formBridge(G, 1, used);
toc;
fprintf('Strength of the strongest bridge: %d\n', s);
fprintf('Strength of the longest bridge: %d\n', l_s);
assert(s == 1940)
assert(l_s == 1928)


function [max_strength, max_longest_strength, max_length] = formBridge(G, port1, used)
    max_strength = 0;
    max_length = 0;
    max_longest_strength = 0;
    
    plist = neighbors(G, port1);

    for j = 1:length(plist)
        port2 = plist(j);
        e = findedge(G, port1, port2);
        if isKey(used, e) && ~used(e)
            continue;
        end
        
        used(e) = false;
        
        [s, l_s, l] = formBridge(G, port2, used);

        used(e) = true;

        max_strength = max(s + port1 + port2 - 2, max_strength);
        if l + 1 >= max_length
            max_length = l + 1;
            max_longest_strength = l_s + port1 + port2 - 2;
        end
    end
end
