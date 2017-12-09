/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 4 - High-Entropy Passphrases                     *   ^^^[_]^^^
**                                                                              *
**                                                                              *
**                                                                              *
********************************************************************************/

#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <iterator>
#include <fstream>

using namespace std;


int CountValidPassPhrases(vector<string> input){
    int valid_phrases = 0;
    const int num_of_lines = input.size();

    for(int i=0;i<num_of_lines;i++){    // for each line
        // split the phrase in words
        vector<string> words;
        bool line_valid = true;
        istringstream strstream(input[i]);
        words = vector<string>((istream_iterator<string>(strstream)), istream_iterator<string>());      // splits the phrase to strings delimited by spaces

        // check the words vector for repeating ones
        for(int j=0;j<words.size();j++){
            for(int k=j+1;k<words.size();k++){      // start at the next one
                if(j == k){
                    continue;   // skip if trying to compare to self
                }

                if(words[j] == words[k]){
                    line_valid = false;
                    break;
                }
            }
            if(!line_valid){
                break;  // no need to keep iterating, because a duplicate was found
            }
        }

        // at the end check if there was a duplicate phrase
        if(line_valid){
            valid_phrases++;
        }

    }   // end of for each line

    return valid_phrases;
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
            continue;
        }
        data.push_back(line);
    }

    input.close();
    return data;
}

int main(){
    vector<string> input = ReadFromFile("../../inputs/day4.txt");

    if(input.size() < 1){
        return -1;
    }
    unsigned int result4 = CountValidPassPhrases(input);
    cout<<"Problem 4 result: "<<result4<<endl;

    return 0;
}

