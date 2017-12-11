function tests = day9Test
    tests = functiontests(localfunctions);
end

function testPartOneSampleWithoutGarbage(testCase)
    [s, g] = parseSequence("{}");
    verifyEqual(testCase, s, 1);
    verifyEqual(testCase, g, 0);
    [s, g] = parseSequence("{{{}}}");
    verifyEqual(testCase, s, 6);
    verifyEqual(testCase, g, 0);
    [s, g] = parseSequence("{{},{}}");
    verifyEqual(testCase, s, 5);
    verifyEqual(testCase, g, 0);
    [s, g] = parseSequence("{{{},{},{{}}}}");
    verifyEqual(testCase, s, 16);
    verifyEqual(testCase, g, 0);
end

function testPartOneSampleWithGarbage(testCase)
    [s, g] = parseSequence("{<a>,<a>,<a>,<a>}");
    verifyEqual(testCase, s, 1);
    verifyEqual(testCase, g, 4);
    [s, g] = parseSequence("{{<ab>},{<ab>},{<ab>},{<ab>}}");
    verifyEqual(testCase, s, 9);
    verifyEqual(testCase, g, 8);
    [s, g] = parseSequence("{{<!!>},{<!!>},{<!!>},{<!!>}}");
    verifyEqual(testCase, s, 9);
    verifyEqual(testCase, g, 0);
    [s, g] = parseSequence("{{<a!>},{<a!>},{<a!>},{<ab>}}");
    verifyEqual(testCase, s, 3);
    verifyEqual(testCase, g, 17);
end

function testPartTwoSample(testCase)
    [~, g] = parseSequence("<>");
    verifyEqual(testCase, g, 0);
    [~, g] = parseSequence("<random characters>");
    verifyEqual(testCase, g, 17);
    [~, g] = parseSequence("<<<<>");
    verifyEqual(testCase, g, 3);
    [~, g] = parseSequence("<{!>}>");
    verifyEqual(testCase, g, 2);
    [~, g] = parseSequence("<!!>");
    verifyEqual(testCase, g, 0);
    [~, g] = parseSequence("<!!!>>");
    verifyEqual(testCase, g, 0);
    [~, g] = parseSequence("<{o'i!a,<{i<a>");
    verifyEqual(testCase, g, 10);
end
