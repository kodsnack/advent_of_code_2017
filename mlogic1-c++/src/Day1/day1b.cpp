/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 1 - Inverse Captcha                              *   ^^^[_]^^^
**                                                                              *
**                                                                              *
**                                                                              *
********************************************************************************/


#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;



int Sum_Day1b(const string input){
    int num_of_characters = input.size();
    int num_of_characters_half = num_of_characters / 2;
    unsigned int sum = 0;
    vector<int> numbers;

    // read each character, convert it to an integer and add it to the array
    for(int i=0;i<num_of_characters;i++){
        char numChar = input[i] - 48;
        int number = static_cast<int>(numChar);
        numbers.push_back(number);
    }

    for(int i=0;i<num_of_characters;i++){
        int current_number = numbers[i];
        int next_number;



        // two possible outcomes
        // 1 - the current number is before the half of the list
        // 2 - the current number is after the half of the list

        if(i<num_of_characters_half){
            next_number = numbers[i + num_of_characters_half];
        }else{
            next_number = numbers[i - num_of_characters_half];
        }

        // check if the next number is equal to the current
        if(current_number == next_number){
            sum += current_number;
        }

    }

    return sum;
}


string ReadFromFile(const char* fileName){
    ifstream input(fileName, ifstream::in);
    string data = "";

    if(!input){
        return "-1";
    }

    while(!input.eof()){
        getline(input,data);
    }

    input.close();
    return data;
}

int main(){
    string input = ReadFromFile("../../inputs/day1.txt");
    if(input == "-1"){
        return -1;
    }
    unsigned int result1 = Sum_Day1b(input);
    cout<<"Problem 1b result: "<<result1<<endl;

    return 0;
}

