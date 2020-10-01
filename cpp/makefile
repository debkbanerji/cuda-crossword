# Makefile for Writing Make Files Example

# *****************************************************
# Variables to control Makefile operation

COMPILER = nvcc
# COMPILER_FLAGS = -g -pthread -lX11 -L/usr/include/libpng -I/usr/include/libpng -lpng
COMPILER_FLAGS = -g -lX11
PROFILE_COMMAND = nvprof
MEMCHECK_COMMAND = cuda-memcheck


MAKE_DIR_IF_NOT_EXISTS_COMMAND = mkdir -p
OUTPUT_DIR = out
GENERATOR_DIR = Generator

# ****************************************************
# Targets needed to bring the executable up to date

$(OUTPUT_DIR)/main: main.o Generator.o
	$(MAKE_DIR_IF_NOT_EXISTS_COMMAND) $(OUTPUT_DIR)
	$(COMPILER)  -o $(OUTPUT_DIR)/main main.o Generator.o $(COMPILER_FLAGS)

main.o: main.cu
	$(COMPILER) $(COMPILER_FLAGS) -c main.cu

Generator.o: $(GENERATOR_DIR)/Generator.cu
	$(COMPILER) $(COMPILER_FLAGS) -c $(GENERATOR_DIR)/Generator.cu

clean:
	rm -rf $(OUTPUT_DIR)
	rm -rf ./*.o

run:
	./$(OUTPUT_DIR)/main

clean_run:
	make clean && make && make run

profile:
	$(PROFILE_COMMAND) ./$(OUTPUT_DIR)/main

memcheck:
	$(MEMCHECK_COMMAND) ./$(OUTPUT_DIR)/main
