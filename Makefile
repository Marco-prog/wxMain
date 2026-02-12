# Compilatore e tools
CXX = g++
WINDRES = windres

# Flag di compilazione
CXXFLAGS = `wx-config --cxxflags` -std=c++17
LDFLAGS = `wx-config --libs`

# Usa wildcard per trovare automaticamente tutti i .cpp
SOURCES = $(wildcard *.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

# File resource
RC_FILE = app.rc
RC_OBJECT = app_res.o

# Nome eseguibile
TARGET = main.exe

# Regola principale
all: $(TARGET)

# Compila il resource file
$(RC_OBJECT): $(RC_FILE) app.manifest
	$(WINDRES) $(RC_FILE) -O coff -o $(RC_OBJECT)

# Linka tutto insieme
$(TARGET): $(OBJECTS) $(RC_OBJECT)
	$(CXX) -o $@ $^ $(LDFLAGS) -mwindows

# Regola generica per compilare .cpp in .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Pulizia
clean:
	rm -f $(OBJECTS) $(RC_OBJECT) $(TARGET)

.PHONY: all clean