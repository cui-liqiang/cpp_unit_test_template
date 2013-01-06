RM := rm -rf

TEST_LIBS += \
libs/gtest_main.a

EXECUTABLES += \
out/TDD \
out/TDD_test 

# All of the sources participating in the build are defined here
-include subdir.mk

-include $(CPP_DEPS)

all: out/TDD

# Tool invocations
out/TDD: $(OBJS) $(USER_OBJS) ${MAIN_OBJ}
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "out/TDD" $(OBJS) $(MAIN_OBJ) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(C++_DEPS)$(OBJS)${TEST_OBJS}${MAIN_OBJ}$(C_DEPS)$(CC_DEPS)$(CPP_DEPS) $(EXECUTABLES)$(CXX_DEPS)$(C_UPPER_DEPS) TDD
	-@echo ' '
test: ${TEST_OBJS} ${OBJS}
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "out/TDD_test" $(OBJS) $(USER_OBJS) $(TEST_LIBS) ${TEST_OBJS}
	@echo 'Finished building target: $@'
	out/TDD_test


.PHONY: all clean dependents test
.SECONDARY: