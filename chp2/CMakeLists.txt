cmake_minimum_required(VERSION 2.8)
project(chp1)

find_package(Eigen3)
if(Eigen3_FOUND)
message("-- Eigen found")
endif()

# add_executable(main main_direct.cpp)
# add_executable(main main_iterative.cpp)
# target_link_libraries(main Eigen3::Eigen)


set(QT_INSTALL_PATH /opt/Qt5.12.2/5.10.0/gcc_64)
file( GLOB_RECURSE sres ${QT_INSTALL_PATH}/*/Qt5Config.cmake )
message("-- Qt resouce ${sres}")
get_filename_component( Qt5_DIR ${sres} DIRECTORY )
message("-- Qt5_DIR resouce ${Qt5_DIR}")
set(QT_QMAKE_EXECUTABLE "/opt/Qt5.12.2/5.10.0/gcc_64/bin/qmake")
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Gui REQUIRED)

include_directories(${Qt5Core_INCLUDE_DIRS})

add_executable(poisson poisson.cpp)
target_link_libraries(poisson Eigen3::Eigen Qt5::Core Qt5::Widgets Qt5::Gui)