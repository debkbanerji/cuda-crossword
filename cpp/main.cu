#include <bits/stdc++.h>
#include <iostream>
#include <chrono>

#include "Generator/Generator.h"

// using namespace std;

int main(int argc, char ** argv)
{
    std::cout << "Running Test" << std::endl;
    std::cout << "Reading in dictionary" << std::endl;

    std::vector<std::string> dictionary; // TODO: Read dictionary from file

    std::cout << "Generating crossword" << std::endl;

    auto t1 = std::chrono::high_resolution_clock::now();
    auto t2 = std::chrono::high_resolution_clock::now();

    auto durationMicroSeconds = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    auto durationMS  = durationMicroSeconds / 1000;
    auto durationSec = durationMS / 1000;

    std::cout << "Finished crossword generation in " << durationSec / 60 << " minutes, "
              << durationSec % 60 << " seconds, "
              << durationMS % 1000 << " milliseconds\n";


    // std::cin.ignore();

    return 0;
} // main
