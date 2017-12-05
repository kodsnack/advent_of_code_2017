//==================//
// 					//
//==================//
#include<fstream>
#include<vector>
#include<iostream>

void f_diff(std::vector<std::vector<int> > &vec,std::vector<int> &out)
{
	int smallest=0;
	int largest=0;

	for(int i=0;i<16;i++)
	{
		smallest = vec[i][0];
		largest = vec[i][0];
		for(int j=0;j<vec[i].size();j++)
		{
			if(smallest>vec[i][j])
				smallest=vec[i][j];
			if(largest<vec[i][j])
				largest=vec[i][j];
		}
		out.push_back(largest-smallest);
	}
}

void f_div(std::vector<std::vector<int> > &vec,std::vector<int> &out)
{
	int numerator;
	int denominator;

	for(int i=0;i<16;i++)
	{
		for(int j=0;j<vec[i].size();j++)
		{
			denominator=vec[i][j];
			for(int n=0;n<vec[i].size();n++)
			{
				if(vec[i][n]%denominator==0 && vec[i][n]!=denominator)
				{
					numerator=vec[i][n];
					out.push_back(numerator/denominator);
				}
			}
		}
	}
}

int checksum(std::vector<int> vec)
{
	int sum=0;

	for(int i=0;i<vec.size();i++)
	{
		sum+=vec[i];
	}

	return sum;
}

void input(std::vector<std::vector<int> > &vec)
{
	std::ifstream input("input.txt");
	int in;
	if(!input)
	{
		std::cout << "you fucked up";

	}else
	{
		for(int i=0;i<16;i++)
		{
			std::vector<int> temp;
			for(int j=0;j<16;j++)
			{
				input >> in;
				temp.push_back(in);
			}
			vec.push_back(temp);
		}
	}
}

int main()
{

	std::vector<std::vector<int> > column;
	std::vector<int> diff,div;

	input(column);
	f_diff(column,diff);
	f_div(column,div);

	std::cout << checksum(diff)<< std::endl << checksum(div);
	
	return 0;
}
