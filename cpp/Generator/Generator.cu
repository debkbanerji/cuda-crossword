#include <bits/stdc++.h>
#include <iostream>
#include <string>
#include <sstream>
#include <iterator>


#include "Generator.h"


#ifndef GRID_VAL
# define GRID_VAL(arr, width, col, row) ((arr)[((width) * (row)) + (col)])
#endif

// TODO: Get based on GPU
#ifndef BLOCK_SIZE
# define BLOCK_SIZE 1024
#endif

#ifndef NUM_BLOCKS
# define NUM_BLOCKS 100
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

    // clear out the current array
    for (int i = 0; i < width * height; i++) {
        result[i] = ' ';
    }

    int numCrosswordWords = 1; // TODO: do this dynamically

    std::vector<std::string> candidates = dictionary;

    for (int iteration = 0; iteration < numCrosswordWords; iteration++) {
        // we need to organize the candidate words in GPU memory in a way that each
        // thread knows how to access the words it needs to work on, and can
        // return the index of the best word
        std::vector<std::vector<std::string> > perThreadCandidates;
        for (int i = 0; i < BLOCK_SIZE * NUM_BLOCKS; i++) {
            std::vector<std::string> candidates;
            // use strides of length BLOCK_SIZE * NUM_BLOCKS to determine this
            // thread's words
            for (int j = 0; j < dictionary.size(); j += BLOCK_SIZE * NUM_BLOCKS) {
                candidates.push_back(dictionary[i + j]);
            }
            perThreadCandidates.push_back(candidates);
        }

        int totalChars = 0;
        std::vector<std::string> joinedPerThreadCandidates;
        std::vector<int> threadCandidatesIndices;// index of the string for each candidate
        std::vector<int> joinedPerThreadCandidatesLengths;
        for (int i = 0; i < perThreadCandidates.size(); i++) {
            std::vector<std::string> candidates = perThreadCandidates[i];
            std::ostringstream imploded; // will include all candidates joined
            // by the delimiter with one at the end
            std::copy(candidates.begin(), candidates.end(),
              std::ostream_iterator<std::string>(imploded, "\n"));
            int joinedLength = 0;
            for (int j = 0; j < candidates.size(); j++) {
                joinedLength += candidates[j].length() + 1; // add 1 for delimiter
            }
            threadCandidatesIndices.push_back(totalChars);
            // std::cout << '\n' << totalChars;
            totalChars += joinedLength;
            joinedPerThreadCandidatesLengths.push_back(joinedLength);
            joinedPerThreadCandidates.push_back(imploded.str());
        }

        std::ostringstream allConcatenatedCandidates; // will include all candidates across all threads joined
        std::copy(joinedPerThreadCandidates.begin(), joinedPerThreadCandidates.end(),
          std::ostream_iterator<std::string>(allConcatenatedCandidates, ""));

        // std::cout << allConcatenatedCandidates.str();

        char * device_crossword; // the copy of the crossword that lives in GPU RAM

        cudaMalloc(&device_crossword, (width * height) * sizeof(char));

        cudaFree(device_crossword);
    }


    // unpack the result into vectors
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
} // generateCrossword
