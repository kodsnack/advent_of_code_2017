%
% Day 2, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

% Note that the second row was padded with a non-min/
% non-max value to make each row the same length.
assert(checksum([5 1 9 5; 7 5 3 4; 2 4 6 8]) == 18)

spreadsheet = dlmread('day2.in');
assert(ndims(spreadsheet) == 2)
fprintf('The checksum is %d\n', checksum(spreadsheet));


%
% Part two.
%

assert(divisible([5 9 2 8; 9 4 7 3; 3 8 6 5]) == 9)

fprintf('The evenly divisible sum is %d\n', divisible(spreadsheet));


%
% Solutions
%

assert(checksum(spreadsheet) == 53460)
assert(divisible(spreadsheet) == 282)


function cksum = checksum(spreadsheet)
%CHECKSUM Calculate spreadsheet checksum.
    [M, N] = size(spreadsheet);

    s = 0;
    for m = 1:M
        s = s + max(spreadsheet(m, :)) - min(spreadsheet(m, :));
    end
    cksum = s;
end


function res = divisible(spreadsheet)
%DIVISIBLE Sum two entries per row where one evenly divides the other.
    [M, N] = size(spreadsheet);

    res = 0;
    for m = 1:M
        for n = 1:N
            % Remove column n from row.
            row_without_n = spreadsheet(m, [1:n-1, n+1:end]);
            rowmod = mod(spreadsheet(m, n), row_without_n);
            % If anything is zero when we do modulo over the
            % whole row (without column n), then we've found
            % the pair where one evenly divides the other.
            zeroindexes = find(~rowmod);
            if zeroindexes
                res = res + spreadsheet(m, n) / ...
                    row_without_n(zeroindexes(1));
                break
            end
        end
    end
end