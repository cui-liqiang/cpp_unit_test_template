OBJS +=

MAIN_OBJ = main.o 

TEST_OBJS += \
./sample_test.o

CPP_DEPS += \
./main.d  

# Each subdirectory must supply rules for building sources it contributes
%.o: %.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

${TEST_OBJS}:%.o: %.cpp
	@echo 'Building test file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -Iincludes -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '