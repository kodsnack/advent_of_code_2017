function sparse_hash = knotHash(indata, L, n_rounds)
%KNOTHASH Given a list of bytes, calculates the n-round sparse knot hash.
    if nargin < 3
        n_rounds = 1;
    end

    n = length(L);
    current_pos = 0;
    skip_size = 0;

    for round = 1:n_rounds
        for i = indata
            L = partialReverse(L, mod(current_pos, n), i);
            current_pos = current_pos + i + skip_size;
            skip_size = skip_size + 1;
        end
    end
    sparse_hash = L;
end

function L = partialReverse(L, current_pos, len)
%PARTIALREVERSE Reverses a part of a circular list.
    L_shifted = circshift(L, -current_pos);
    L_shifted(1:len) = fliplr(L_shifted(1:len));
    L = circshift(L_shifted, current_pos);
end
