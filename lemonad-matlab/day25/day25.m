%
% Day 25, Advent of code 2017 (Jonas Nockert / @lemonad)
%

tape = containers.Map('KeyType', 'int32', 'ValueType', 'logical');
diag_steps = 12919244;
cursor = 0;
state = 'A';

for i = 1:diag_steps
    if mod(i, 100000) == 0
        disp(i)
    end
        
    if isKey(tape, cursor)
        val = tape(cursor);
    else
        val = 0;
    end

    switch state
        case 'A'
            if ~val
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'B';
            else
                tape(cursor) = 0;
                cursor = cursor - 1;
                state = 'C';
            end
        case 'B'
            if ~val
                tape(cursor) = 1;
                cursor = cursor - 1;
                state = 'A';
            else
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'D';
            end
        case 'C'
            if ~val
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'A';
            else
                tape(cursor) = 0;
                cursor = cursor - 1;
                state = 'E';
            end
       case 'D'
            if ~val
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'A';
            else
                tape(cursor) = 0;
                cursor = cursor + 1;
                state = 'B';
            end
       case 'E'
            if ~val
                tape(cursor) = 1;
                cursor = cursor - 1;
                state = 'F';
            else
                tape(cursor) = 1;
                cursor = cursor - 1;
                state = 'C';
            end
       case 'F'
            if ~val
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'D';
            else
                tape(cursor) = 1;
                cursor = cursor + 1;
                state = 'A';
            end
        otherwise
            error('invalid state');
    end
end

cksum = sum(cell2mat(values(tape)));
fprintf('The diagnostic checksum is %d', cksum);
assert(cksum == 4287)
