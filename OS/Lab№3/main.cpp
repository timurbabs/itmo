#include <iostream>
#include "fat_16.h"
#include "fat_12.h"
#include "fat_32.h"

using namespace std;

int main() {
    auto fat = fat_32();
    fat.bootFromFile("b0lgeno5.vhd");
    fat.printImage("b0lgeno5.vhd", "/home/vadim/Downloads/LMS");
    fat.copyInside("/home/vadim/Documents/cringe", "popup/");
    std::cout << fat.ls("popup/");
    std::cout << "Free Sectors: " << fat.getFreeClustersCount() << std::endl;
    std::cout << "Allocated Sectors: " << fat.getSlavedClustersCount() << std::endl;

}
