cmake_minimum_required(VERSION 3.19)
project(Tinkoff)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(Tinkoff
        tk6.cpp)
