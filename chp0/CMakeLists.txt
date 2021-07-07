cmake_minimum_required(VERSION 2.8)
project(basic)


find_package(Eigen3 3.1.0)
if(Eigen3_FOUND)
   message("-- Found Eigen3")
else()
   message("-- Not Found Eigen3")
endif()


add_executable(nest nest.cpp)
target_link_libraries(nest Eigen3::Eigen)