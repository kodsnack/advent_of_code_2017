#include <fstream>
#include <string>
#include <vector>

namespace westerstrom
{
	inline std::vector<std::string> readLines(const std::string& inputFile)
	{
		std::vector<std::string> lines;
		std::fstream f(inputFile);

		while(!f.eof())
		{
			std::string line;
			if(getline(f, line))
			{
				lines.push_back(line);
			}
		}
		return lines;
	}
}
