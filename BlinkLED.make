PROJECT=BlinkLED
BIN=${PROJECT}
OBJS=${PROJECT}.o
MMCU=atmega328p
F_CPU=16000000 

CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-mmcu=$(MMCU) -Wall -Os -DF_CPU=$(F_CPU) 
LDFLAGS = -Wl,-Map=$(PROJECT).map,--cref

PORT=/dev/ttyACM0

$(BIN).hex: $(BIN).elf
	${OBJCOPY} -O ihex -R .eeprom $< $@;\
	#avr-size --mcu=$(MMCU) --format=avr $< 
	avr-size $< 

$(BIN).elf: ${OBJS}
	${CC} ${CFLAGS} -o $@ $(LDFLAGS) $^
	avr-objdump --disassemble-all $(BIN).elf > ${BIN}.dis

program-usbtiny: ${BIN}.hex 
	avrdude -p ${MCU} -P usb -c usbtiny -U flash:w:$<

program-usbtiny-fuses: $(PROJECT).hex 
	avrdude -p ${MCU} -P usb -c usbtiny -U lfuse:w:0x5E:m 

clean:
	rm -f ${BIN}.elf ${BIN}.hex ${BIN}.map ${BIN}.dis ${OBJS}
