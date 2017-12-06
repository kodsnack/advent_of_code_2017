%
% Day 4, Advent of code 2017 (Jonas Nockert / @lemonad)
%

%
% Part one.
%

n_valid_passphrases = solve(@valid_passphrase);
fprintf('Number of valid passphrases %d\n', n_valid_passphrases);


%
% Part two (takes a while!).
%

n_valid_passphrases_perms = solve(@valid_passphrase_perms);
fprintf('Number of valid passphrases %d\n', n_valid_passphrases_perms);


%
% Tests
%

assert(valid_passphrase('aa bb cc dd ee'))
assert(~valid_passphrase('aa bb cc dd aa'))
assert(valid_passphrase('aa bb cc dd aaa'))

assert(valid_passphrase_perms('abcde fghij'))
assert(~valid_passphrase_perms('abcde xyz ecdab'))
assert(valid_passphrase_perms('a ab abc abd abf abj'))
assert(valid_passphrase_perms('iiii oiii ooii oooi oooo'))
assert(valid_passphrase_perms('iiii oiii ooii oooi oooo'))
assert(~valid_passphrase_perms('oiii ioii iioi iiio'))

assert(n_valid_passphrases == 337)
assert(n_valid_passphrases_perms == 231)


%
% Helpers
%

function n_valid_passphrases = solve(valid_pred)
%SOLVE Returns number of valid passphrases according to given predicate.
    n_valid_passphrases = 0;

    fp = fopen('Day4.in');
    line = fgetl(fp);
    while ischar(line)
        if valid_pred(line)
            n_valid_passphrases = n_valid_passphrases + 1;
        end
        line = fgetl(fp);
    end
    fclose(fp);
end

function v = valid_passphrase(str)
%VALID_PASSPHRASE Is passphrase valid (part one)?
    words = textscan(str, '%s');
    N = length(words{1});
    N_unique = length(unique(words{1}));

    v = N == N_unique;
end

function v = valid_passphrase_perms(str)
%VALID_PASSPHRASE_PERMS Is passphrase valid (part two)?
    words = textscan(str, '%s');
    anagram_words = {};
    for i = 1:length(words{1})
        wperms = unique(cellstr(perms(words{1}{i})));
        for j = 1:length(wperms)
            anagram_words{length(anagram_words) + 1} = wperms{j};
        end
    end
    N = length(anagram_words);
    N_unique = length(unique(anagram_words));

    v = N == N_unique;
end
