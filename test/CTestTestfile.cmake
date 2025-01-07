# CMake generated Testfile for 
# Source directory: C:/Projects/modbuild/TestMod/test
# Build directory: C:/Projects/modbuild/TestMod/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] "C:/Projects/modbuild/TestMod/build/bin/Debug/test.exe")
  set_tests_properties([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] PROPERTIES  _BACKTRACE_TRIPLES "C:/Projects/modbuild/TestMod/test/CMakeLists.txt;110;add_test;C:/Projects/modbuild/TestMod/test/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] "C:/Projects/modbuild/TestMod/build/bin/Release/test.exe")
  set_tests_properties([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] PROPERTIES  _BACKTRACE_TRIPLES "C:/Projects/modbuild/TestMod/test/CMakeLists.txt;110;add_test;C:/Projects/modbuild/TestMod/test/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] "C:/Projects/modbuild/TestMod/build/bin/MinSizeRel/test.exe")
  set_tests_properties([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] PROPERTIES  _BACKTRACE_TRIPLES "C:/Projects/modbuild/TestMod/test/CMakeLists.txt;110;add_test;C:/Projects/modbuild/TestMod/test/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] "C:/Projects/modbuild/TestMod/build/bin/RelWithDebInfo/test.exe")
  set_tests_properties([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] PROPERTIES  _BACKTRACE_TRIPLES "C:/Projects/modbuild/TestMod/test/CMakeLists.txt;110;add_test;C:/Projects/modbuild/TestMod/test/CMakeLists.txt;0;")
else()
  add_test([=[C:/Projects/modbuild/TestMod/test/src/BeginTest.cpp]=] NOT_AVAILABLE)
endif()
subdirs("../_deps/googletest-build")
