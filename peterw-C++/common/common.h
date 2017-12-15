#pragma once

#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

namespace westerstrom
{
	inline std::vector<std::string> readLines(const std::string& inputFile)
	{
		std::vector<std::string> lines;
		std::fstream f(inputFile);

		while(!f.eof())
		{
			std::string line;
			if(std::getline(f, line))
			{
				line.erase(std::remove(line.begin(), line.end(), '\r'), line.end());
				line.erase(std::remove(line.begin(), line.end(), '\n'), line.end());
				lines.push_back(line);
			}
		}
		return lines;
	}
}
