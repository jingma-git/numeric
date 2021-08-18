cmake_minimum_required(VERSION 2.8)
project(chp1)

find_package(Eigen3)
if(Eigen3_FOUND)
message("-- Eigen found")
endif()

add_executable(main main_direct.cpp)
# add_executable(main main_iterative.cpp)
target_link_libraries(main Eigen3::Eigen)