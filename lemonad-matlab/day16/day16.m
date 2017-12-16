%
% Day 16, Advent of code 2017 (Jonas Nockert / @lemonad)
%

N = 1000000000;
programs = 'a':'p';

content = fileread('day16.in');
% content = fileread('sample.in');
cdata = strtrim(content);
moves = strsplit(cdata, ',');


%
% Part one.
%

res = makeMoves(programs, moves);
fprintf('Post dance: %s\n', res);
assert(isequal(res, 'cgpfhdnambekjiol'))


%
% Part two.
%

% Finds the cycle time and use that to make a minimum amount of moves.
n = findCycle(programs, moves);
for i=floor(N / n) * n + 1:N
    programs = makeMoves(programs, moves);
end
fprintf('Post loooong dance: %s\n', programs);
assert(isequal(programs, 'gjmiofcnaehpdlbk'))


function n = findCycle(programs, moves)
%FINDCYCLE Returns the cycle time of move permutations.
    orig = programs;
    n = 1;
    while true
        programs = makeMoves(programs, moves);
        if isequal(orig, programs)
            return
        end
        n = n + 1;
    end
end

function programs = makeMoves(programs, moves)
%MAKEMOVES Makes a number of permutations.
    for move = moves
        programs = makeMove(programs, move);
    end
end

function out = makeMove(programs, move)
%MAKEMOVE Make one permutation.
    move = cell2mat(move);

    if move(1) == 'x'
        m = textscan(move(2:end), '%d/%d');
        pos1 = m{1} + 1;
        pos2 = m{2} + 1;
        out = programs;
        out(pos1) = programs(pos2);
        out(pos2) = programs(pos1);
    elseif move(1) == 's'
        m = textscan(move(2:end), '%d');
        spin = m{1};
        out = [programs(end - spin + 1:end), programs(1:end - spin)];
    elseif move(1) == 'p'
        m = textscan(move(2:end), '%c/%c');
        prg1 = m{1};
        prg2 = m{2};
        pos1 = strfind(programs, prg1);
        pos2 = strfind(programs, prg2);
        out = programs;
        out(pos1) = programs(pos2);
        out(pos2) = programs(pos1);
     else
        error('Wrong move!');
    end
end
