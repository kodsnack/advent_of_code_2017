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



int Sum_Day1(const string input){
    int num_of_characters = input.size();
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
        if(i == num_of_characters - 1){     // if the current number is the last one  in the array, the next number is the first number
            next_number = numbers[0];
        }else{
            next_number = numbers[i+1];
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
    unsigned int result1 = Sum_Day1(input);
    cout<<"Problem 1 result: "<<result1<<endl;

    return 0;
}

