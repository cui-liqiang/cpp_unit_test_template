RM := rm -rf
TEST_LIBS += \
gtest_main.a

# All of the sources participating in the build are defined here
-include subdir.mk

-include $(CPP_DEPS)

all: TDD

# Tool invocations
TDD: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "TDD" $(OBJS) $(MAIN_OBJ) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(C++_DEPS)$(OBJS)$(C_DEPS)$(CC_DEPS)$(CPP_DEPS)$(EXECUTABLES)$(CXX_DEPS)$(C_UPPER_DEPS) TDD
	-@echo ' '
test: ${TEST_OBJS} ${OBJS}
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "TDD_test" $(OBJS) $(USER_OBJS) $(TEST_LIBS) ${TEST_OBJS}
	@echo 'Finished building target: $@'
	./TDD_test


.PHONY: all clean dependents
.SECONDARY: