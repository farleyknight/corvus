# Compiler options
INCLUDE = -I src -I ext
CXXFLAGS = -Wall -pedantic -pedantic-errors -g -O0

# Modules
AST_HEAD = src/ast.hpp
AST_SRC = src/ast.cpp
AST = src/ast.o

READER_HEAD = src/reader.hpp
READER_SRC = src/reader.cpp
READER = src/reader.o

MACROS_HEAD = src/macros.hpp
MACROS_SRC = src/macros.cpp
MACROS = src/macros.o

ANNOT = src/annot.hpp
ANNOT_SRC = src/annot.cpp
ANNOT = src/annot.o

MODULES = $(AST) $(READER) $(MACROS) $(ANNOT)

# Compile a module
CMODULE = $(CXX) $(CXXFLAGS) -fPIC $(INCLUDE) -c -o $@ $<
# Link modules into a shared executable
CLINK = $(CXX) $(CXXFLAGS) -shared

# Tests
TEST_SRC = tests/tests.cpp
TEST = test

default: all

$(AST): $(AST_SRC) $(AST_HEAD)
	$(CMODULE)

$(READER): $(READER_SRC) $(READER_HEAD)
	$(CMODULE)

$(MACROS): $(MACROS_SRC) $(MACROS_HEAD)
	$(CMODULE)

$(ANNOT): $(ANNOT_SRC) $(ANNOT_HEAD)
	$(CMODULE)

all: $(MODULES)

corvus: all
	$(CXX) src/main.cpp $(MODULES) -o corvus

$(TEST): $(TEST_SRC) all
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ $< $(AST) $(READER)

clean:
	rm src/*.o