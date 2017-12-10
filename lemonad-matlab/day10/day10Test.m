function tests = day10Test
    tests = functiontests(localfunctions);
end

function testKnotHash(testCase)
%TESTSPARSEHASH Verifies samples from part one.
    sparse_hash = knotHash([3, 4, 1, 5], 0:4);
    verifyTrue(testCase, isequal(sparse_hash, [3, 4, 2, 1, 0]));
    verifyEqual(testCase, sparse_hash(1) * sparse_hash(2), 12);
end

function testHashString(testCase)
%TESTHASHSTRING Verifies samples from part two.
    verifyEqual(testCase, hashString(''), ...
                'a2582a3a0e66e6e86e3812dcb672a272');
    verifyEqual(testCase, hashString('AoC 2017'), ...
                '33efeb34ea91902bb2f59c9920caa6cd');
    verifyEqual(testCase, hashString('1,2,3'), ...
                '3efbe78a8d82f29979031a4aa0b16a9d');
    verifyEqual(testCase, hashString('1,2,4'), ...
                '63960835bcdc130f0b66d7ff4f6a5a8e');
    verifyEqual(testCase, hashString('1,2,4'), ...
                '63960835bcdc130f0b66d7ff4f6a5a8e');
end
