OBJS +=

MAIN_OBJ = out/main.o 

TEST_OBJS += \
out/sample_test.o 

CPP_DEPS += \
out/main.d out/sample_test.d

# Each subdirectory must supply rules for building sources it contributes
${MAIN_OBJ}${OBJ}:out/%.o: src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

${TEST_OBJS}:out/%.o: test/%.cpp
	@echo 'Building test file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -Iincludes -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '