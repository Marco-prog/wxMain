# Compilatore e tools
CXX = g++

# Rileva il sistema operativo
ifeq ($(OS),Windows_NT)
    PLATFORM = windows
else
    UNAME := $(shell uname -s)
    ifeq ($(UNAME),Darwin)
        PLATFORM = mac
    else
        PLATFORM = linux
    endif
endif

# Flag di compilazione
CXXFLAGS = `wx-config --cxxflags` -std=c++17
LDFLAGS = `wx-config --libs`

# Usa wildcard per trovare automaticamente tutti i .cpp
SOURCES = $(wildcard *.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

# Configurazione specifica per piattaforma
ifeq ($(PLATFORM),windows)
    # Windows: eseguibile .exe, resource file con manifest, flag -mwindows
    TARGET      = main.exe
    WINDRES     = windres
    RC_FILE     = app.rc
    RC_OBJECT   = app_res.o
    LDFLAGS    += -mwindows
    EXTRA_DEPS  = $(RC_OBJECT)
    CLEAN_EXTRA = $(RC_OBJECT)
else
    # Mac e Linux: niente resource file né manifest
    TARGET      = main
    EXTRA_DEPS  =
    CLEAN_EXTRA =
endif

# Regola principale
all: $(TARGET)

# Compila il resource file con manifest (solo Windows)
ifeq ($(PLATFORM),windows)
$(RC_OBJECT): $(RC_FILE) app.manifest
	$(WINDRES) $(RC_FILE) -O coff -o $(RC_OBJECT)
endif

# Linka tutto insieme
$(TARGET): $(OBJECTS) $(EXTRA_DEPS)
	$(CXX) -o $@ $^ $(LDFLAGS)

# Regola generica per compilare .cpp in .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Pulizia
clean:
	rm -f $(OBJECTS) $(CLEAN_EXTRA) $(TARGET)

.PHONY: all clean