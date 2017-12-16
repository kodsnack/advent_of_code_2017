#pragma once

#include <array>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

template <int N = 256> inline int doSwaps(const std::vector<int> lengths)
{
	std::array<int, N> circularList;
	for(int i = 0; i < N; i++)
		circularList[i] = i;
	int position = 0;
	int skip = 0;
	for(auto length : lengths)
	{
		for(int i = 0; i < length / 2; ++i)
		{
			int j1 = position + i;
			int j2 = position + length - 1 - i;
			swap(circularList[j1 % N], circularList[j2 % N]);
		}
		position += length + skip++;
		position = position % N;
	}

	auto product = circularList[0] * circularList[1];
	return product;
}

//-------------------
// Part 2
//-------------------

template <int N = 256>
inline int doSwaps(const std::vector<int> lengths, std::array<int, N>& circularList, int& position,
                   int& skip)
{
	for(auto length : lengths)
	{
		for(int i = 0; i < length / 2; ++i)
		{
			int j1 = position + i;
			int j2 = position + length - 1 - i;
			std::swap(circularList[j1 % N], circularList[j2 % N]);
		}
		position += length + skip++;
		position = position % N;
	}

	auto product = circularList[0] * circularList[1];
	return product;
}

inline std::vector<int> getLengths(const std::string& input)
{
	std::vector<int> lengths;
	for(char c : input)
	{
		lengths.push_back(static_cast<int>(c));
	}
	std::vector<int> lengthsSuffix = {17, 31, 73, 47, 23};
	lengths.insert(lengths.end(), lengthsSuffix.begin(), lengthsSuffix.end());
	return lengths;
}

template <int N = 256> inline auto getStartList()
{
	std::array<int, N> circularList;
	for(int i = 0; i < N; i++)
		circularList[i] = i;
	return circularList;
}

inline auto computeSparseHash(const std::vector<int>& lengths)
{
	auto circularList = getStartList<256>();
	int position = 0;
	int skip = 0;
	for(int i = 0; i < 64; i++)
	{
		doSwaps<256>(lengths, circularList, position, skip);
	}

	return circularList;
}

inline auto computeDenseHash(const std::array<int, 256>& sparseHash)
{
	std::array<int, 16> denseHash;
	for(int i = 0; i < 16; ++i)
	{
		denseHash[i] = 0;
		for(int j = 0; j < 16; ++j)
		{
			denseHash[i] ^= sparseHash[16 * i + j];
		}
	}

	return denseHash;
}

inline std::string toHex(const std::array<int, 16>& values)
{
	std::stringstream stream;
	for(int v : values)
	{
		stream << std::setfill('0') << std::setw(2) << std::hex << static_cast<unsigned int>(v);
	}
	return stream.str();
}

inline auto knotHash(const std::string& inputStr)
{
	auto lengths = getLengths(inputStr);
	auto sparseHash = computeSparseHash(lengths);
	auto denseHashL = computeDenseHash(sparseHash);
	return denseHashL;
}

inline std::string knotHashStr(const std::string& inputStr)
{
	auto hexStr = toHex(knotHash(inputStr));
	return hexStr;
}
