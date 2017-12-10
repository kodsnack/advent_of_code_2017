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

int CountTrashCharacters(string input){
    int trash_character_count = 0;

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
                trash_character_count++;

            break;


        case '}':
            if(is_in_garbage)
                trash_character_count++;

            break;

        case '!':
            should_skip_next_char = true;
            break;

        case '<':
            if(is_in_garbage)
                trash_character_count++;
            is_in_garbage = true;
            break;

        case '>':
            is_in_garbage = false;
            break;

        default:
            if(is_in_garbage){
                trash_character_count++;
            }
            break;

        }

    }

    return trash_character_count;
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
    int result9b = CountTrashCharacters(input);

    cout<<"Problem 9b result: "<<result9b<<endl;

    return 0;
}

