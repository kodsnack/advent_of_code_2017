
include_directories(${CMAKE_CURRENT_BINARY_DIR})

set (DAY 1)
add_executable(Day${DAY}
	"Day${DAY}.cpp"
)
