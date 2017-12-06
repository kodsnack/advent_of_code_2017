%
% Day 6, Advent of code 2017 (Jonas Nockert / @lemonad)
%

data = [0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11];

%
% Part one.
%

[n_redists, ~] = solve(data);
fprintf("Number of redistributions: %d\n", n_redists);


%
% Part two.
%

[~, loop_size] = solve(data);
fprintf("Loop size: %d\n", loop_size);


%
% Tests
%

assert(n_redists == 7864);
assert(loop_size == 1695);

[n_redists, loop_size] = solve([0	2  7  0]);
assert(n_redists == 5);
assert(loop_size == 4);


%
% Helpers
%

function [n_redists, loop_size] = solve(X)
%SOLVE Finds redistribution and loop counts for memory config X.
    memo_data = containers.Map;
    memo_counter = containers.Map;
    N = length(X);
    
    function exists = memoize(Y, c)
        exists = false;
        s = char(sprintf("%d ", Y));
        if isKey(memo_data, s)
            exists = true;
            return
        end
        memo_data(s) = true;
        memo_counter(s) = c;
    end

    % Memoize initial configuration.
    memoize(X, 0);

    % Loop until we've seen a configuration before.
    counter = 0;
    while(true)
        [value_to_redistribute, index] = max(X);
        X(index) = 0;
        for i = 1:value_to_redistribute
            index = mod(index, N) + 1;
            X(index) = X(index) + 1;
        end
        counter = counter + 1;

        % Memoize new configuration (if it has not already been seen).
        if memoize(X, counter)
            % Configuration already seen!
            n_redists = counter;
            loop_size = counter - memo_counter(s);
            return
        end
    end
end
