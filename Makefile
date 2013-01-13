# Change the following section for your project
SOURCE_PATH = src
TEST_PATH = test
OUT_PATH = out

PROJECT = TDD

# Codes below should not be changed for regular usage
RM := rm -rf

TEST_LIBS += \
libs/gtest_main.a

EXECUTABLES += \
${OUT_PATH}/${PROJECT} \
${OUT_PATH}/${PROJECT}_test 

ALL_SOURCE_FILE = $(wildcard ${SOURCE_PATH}/*.cpp)
ALL_SOURCE_FILE_WITHOUT_MAIN = $(filter-out ${SOURCE_PATH}/main.cpp,${ALL_SOURCE_FILE})
ALL_OBJECT_WITHOUT_MAIN = $(patsubst ${SOURCE_PATH}%.cpp,${OUT_PATH}%.o,$(ALL_SOURCE_FILE_WITHOUT_MAIN)) 

ALL_TEST_FILE = $(wildcard ${TEST_PATH}/*.cpp)
ALL_TEST_OBJECT = $(patsubst ${TEST_PATH}%.cpp,${OUT_PATH}%.o,${ALL_TEST_FILE})

OBJS = ${ALL_OBJECT_WITHOUT_MAIN}
MAIN_OBJ = ${OUT_PATH}/main.o 
TEST_OBJS = ${ALL_TEST_OBJECT} 

CPP_DEPS += \
$(patsubst ${SOURCE_PATH}%.cpp,${OUT_PATH}%.d,${ALL_SOURCE_FILE}) \
$(patsubst ${TEST_PATH}%.cpp,${OUT_PATH}%.d,${ALL_TEST_FILE}) 

# Each subdirectory must supply rules for building sources it contributes
${MAIN_OBJ}${OBJS}:${OUT_PATH}/%.o: ${SOURCE_PATH}/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

${TEST_OBJS}:${OUT_PATH}/%.o: ${TEST_PATH}/%.cpp
	@echo 'Building test file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -Iincludes -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

-include $(CPP_DEPS)

all: ${OUT_PATH}/${PROJECT}

# Tool invocations
${OUT_PATH}/${PROJECT}: $(OBJS) $(USER_OBJS) ${MAIN_OBJ} init
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "${OUT_PATH}/${PROJECT}" $(OBJS) $(MAIN_OBJ) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(C++_DEPS)$(OBJS)${TEST_OBJS}${MAIN_OBJ}$(C_DEPS)$(CC_DEPS)$(CPP_DEPS) $(EXECUTABLES)$(CXX_DEPS)$(C_UPPER_DEPS) ${PROJECT} ${OUT_PATH}
	-@echo ' '
test: ${TEST_OBJS} ${OBJS} init
	@echo 'Building target: $@'
	@echo 'Invoking: Cross G++ Linker'
	g++  -o "${OUT_PATH}/${PROJECT}_test" $(OBJS) $(USER_OBJS) $(TEST_LIBS) ${TEST_OBJS}
	@echo 'Finished building target: $@'
	${OUT_PATH}/${PROJECT}_test
init: 
	@echo 'creating ${OUT_PATH} directory'
	mkdir ${OUT_PATH}

.PHONY: all clean dependents test init
.SECONDARY:
