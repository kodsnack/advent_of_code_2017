/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 2 - Corruption Checksum                          *   ^^^[_]^^^
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



int Sum_Day2(const vector<string> input){
    int num_of_lines = input.size();
    unsigned int checkSum = 0;

    for(int i=0;i<num_of_lines;i++){        // for each row
        int minimum = 0;
        int maximum = 0;
        vector<int> numbers;
        // read the whole row
        stringstream strm(input[i]);
        int number;
        while(true){
            strm >> number;
            if(!strm){
                break;
            }
            numbers.push_back(number);

        }

        minimum = numbers[0];       // minimum has to be set to something so it can be compared. it can't be just 0

        // iterate the row and find the lowest and highest number
        for(int i=0;i<numbers.size();i++){
            if(numbers[i] < minimum){
                minimum = numbers[i];
            }

            if(numbers[i] > maximum){
                maximum = numbers[i];
            }
        }

        int difference = maximum - minimum;     // minimum and maximum are set, find the difference
        checkSum += difference;                 // add to checksum and finish row
    }   // end of row

    return checkSum;
}


vector<string> ReadFromFile(const char* fileName){
    ifstream input(fileName, ifstream::in);
    vector<string> data;
    string line = "";
    if(!input){
        return data;
    }

    while(!input.eof()){
        getline(input,line);
        if(line == ""){
            continue;       // skip if there's nothing on that line
        }
        data.push_back(line);
    }

    input.close();
    return data;
}

int main(){
    vector<string> input = ReadFromFile("../../inputs/day2.txt");
    if(input.size() < 1){
        return -1;
    }
    unsigned int result2 = Sum_Day2(input);
    cout<<"Problem 2 result: "<<result2<<endl;

    return 0;
}

