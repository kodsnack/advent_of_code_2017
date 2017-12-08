/************************  ADVENT OF CODE 2017 **********************************       *
**                                                                              *      /.\
**                         adventofcode.com                                     *     /..'\
**                                                                              *     /'.'\
**                         mlogic1 (https://github.com/mlogic1)                 *    /.''.'\
**                                                                              *    /.'.'.\
**                                                                              *   /'.''.'.\
**                         Day 8 - I Heard You Like Registers                   *   ^^^[_]^^^
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


class Register{
private:
    string _name;
    int _value;

public:
    Register(string name, int value = 0){
        _name = name;
        _value = value;
    }

    int GetValue(){
        return _value;
    }

    string GetName(){
        return _name;
    }

    void AddValue(int value){
        _value += value;
    }

};

// holds all known registers
vector<Register> Registers;
int allTimeHigh = 0;            // all time highest value register, it's used for the second part of the puzzle

bool IfRegisterExists(string name){
    for(int i=0;i<Registers.size();i++){
        if(Registers[i].GetName() == name){
            return true;
        }
    }

    return false;
}

Register& GetRegisterByName(string name){
    for(int i=0;i<Registers.size();i++){
        if(Registers[i].GetName() == name){
            return Registers[i];
        }
    }
}

int LargestValue(vector<string> input){
    int largestValue = 0;
    int n_of_commands = input.size();


    /*  first initialize and create all registers   */
    for(int i=0;i<n_of_commands;i++){
        istringstream strm(input[i]);
        string register_name = "";
        strm>>register_name;
        if(!IfRegisterExists(register_name)){               // if register does not exist, create it
            Register r(register_name);
            Registers.push_back(r);
        }
    }



    /*  start parsing commands  */
    for(int i=0;i<n_of_commands;i++){
        string register_name = "";
        string command = "";
        int change = 0;
        string if_keyword = "";// if keyword is dismissed
        string condition_register = "";
        string condition = "";
        int condition_value = 0;

        istringstream inStream(input[i]);

        // populate all variables
        inStream>>register_name;
        inStream>>command;
        inStream>>change;
        inStream>>if_keyword;
        inStream>>condition_register;
        inStream>>condition;
        inStream>>condition_value;

        // check if register exists
        if(!IfRegisterExists(register_name) || !IfRegisterExists(condition_register)){
            continue;
        }

        Register &reg = GetRegisterByName(register_name);
        Register &condition_reg = GetRegisterByName(condition_register);

        if(reg.GetValue() > allTimeHigh){
            allTimeHigh = reg.GetValue();
        }

        // first check if the condition satisfies
        bool condition_pass = false;
        if(condition == "<"){
            condition_pass = condition_reg.GetValue() < condition_value;
        }else if(condition == ">"){
            condition_pass = condition_reg.GetValue() > condition_value;
        }else if(condition == "=="){
            condition_pass = condition_reg.GetValue() == condition_value;
        }else if(condition == ">="){
            condition_pass = condition_reg.GetValue() >= condition_value;
        }else if(condition == "<="){
            condition_pass = condition_reg.GetValue() <= condition_value;
        }else if(condition == "!="){
            condition_pass = condition_reg.GetValue() != condition_value;
        }else{
            continue;   // this should not happen
        }


        if(!condition_pass){
            continue;       // skip cycle because the condition did not satisfy
        }

        if(command == "inc"){
            reg.AddValue(change);
        }else if(command == "dec"){
            reg.AddValue((change * -1));
        }else{
            continue;   // this should not happen
        }

    }

    // after all the cycles iterate once again to find the largest value
    for(int i=0;i<Registers.size();i++){
        if(Registers[i].GetValue() > largestValue){
            largestValue = Registers[i].GetValue();
        }
    }


    return largestValue;
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
    vector<string> input = ReadFromFile("../../inputs/day8.txt");
    if(input.size() < 1){
        return -1;
    }
    int result8 = LargestValue(input);
    int result8b = allTimeHigh;
    cout<<"Problem 8 result: "<<result8<<endl;
    cout<<"Problem 8b result: "<<result8b<<endl;



    return 0;
}

