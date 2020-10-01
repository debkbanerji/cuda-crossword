#include <bits/stdc++.h>
#include <iostream>
#include <chrono>
#include <sstream>
#include <string>

#include "Generator/Generator.h"

// using namespace std;

int main(int argc, char ** argv)
{
    std::cout << "Running Test" << std::endl;
    std::cout << "Reading in dictionary" << std::endl;


    // Read in the dictionary file
    // Assume every line is a word that could be in the crossword
    // TODO: add support for clues in dictionary file
    std::vector<std::string> dictionary;
    std::ifstream infile("test-dictionaries/pokedex-gen6.txt");
    std::string line;
    while (std::getline(infile, line)) {
        std::istringstream iss(line);
        // convert line to lowercase
        std::transform(line.begin(), line.end(), line.begin(),
          [](unsigned char c){
            return std::tolower(c);
        });
        // std::cout << line;
        dictionary.push_back(line);
    }

    std::cout << "Generating crossword" << std::endl;

    auto t1 = std::chrono::high_resolution_clock::now();
    std::vector<std::vector<char> > crossword = generateCrossword(dictionary);
    auto t2 = std::chrono::high_resolution_clock::now();

    auto durationMicroSeconds = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    auto durationMS  = durationMicroSeconds / 1000;
    auto durationSec = durationMS / 1000;

    std::cout << "Finished crossword generation in " << durationSec / 60 << " minutes, "
              << durationSec % 60 << " seconds, "
              << durationMS % 1000 << " milliseconds\n";


    for (int x = 0; x < crossword.size(); x++) {
        for (int y = 0; y < crossword[0].size(); y++) {
            std::cout << crossword[x][y] << ' ';
        }
        std::cout << std::endl;
    }

    // std::cin.ignore();

    return 0;
} // main
