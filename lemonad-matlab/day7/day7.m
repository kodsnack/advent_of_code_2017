%
% Day 7, Advent of code 2017 (Jonas Nockert / @lemonad)
%

[root_program, new_height] = solve('day7.in');
fprintf("Root program: '%s'.\n", root_program);
fprintf("Balanced height: %d.\n", new_height);


%
% Tests
%

assert(strcmp(root_program, 'hlqnsbe'))
assert(new_height == 1993)

[root_program, new_height] = solve('day7-sample.in');
assert(strcmp(root_program, 'tknk'))
assert(new_height == 60)


%
% Helpers
%

function [root_name, balanced_height] = solve(filename)
%SOLVE Solve parts one and two.
    [prog_ids, prog_names, prog_heights] = get_nodes(filename);
    G = get_graph(filename, prog_ids, prog_names);
    root_id = get_root_id(G);
    root_name = prog_names{root_id};
    prog_heights_acc = collect_heights(G, root_id, prog_heights);
    balanced_height = balance(G, root_id, prog_heights, prog_heights_acc);
end

function balanced_height = balance(G, root_id, heights, heights_acc)
%BALANCE Returns the weight needed to balance the tree.
    balanced_height = 0;
    S = successors(G, root_id);
    if isempty(S)
        return
    end
    node_heights = [];

    for s = S
        node_heights = [node_heights; heights_acc(s)];
    end
    [maxh, index] = max(node_heights);
    minh = min(node_heights);
    unbalanced_node_id = S(index);
    if maxh == minh
        return
    end
    
    balanced_height = heights(unbalanced_node_id) - (maxh - minh);
    % Maybe the balance should be corrected further down the tree?
    next_balanced_height = balance(G, unbalanced_node_id, heights, ...
                                   heights_acc);
    if next_balanced_height ~= 0
        balanced_height = next_balanced_height;
    end
end

function [ids, names, heights] = get_nodes(filename)
    ids = containers.Map('KeyType', 'char', 'ValueType', 'uint32');
    heights = [];
    names = [];
    number_of_programs = uint32(0);
    fp = fopen(filename);
    line = fgetl(fp);
    while ischar(line)
        many_words = textscan(line, '%s');
        name = char(many_words{1}{1});
        height = str2double(erase(many_words{1}{2}, ["(",")"]));

        id = number_of_programs + 1;
        ids(name) = id;
        names = [names; string(name)];
        heights = [heights; height];
        number_of_programs = number_of_programs + 1;

        line = fgetl(fp);
    end
    names = cellstr(names);
    fclose(fp);
end

function G = get_graph(filename, ids, names)
%GET_GRAPH Creates a graph out of input data.
    N = length(ids);
    nodes = zeros(N, N);
    G = digraph(nodes, cellstr(names));

    fp = fopen(filename);
    line = fgetl(fp);
    while ischar(line)
        many_words = textscan(line, '%s');
        words = many_words{1};
        N = length(words);
        name = char(words{1});
        height = str2double(erase(words{2}, ["(",")"]));

        if (N > 2)
            if words{3} == '->'
                for i = 4:N
                    word = erase(char(words{i}), ',');
                    G = addedge(G, ids(name), ids(word), height);
                end
            end
        end

        line = fgetl(fp);
    end    
    fclose(fp);
end

function root_id = get_root_id(G)
%GET_ROOT_ID Finds the node id which represents the root in the tree.
    node = 1;
    pred = node;
    while ~isempty(pred)
        node = pred;
        pred = predecessors(G, node);
    end
    root_id = node;
end

function heights = collect_heights(G, root_id, heights)
%COLLECT_HEIGHTS Propagate heights toward root of tree.
    % When finished, root height will be the sum of all subtree heights.
    order = flipud(dfsearch(G, root_id));
    
    for o = 1:length(order)
        prog_id = order(o);
        parent_id = predecessors(G, prog_id);
        if ~isempty(parent_id)
            heights(parent_id) = heights(parent_id) + heights(prog_id);
        end
    end
end
