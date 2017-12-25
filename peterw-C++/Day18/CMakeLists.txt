project(Day18)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

configure_file(config.h.in config.h)

add_executable(${PROJECT_NAME}p1 "${PROJECT_NAME}p1.cpp" input.txt config.h.in)
add_executable(${PROJECT_NAME}p2 "${PROJECT_NAME}p2.cpp" input.txt config.h.in)
