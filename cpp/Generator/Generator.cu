#include <bits/stdc++.h>
#include <iostream>

#include "Generator.h"


// TODO: Get based on GPU
#ifndef BLOCK_SIZE
# define BLOCK_SIZE 1024
#endif

std::vector<std::vector<char> > generateCrossword(std::vector<std::string> dictionary)
{
    int width  = 8;
    int height = 8;
    char result[width][height];

    for (int y = 0; y < width; y++) {
        for (int x = 0; x < height; x++) {
            result[x][y] = ' ';
        }
    }

    std::vector<std::vector<char> > resultVec;

    for (int y = 0; y < width; y++) {
        std::vector<char> row;
        for (int x = 0; x < height; x++) {
            // result[x][y] = 65 + x + y;
            row.push_back(result[x][y]);
        }
        resultVec.push_back(row);
    }

    return resultVec;
}
