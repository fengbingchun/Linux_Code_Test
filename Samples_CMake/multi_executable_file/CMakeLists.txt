PROJECT(multi_executable_file)
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

# 查找OpenCV
FIND_PACKAGE(OpenCV REQUIRED)
IF(OpenCV_FOUND)
	MESSAGE("===== support OpenCV =====")
	MESSAGE(STATUS "OpenCV library status:")
	MESSAGE(STATUS "	version: ${OpenCV_VERSION}")
	MESSAGE(STATUS "	include path: ${OpenCV_INCLUDE_DIRS}")
	MESSAGE(STATUS "	install path: ${OpenCV_INSTALL_PATH}")
	MESSAGE(STATUS "	libraries: ${OpenCV_LIBS}")
	INCLUDE_DIRECTORIES(${OpenCV_INCLUDE_DIRS})
ELSE()
	MESSAGE("##### not support OpenCV #####")
ENDIF()

# 查找OpenMP
FIND_PACKAGE(OpenMP REQUIRED)
IF(OpenMP_FOUND)
	MESSAGE("===== support OpenMP =====")
	MESSAGE(STATUS "OpenMP library status:")
	MESSAGE(STATUS "	version: ${OpenMP_VERSION}")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
ELSE()
	MESSAGE("##### not support OpenMP #####")
ENDIF()

# 查找OpenGL
FIND_PACKAGE(OpenGL REQUIRED)
IF(OPENGL_FOUND)
	MESSAGE("===== support OpenGL =====")
	MESSAGE(STATUS "OpenGL library status:")
	MESSAGE(STATUS "	include path: ${OPENGL_INCLUDE_DIR}")
	MESSAGE(STATUS "	libraries: ${OPENGL_LIBRARIES}")
	INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
ELSE()
	MESSAGE("##### not support OpenGL #####")
ENDIF()

# 查找GLUT
FIND_PACKAGE(GLUT REQUIRED)
IF(GLUT_FOUND)
	MESSAGE("===== support GLUT =====")
	MESSAGE(STATUS "	include path: ${GLUT_INCLUDE_DIR}")
	MESSAGE(STATUS "	libraries: ${GLUT_LIBRARIES}")
	INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})
ELSE()
	MESSAGE("##### not support GLUT #####")
ENDIF()

# 支持C++11
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -O2 -std=c11")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -g -Wall -O2 -std=c++11")

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR})

FILE(GLOB samples ${PROJECT_SOURCE_DIR}/*.cpp)

FOREACH (sample ${samples})
	STRING(REGEX MATCH "[^/]+$" sample_file ${sample})
	STRING(REPLACE ".cpp" "" sample_basename ${sample_file})
	ADD_EXECUTABLE(test_${sample_basename} ${sample})
	TARGET_LINK_LIBRARIES(test_${sample_basename} ${OpenCV_LIBS} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY} pthread)
ENDFOREACH()

