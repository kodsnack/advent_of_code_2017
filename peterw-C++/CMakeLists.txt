cmake_minimum_required(VERSION 3.9)

set (CMAKE_CXX_STANDARD 17)
set (CMAKE_XCODE_ATTRIBUTE_COMPILER_INDEX_STORE_ENABLE NO)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(Day1)
add_subdirectory(Day2)
add_subdirectory(Day3)
add_subdirectory(Day4)
