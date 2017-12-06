/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 5 - A Maze of Twisty Trampolines, All Alike      *   ^^^[_]^^^
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

int Steps_Day5(vector<int> input){
    int num_of_numbers = input.size();
    unsigned int steps = 0;

    int current_index = 0; // the jumping starts at index 0
    int next_index = 0;

    while(true){
        int current_value = input[current_index];
        next_index = current_index + current_value;     // calculate the next index
        input[current_index]++;
        steps++;                                        // count it as a step

        if(next_index <0 || next_index > num_of_numbers-1){
            // solution found, break and return number of steps
            break;
        }
        current_index = next_index;                     // "jump" to next number
    }

    return steps;
}


vector<int> ReadFromFile(const char* fileName){     // reads input line by line and parses to int
    ifstream input(fileName, ifstream::in);
    vector<int> data;
    string line = "";
    if(!input){
        return data;
    }

    while(!input.eof()){
        getline(input,line);
        stringstream ss(line);
        int number = 0;
        ss >> number;
        if(!ss){
            break;
        }
        data.push_back(number);
    }

    input.close();
    return data;
}

int main(){
    vector<int> input = ReadFromFile("../../inputs/day5.txt");
    if(input.size() < 1){
        return -1;
    }
    unsigned int result5 = Steps_Day5(input);
    cout<<"Problem 5 result: "<<result5<<endl;

    return 0;
}

