clear all

filetext = fileread('inputDay4.txt');
splitText = splitlines(filetext);

noOfLines = size(splitText);
%noOfLines = 1
noOfWords = 0;
noOfNotOk = 0;
notOk = 0;


%%%%%%%%%%% Use to switch problem
problem = 1

for line = 1:1:noOfLines
%for line = 3:1:3
    lineText = char(splitText(line,1));
    lineString = string(strsplit(lineText));
    [junk noOfWords] = size(lineString);
    word = 1;
    %Solution to problem 1

    while word < noOfWords
        notOk = 0;
        
        if problem == 1
            %problem 1
            notOk = count(lineString(word),lineString((word+1):noOfWords));
            else
            %Problem 2
            for jj = (word+1):1:noOfWords
                notOk = checkAnagram(lineString(word),lineString(jj)) + notOk;
            end
        end
        if notOk > 0
            line; % Turn if you would like to see which line that fails the test
            noOfNotOk = noOfNotOk +1;
            word = noOfWords;
        end
        word = word + 1;
    end  

end

% the final result
noOfLines(1) - noOfNotOk

%input is two char-words
function nok = checkAnagram(word1,word2)
    charWord1 = char(word1);
    charWord2 = char(word2);
    [junk sizeWord1] = size(charWord1);
    [junk sizeWord2] = size(charWord2);
    sizeWord1;
    nok = 1;
    if (sizeWord1 ~= sizeWord2)
        nok = 0;
    else
        letter = 1;
        corecctCount = 0;
        while  letter <= sizeWord1
            %Checking the anagram so that its not the same number of
            %letters in both words
            if count(charWord1, charWord1(letter)) == count(charWord2, charWord1(letter))
                corecctCount = corecctCount + 1;
            end
            
            letter = letter + 1;
        end
        letter = letter - 1;
        if (letter ~= corecctCount)
            nok = 0;
        end
    end
end
