/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 9 - Stream Processing                            *   ^^^[_]^^^
**                                                                              *
**                                                                              *
**                                                                              *
********************************************************************************/


#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <fstream>

using namespace std;

int TotalScore(string input){
    int score = 0;

    int currentGroupScore = 0;                  // represents the score of the current group where the 'cursor' is. As the groups are nested the score increases
    bool is_in_garbage = false;                 // '<'
    bool should_skip_next_char = false;         // '!'


    // iterate through every character and calculate the total score
    for(int i=0;i<input.size();i++){
        char currentChar = input[i];            // load the current character

        if(should_skip_next_char){
            should_skip_next_char = false;
            continue;
        }

        switch(currentChar){
        case '{':
            if(is_in_garbage)
                break;
            currentGroupScore++;
            break;


        case '}':
            if(is_in_garbage)
                break;
            score += currentGroupScore;
            currentGroupScore--;
            break;

        case '!':
            should_skip_next_char = true;
            break;

        case '<':
            is_in_garbage = true;
            break;

        case '>':
            is_in_garbage = false;
            break;

        default:
            break;

        }

    }

    return score;
}


string ReadFromFile(const char* fileName){
    ifstream input(fileName, ifstream::in);
    string data = "";
    string line = "";
    if(!input){
        return "-1";
    }

    while(!input.eof()){
        getline(input,line);
        if(line == ""){
            continue;       // skip if there's nothing on that line
        }
        data += line;
    }

    input.close();
    return data;
}

int main(){
    string input = ReadFromFile("../../inputs/day9.txt");
    if(input.size() < 1){
        return -1;
    }
    int result9 = TotalScore(input);

    cout<<"Problem 9 result: "<<result9<<endl;

    return 0;
}

