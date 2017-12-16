%
% Day 15, Advent of code 2017 (Jonas Nockert / @lemonad)
%
% Note! Takes about 740s to run to completion!
%

tic;

% Example initial values.
% start1 = 65;
% start2 = 8921;

start1 = 516;
start2 = 190;
p = uint64(2147483647);

%
% Part one.
%

N = 40000000;
Gen1 = zeros(N, 1, 'uint32');
Gen2 = zeros(N, 1, 'uint32');
n1 = uint32(start1);
n2 = uint32(start2);
i = 1;
while i <= N
    n1 = uint32(mod(uint64(n1) * 16807, p));
    n2 = uint32(mod(uint64(n2) * 48271, p));
    Gen1(i) = n1;
    Gen2(i) = n2;
    i = i + 1;
end

judges_count = sum(bitand(Gen1, 65535) == bitand(Gen2, 65535));
fprintf('judge''s final count: %d\n', judges_count);


%
% Part two.
%

N = 5000000;
Gen1 = zeros(N, 1, 'uint32');
Gen2 = zeros(N, 1, 'uint32');
n1 = uint32(start1);
n2 = uint32(start2);

% Generator 1 (only pick numbers divisible by 4).
i = 1;
while i <= N
    n1 = uint32(mod(uint64(n1) * 16807, p));
    if ~bitand(n1, 3)
        Gen1(i) = n1;
        i = i + 1;
    end
end

% Generator 2 (only pick numbers divisible by 8).
i = 1;
while i <= N
    n2 = uint32(mod(uint64(n2) * 48271, p));
    if ~bitand(n2, 7)
        Gen2(i) = n2;
        i = i + 1;
    end
end
judges_count = sum(bitand(Gen1, 65535) == bitand(Gen2, 65535));
fprintf('judge''s final count: %d\n', judges_count);

toc;
