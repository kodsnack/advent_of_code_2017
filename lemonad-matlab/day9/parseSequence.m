function [score, garbage_count] = parseSequence(text)
%PARSESEQUENCE Parses the top level expression.
    % Enclose in a group and call this level 0 (this
    % does not change the score for an expression.
    text = strcat('{', char(text), '}');
    [score, ~, garbage_count] = parseGroup(text, 1, 0);
end

function [score, index, garbage_count] = parseGroup(text, index, level)
%PARSEGROUP Parses {...}.
    assert(text(index) == '{')
    N = length(text);
    score = 0;
    garbage_count = 0;

    % Skip '{' to avoid infinite recursion.
    index = index + 1;

    while index <= N
        if text(index) == '{'
            [subscore, index, count] = parseGroup(text, index, level + 1);
            score = score + subscore;
            garbage_count = garbage_count + count;
        elseif text(index) == '<'
            [index, count] = parseGarbage(text, index);
            garbage_count = garbage_count + count;
        elseif text(index) == '}'
            index = index + 1;
            score = score + level;
            return 
        elseif text(index) == ','
            index = index + 1;
        else
            error('parse_group:WeirdInput', ...
                  "Weird: '%s' (%d)\n", text(index:N), index);
        end
    end
end

function [index, count] = parseGarbage(text, index)
%PARSEGARBAGE Parses <...>.
    assert(text(index) == '<')
    N = length(text);
    count = 0;

    % Skip initial '<' in order to exclude from count.
    index = index + 1;

    while index <= N
        if text(index) == '!'
            index = index + 2;
        elseif text(index) == '>'
            index = index + 1;
            return 
        else
            count = count + 1;
            index = index + 1;
        end
    end
end
