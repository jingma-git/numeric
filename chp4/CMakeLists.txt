cmake_minimum_required(VERSION 3.5)
project(least_square)

find_package(Eigen3)
if(EIGEN3_FOUND)
    message("-- EIGEN3_INCLUDE_DIRS ${EIGEN3_INCLUDE_DIRS}")
endif()

add_executable(QR QR.cpp)
target_link_libraries(QR Eigen3::Eigen)