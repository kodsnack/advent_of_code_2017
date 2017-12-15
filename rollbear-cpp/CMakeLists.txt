cmake_minimum_required(VERSION 3.9)
project(advent_of_code_2017)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -Wshadow -Werror")
set(CATCH_DIR "catch")
if(NOT EXISTS ${CATCH_DIR}/catch.hpp)
    if (NOT EXISTS ${CATCH_DIR})
        make_directory(${CATCH_DIR})
    endif()
    file(
            DOWNLOAD
            https://raw.githubusercontent.com/catchorg/Catch2/v1.11.0/single_include/catch.hpp  ${CATCH_DIR}/catch.hpp
            STATUS
            status
            LOG
            log
    )
    list(GET status 0 status_code)
    list(GET status 1 status_string)

    if(NOT status_code EQUAL 0)
        message(FATAL_ERROR "error downloading catch: ${status_string}"
                "${log}")
    endif()
endif()

include_directories(${CMAKE_BINARY_DIR}/${CATCH_DIR})

add_subdirectory(Day1)
add_subdirectory(Day2)
add_subdirectory(Day3)
add_subdirectory(Day4)
add_subdirectory(Day5)
add_subdirectory(Day6)
add_subdirectory(Day7)
add_subdirectory(Day8)
add_subdirectory(Day9)
add_subdirectory(Day10)
add_subdirectory(Day11)
add_subdirectory(Day12)
add_subdirectory(Day13)
add_subdirectory(Day14)
add_subdirectory(Day15)
