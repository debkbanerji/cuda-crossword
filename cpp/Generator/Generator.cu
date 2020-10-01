#include <bits/stdc++.h>
#include <iostream>

#include "Generator.h"


#ifndef GRID_VAL
# define GRID_VAL(arr, width, col, row) ((arr)[((width) * (row)) + (col)])
#endif

// TODO: Get based on GPU
#ifndef BLOCK_SIZE
# define BLOCK_SIZE 1024
#endif

std::vector<std::vector<char> > generateCrossword(std::vector<std::string> dictionary)
{
    int width  = 12;
    int height = 8;
    // internally, we'll store the crossword as a 1 dimensional array so we can
    // access this from the GPU more easily
    // the crossword itself is very small, so finding contiguous memory will not
    // be an issue
    char result[width * height];

    for (int i = 0; i < width * height; i++) {
        result[i] = ' ';
    }

    std::vector<std::vector<char> > resultVec;
    for (int y = 0; y < height; y++) {
        std::vector<char> row;
        for (int x = 0; x < width; x++) {
            // GRID_VAL(result, width, x, y) = 65 + x + y;
            row.push_back(GRID_VAL(result, width, x, y));
        }
        resultVec.push_back(row);
    }

    return resultVec;
}
