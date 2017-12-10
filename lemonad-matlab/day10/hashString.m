function hash_str = hashString(indata_str)
%HASHSTRING Returns knot hash string representations for a given string.
    indata = [int32(indata_str), [17, 31, 73, 47, 23]];
    sparse_hash = knotHash(indata, 0:255, 64);
    hash_str = denseHash(sparse_hash);
end

function hash_str = denseHash(sparse_hash)
%DENSEHASH Given a 256 byte sparse hash, returns the dense hash.
    assert(length(sparse_hash) == 256)
    H = zeros(1, 16);
    for i = 0:15
        H(i + 1) = hash16(sparse_hash(i * 16 + 1:i * 16 + 16));
    end
    hash_str = lower(strjoin(cellstr(dec2hex(H)),''));
end

function s = hash16(T)
%HASH16 Creates one-byte dense hash value out of a 16 byte sparse hash.
    assert(length(T) == 16)
    val = 0;
    for j = 1:16
        val = bitxor(val, T(j));
    end
    s = val;
end
