# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/ssd/CLion/clion-2021.1/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/ssd/CLion/clion-2021.1/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/timurbabs/ITMO/Tinkoff

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/timurbabs/ITMO/Tinkoff/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Tinkoff.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Tinkoff.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Tinkoff.dir/flags.make

CMakeFiles/Tinkoff.dir/tk6.cpp.o: CMakeFiles/Tinkoff.dir/flags.make
CMakeFiles/Tinkoff.dir/tk6.cpp.o: ../tk6.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/timurbabs/ITMO/Tinkoff/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Tinkoff.dir/tk6.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Tinkoff.dir/tk6.cpp.o -c /home/timurbabs/ITMO/Tinkoff/tk6.cpp

CMakeFiles/Tinkoff.dir/tk6.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Tinkoff.dir/tk6.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/timurbabs/ITMO/Tinkoff/tk6.cpp > CMakeFiles/Tinkoff.dir/tk6.cpp.i

CMakeFiles/Tinkoff.dir/tk6.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Tinkoff.dir/tk6.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/timurbabs/ITMO/Tinkoff/tk6.cpp -o CMakeFiles/Tinkoff.dir/tk6.cpp.s

# Object files for target Tinkoff
Tinkoff_OBJECTS = \
"CMakeFiles/Tinkoff.dir/tk6.cpp.o"

# External object files for target Tinkoff
Tinkoff_EXTERNAL_OBJECTS =

Tinkoff: CMakeFiles/Tinkoff.dir/tk6.cpp.o
Tinkoff: CMakeFiles/Tinkoff.dir/build.make
Tinkoff: CMakeFiles/Tinkoff.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/timurbabs/ITMO/Tinkoff/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Tinkoff"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Tinkoff.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Tinkoff.dir/build: Tinkoff

.PHONY : CMakeFiles/Tinkoff.dir/build

CMakeFiles/Tinkoff.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Tinkoff.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Tinkoff.dir/clean

CMakeFiles/Tinkoff.dir/depend:
	cd /home/timurbabs/ITMO/Tinkoff/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/timurbabs/ITMO/Tinkoff /home/timurbabs/ITMO/Tinkoff /home/timurbabs/ITMO/Tinkoff/cmake-build-debug /home/timurbabs/ITMO/Tinkoff/cmake-build-debug /home/timurbabs/ITMO/Tinkoff/cmake-build-debug/CMakeFiles/Tinkoff.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Tinkoff.dir/depend

