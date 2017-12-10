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
            L = partialReverse(L, current_pos, i);
            current_pos = mod(current_pos + i + skip_size, n);
            skip_size = skip_size + 1;
        end
    end
    sparse_hash = L;
end

function L = partialReverse(L, current_pos, len)
%PARTIALREVERSE Reverses a part of a circular list.
    n = length(L);

    si = current_pos;
    ei = current_pos + len - 1;
    for j = 0:floor(len / 2) - 1
        tmp = L(mod(ei, n) + 1);
        L(mod(ei, n) + 1) = L(mod(si, n) + 1);
        L(mod(si, n) + 1) = tmp;
        si = si + 1;
        ei = ei - 1;
    end
end
