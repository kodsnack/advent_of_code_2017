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



int Sum_Day2b(const vector<string> input){
    int num_of_lines = input.size();
    unsigned int divisionSum = 0;

    for(int i=0;i<num_of_lines;i++){        // for each row
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


        int division = 0;     // division result
        // iterate the row and try to divide current number by all the next numbers (excluding the current number itself)
        for(int j=0;j<numbers.size();j++){
            for(int k=0;k<numbers.size();k++){
                if(j == k){
                    continue;       // skip if comparing to self
                }
                if(numbers[j]%numbers[k] == 0){                     // found the evenly dividable
                    division = numbers[j] / numbers[k];
                    break;
                }
            }
        }


        divisionSum += division;                 // add to division sum and finish row
    }   // end of row

    return divisionSum;
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
    unsigned int result2b = Sum_Day2b(input);
    cout<<"Problem 2b result: "<<result2b<<endl;

    return 0;
}

