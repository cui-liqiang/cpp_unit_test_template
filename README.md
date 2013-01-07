cpp_unit_test_template
======================

This is a template project with makefile to handle compiling, linking and running tests.
This project is using gtest 1.6.0. All needed .a and .h files are included in this project.
All you need to do is to write tests in format of "test/sample_test.cpp".

Edit the following section in Makefile to customize your own project:

	SOURCE_PATH = <your source file path(including .cpp and .h)>
	TEST_PATH = <your test source file path>
	OUT_PATH = <file path to put .o, .d, and executables>

	PROJECT = <your project name(your executable will be out/${PROJECT})>

Running "make all" to compile executables
Running "make test" to compile and run tests