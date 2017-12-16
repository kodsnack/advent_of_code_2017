%
% Day 15, Advent of code 2017 (Jonas Nockert / @lemonad)
%
% Alternate version that is more elegant but far slower.
%

tic;

%
% Part one using numbers from example.
%

N = 5;
gen1 = @(n) next_gen(n, uint32(16807));
gen2 = @(n) next_gen(n, uint32(48271));
counter = compare(gen1, uint32(65), gen2, uint32(8921), N);
fprintf('judge''s final count: %d\n', counter);
assert(counter == 1)


%
% Part two using numbers from example.
%

gen1 = @(n) next_gen(n, uint32(16807), uint32(3));
gen2 = @(n) next_gen(n, uint32(48271), uint32(7));
N = 1060;
counter = compare(gen1, uint32(65), gen2, uint32(8921), N);
fprintf('judge''s final count: %d\n', counter);
assert(counter == 1)

toc;


function n = next_gen(n, mult, modcomp)
    p = uint64(2147483647);
    if nargin < 3
        modcomp = uint32(0);
    end
    while true
        n = uint32(mod(uint64(n) * uint64(mult), p));

        % Modulus with Mersenne Prime (e.g. 2147483647)
        % https://ariya.io/2007/02/modulus-with-mersenne-prime
        % Cuts about 50% execution time, running with pypy.
        %
        % Slower than modulus!
        % n = n * mult;
        % n = bitand(n, p) + bitshift(n, -31);
        % if n >= p
        %     n = n - p;
        % end

        if ~bitand(n, modcomp)
            return
        end
    end
end

function counter = compare(gen1, n1, gen2, n2, N)
    mask = uint32(65535);
    counter = 0;
    for i = 1:N
        n1 = gen1(n1);
        n2 = gen2(n2);

        if bitand(n1, mask) == bitand(n2, mask)
            counter = counter + 1;
        end
    end
end
