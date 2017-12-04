%
% Day 3, Advent of code 2017 (Jonas Nockert / @lemonad)
%

assert(fractal_min_dist(1) == 0)
assert(fractal_min_dist(2) == 1)
assert(fractal_min_dist(9) == 1)
assert(fractal_min_dist(10) == 2)
assert(fractal_min_dist(25) == 2)
assert(fractal_min_dist(26) == 3)
assert(fractal_min_dist(49) == 3)
assert(fractal_min_dist(50) == 4)

assert(taxicab_dist([0 2]) == 2)
assert(taxicab_dist([3 0]) == 3)
assert(taxicab_dist([-3 2]) == 5)

%
% Part one.
%

assert(solve_part_one(1) == 0)
assert(solve_part_one(12) == 3)
assert(solve_part_one(23) == 2)
assert(solve_part_one(1024) == 31)
assert(solve_part_one_alt(1) == 0)
assert(solve_part_one_alt(12) == 3)
assert(solve_part_one_alt(23) == 2)
assert(solve_part_one_alt(1024) == 31)

fprintf('The taxicab distance is %d\n', solve_part_one(277678));


%
% Part two.
%

assert(solve_part_two(1) == 2)
assert(solve_part_two(2) == 4)
assert(solve_part_two(3) == 4)
assert(solve_part_two(4) == 5)
assert(solve_part_two(5) == 10)
assert(solve_part_two(10) == 11)
assert(solve_part_two(147) == 304)

fprintf('Next written number is %d\n', solve_part_two(277678));


%
% Solutions
%

assert(taxicab_dist(get_offset(277678)) == 475)
assert(solve_part_one(277678) == 475)
assert(solve_part_one_alt(277678) == 475)
assert(solve_part_two(277678) == 279138)


%
% Helpers
%

function result = solve_part_one_alt(n)
%SOLVE_PART_ONE Alternative solution to part one.
    % Note that this is `O(ceil(sqrt(n) + 1)^2)` whereas
    % the original solution is `O(1)`.
    N = 2 * ceil(sqrt(n) / 2) + 1;
    center = ceil(N / 2);
    spiral_matrix = flip(spiral(N));
    [I, J] = find(spiral_matrix == n);
    result = abs(I - center) + abs(J - center);
end

function result = solve_part_one(n)
%SOLVE_PART_ONE Calculate manhattan distance to cell n in fractal memory.
    result = taxicab_dist(get_offset(n));
end

function result = solve_part_two(n)
%SOLVE_PART_TWO Find larger number than `n` in fractal memory sum.
    min_dist = fractal_min_dist(n);

    % Note addition of one extra ring (side length + 2) around
    % matrix to avoid out of bounds (for small n's) when getting
    % the neighborhood of a cell. For larger n, we should really
    % decrease side lengths to avoid ridiculously large matrices.
    side_len = min_dist * 2 + 1 + 2;

    M = zeros(side_len);
    center = floor(side_len / 2) + 1;
    M(center, center) = 1;
    
    % For n=1, we need to loop to element 3, so add 2.
    for i = 2:n+2
        offset = get_offset(i);
        cx = center + offset(1);
        cy = center + offset(2);
        % Sum neighborhood of cell.
        V = M(max(cy - 1, 1):min(cy + 1, side_len), ...
              max(cx - 1, 1):min(cx + 1, side_len));
        s = sum(sum(V));
        M(cy, cx) = s;
        if (s > n)
            result = s;
            break
        end
    end
end

function delta = get_offset(n)
%SOLVE Get offset [x, y] for cell n in fractal memory.

    % Which "ring" is `n` in? (ring 0 is the innermost, the "1").
    min_dist = fractal_min_dist(n);

    % Which is the smallest number in the ring?
    min_n = (max(0, min_dist * 2 - 1))^2 + 1;

    % Distances within a ring follows a repeating pattern, e.g.
    % [5 4 3 4 5 6 ...] for ring 2 (numbers 26-49), with
    % corresponding x/y offsets from center following a similar
    % pattern: [2,1,0,-1,-2,-3], with the sign flipped for the
    % left and bottom edges, which is why we separate delta
    % calculations for each side.
    seq_delta = [min_dist-1:-1:1, 0:-1:-min_dist]';
    N = length(seq_delta);

    side = floor((n - min_n) / N);
    side_offset = mod(n - min_n, N) + 1;
    if side == 0 || side == 2
        delta = [min_dist, seq_delta(side_offset)];
    elseif side == 1 || side == 3
        delta = [seq_delta(side_offset), -min_dist];
    end
    
    % Flip signs for left and bottom sides as we go from
    % top-to-bottom and left-to-right here.
    if side >= 2
        delta = -delta;
    end
end

function m = fractal_min_dist(n)
%FRACTAL_MIN_DIST Gets minimum distance to element `n` in fractal memory.
    c = ceil(sqrt(n));
    if mod(c, 2) == 0
        c = c + 1;
    end
    m = floor(c / 2);
end
 
function d = taxicab_dist(X)
% TAXICAB_DIST Get taxicab distance of coordinate X.
    d = abs(X(1)) + abs(X(2));
end
