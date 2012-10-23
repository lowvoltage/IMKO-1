;
; DZ80 configuration file for IMKO-1.bin 
;
;
; Labels and comments
;

L 0000 RST0
! 0000 Set stack base at memory address 1470
! 0003 A := 0xAA

L 0008 RST1
L 0010 RST2
L 0018 RST3
L 0020 RST4
L 0028 RST5
L 0030 RST6
L 0038 RST7

L 003E writeToUART
L 003F writeToUARTloop
# 003E
# 003E Waits for "Transmission-buffer empty" (TBMT)
# 003E and outputs the contents of A to the UART (IO address 0x02)
# 003E
! 003E Backup A
! 003F Read UART status byte
! 0041 Check for TBMT flag
! 0043 Jump back if TBMT flag is not set
! 0046 Restore A
! 0047 Write A to UART

L 004A write00hToIO7
# 004A
# 004A Send 00h to IO-7, store it at memory address 1470
# 004A
! 004A A := 00h

L 004E init
L 0084 checkMemLoop
L 008F endOfMem
# 004E
# 004E Continues the system initialization, started in RST0
# 004E This includes:
# 004E * Setting up JMP instructions in RAM for RST3 ~ RST7
# 004E * Setting up JMP instructions in RAM for ????
# 004E * Determining the amount of installed RAM
# 004E * TODO: More
# 004E
! 004E mem[1401] := 0xAA
! 0051 Setup jumps to 0x0174 at memory addesses 1430, 1433, 1436, 1439 and 143C
! 005A Setup jumps to 0x015B at memory addesses 1473, 1476 and 1479 (147C and 147F are not used?)
! 0063 mem[1476] actually jumps to 0x01BF
! 0069 mem[1479] actually jumps to 0x0104
! 006F mem[1402] := 0x02F1 - something to do with timing TODO: What?
! 0075 A := 0x80
! 0077 mem[1472] := 0x80
! 007A Write 0x80 to the parallel-out (IO-3)
! 007C A := 0x00
! 007D Write 0x00 to IO-6
! 007F Write 0x00 to IO-7 TODO: What are these IOs?
! 0081 Set the memory address to 0x14FF, the last of the first 256 bytes of RAM
! 0084 Backup the contents of the current memory address
! 0085 Write A (0x00) to memory
! 0086 Read back from memory and compare with A
! 0087 If values differ, this is an end-of-memory address
! 008A If values are the same, restore memory contents
! 008B Advance to the next memory address
! 008C Jump back and redo the check
! 008F Set 0x00 to the lower byte of the memory address [H, L] 
! 0090 Store the max memory address at mem[1481]
! 009A TODO: Is this line reachable?

L 009B fillMem5
L 009D fillMemLoop
# 009B
# 009B Fills five sets of consecutive memory addresses with "C3 [E] [D]" triplets,
# 009B which decode to "JMP [DE]" instructions 
# 009B
! 009B B := 5
! 009D mem[H++] := 0xC3
! 00A0 mem[H++] := E
! 00A2 mem[H++] := D
! 00A4 --B
! 00A5 Jump back if B != 0

L 00BF cmpDH
# 00BF
# 00BF 16-bit compare of [D, E] and [H, L]
# 00BF
! 00BF Compare the higher bytes, D and H
! 00C1 Return if different
! 00C2 Compare the lower bytes, E and L

L 00C5 delay2047
L 00C9 delay2047Loop
# 00C5
# 00C5 Performs 2047 calls to delay1()
# 00C5 TODO: Actual duration in machine cycles / seconds?
# 00C5
! 00C5 Backup D
! 00C6 D := 2047
! 00CC --D
! 00CD A := High(D) | Low(D)
! 00CF Jump back if D != 0
! 00D2 Restore D

L 014A delay1
L 014D delay1Loop
# 014A
# 014A Performs 256 iterations of a 2x NOP loop
# 014A TODO: Actual duration in machine cycles / seconds?
# 014A
! 014A Backup D
! 014B D := 0
! 014D --D
! 014E 2x NO-OP
! 0150 Jump back if D != 0
! 0153 Restore D

L 0155 memHexCharToValue
# 0155
# 0155 Converts the '0'~'9', 'A'~'F' character at memory address D to a 00h~0Fh value.
# 0155 The result is stored in A. The CARRY flag is set in case of an error.
# 0155
! 0155 A := mem[D]

L 0174 monitor
# 0174
# 0174 Entry point for the IMKO-1 system monitor. 
# 0174 It allows for the execution of 26 predefined functions, by typing 'A' ~ 'Z'
# 0174
! 0174 Reset stack base at memory address 1470
! 0177 Display the function selection prompt (TODO)

L 0192 monitor2
# 0192
# 0192 Part II of the monitor
# 0192 
! 0192 TODO: PrintCRLF?
! 0195 TODO: Read a char in A?

L 0198 tableJmpA
# 0198
# 0198 Executes one of 26 routines, indexed by the letter in A: 'A' ~ 'Z'
# 0198
! 0198 Base address of the jump table
! 019B 'A' (41h) -> 00h
! 019D Negative value after the subtraction is an error
! 01A0 Compare A with 27 (1Bh)
! 01A2 Greater-than-or-equal is an error
! 01A5 (H, L) := (0, A)
! 01A8 (H, L) := (0, 2*A) - the table offset in bytes
! 01A9 Add the table base address. Now (H, L) points to the target routine's address
! 01AA Load the target address into (D, E)
! 01AD Swap HL <-> DE. Now the target address is in HL
! 01AE Push a default return address on the stack
! 01B2 PC := HL. Transfer the execution to the target routine

L 01B3 delay1402
L 01B7 delay1402loop
# 01B3
# 01B3 Performs mem[1402] iterations of an empty loop
# 01B3
! 01B3 Backup [H, L]
! 01B4 [H, L] := mem[1402]
! 01B7 Decrement [H, L]
! 01B8 A := H | L
! 01BA Jump back if [H, L] != 0x0000
! 01BD Restore [H, L]

L 01E2 toggleLetterCase
L 01F3 toLowerCase
# 01E2
# 01E2 Switches the case of the Latin letter character stored in A
# 01E2 A <-> a ... Z <-> z, all other characters remain unchanged
# 01E2
! 01E2 If ASCII code is less-than 0x41 ('A'), return unchanged
! 01E5 If code is less-than 0x5B ('['), i.e. an uppercase letter, convert to lowercase and return
! 01EA If ASCII code is less-than 0x61 ('a'), return unchanged
! 01ED If ASCII code is >= 0x7B ('{'), return unchanged
! 01F0 It's a lowercase letter. Convert to uppercase by subtracting 0x20
! 01F3 Convert to lowercase by adding 0x20

L 01F6 printMemString
# 01F6
# 01F6 Prompts for an address and displays the string located at it
# 01F6
! 01F6 Load the user-specified address in H
! 01F9 D := H, store a copy of the address in D

L 01FA printNLDString
# 01FA
# 01FA Prints a CR/LF on the monitor, followed by the string at the address in D
# 01FA
! 01FA Print the new-line

L 01FD printDString
! 01FD Load the current character in A
! 01FE Advance D to the next memory address
! 01FF Check A for end-of-string terminator char
! 0201 Return if done
! 0202 TODO
! 0205 Loop until the whole string has been processed

L 0208 promptStartReadH
# 0208
# 0208 TODO. Displays a 'START:' prompt, reads a line of input and converts it to an address, stored in H
# 0208
! 0208 Set the (address of the) prompt string in D: 'START:'

L 020B promptDReadH
! 020B Display the string, starting at the memory address in D

L 020E readAddrInH
! 020E Read a line from the keyboard
! 0211 Convert to an address

L 0219 printNL
# 0219
# 0219 Displays a CR/LF pair, i.e. moves to a new line
# 0219
! 0219 Backup A and D
! 021B Point D to the address of the CR/LF string
! 021E Display the string
! 0221 Restore A and D

L 0224 promptStartEnd
# 0224
# 0224 Prompts for input of a start and end addesses and stores them on the stack
# 0224 (&start is pushed first, &end is pushed second)
# 0224
! 0224 HL := &start, SP := &return
! 0227 HL := &return, SP := &start
! 0228 HL := &return, SP := &return, &start
! 0229 Set the prompt string to 'END:'
! 022C HL := &end, SP := &return, &start
! 022F HL := &return, SP := &end, &start
! 0230 PC := HL, return to the caller address

L 0275 promptByte
# 0275
# 0275 Displays a 'BYTE:' prompt and reads a line of input to memory address 1410h
# 0275
! 0275 Set D to the prompt string of 'BYTE:'

# 02AB
# 02AB Does something (output) first with the upper nibble of A, then with the lower nibble of A
# 02AB 

# 02B4
# 02B4 Converts the lower nibble of A from 0x00 ~ 0x0F to a '0' ~ 'F' ASCII char. 
# 02B4 The result remains in A.
# 02B4

L 02C2 write1410toUART
L 02CC write1410CRLoop
L 02D6 write1410StrLoop
# 02C2
# 02C2 Outputs to UART the 4-terminated string, located at memory address 1410
# 02C2 TODO: What's at 1410? Tape header? TODO: Name: write -> send?
# 02C2
! 02C2 TODO: What is this?
! 02C5 Wait for a while
! 02C8 B := 64
! 02CA Write 64 CR (0x0D) characters to UART
! 02D0 Jump back if more CR's need to be written
! 02D3 Set D to 1410
! 02D6 Load the byte at mem[D]
! 02D7 Send it to the UART
! 02DA ++D
! 02DB Was this the string terminator byte (0x04)?
! 02DD Jump back if not end-of-string

L 0322 writeProgToUART
L 032C writeProgLoop
# 0322
# 0322 Writes to UART the string at 1410 (TODO: some header?), followed by 
# 0322 the contents of the program located at memory address 1600
# 0322
! 0322 First write some header (TODO)
! 0325 Set the memory address to 1600
! 0328 (D, E) := (mem[1601], mem[1600]) - the address after the last byte of the program
! 032B H is back at 1600. The end-of-program address is stored together with the program itself
! 032C Load the current memory byte into A
! 032D Send it to UART
! 0330 Advance to the next memory address
! 0331 Compare the current memory address with the end-of-program address (in DE)
! 0334 Jump back if DE has not been reached
! 0337 Timed delay

! 033A TODO: Now what?

L 0365 readUARTSafe
# 0365
# 0365 Reads a single char from the UART into A. 
# 0365 In case of an error, returns the default value from C
# 0365
! 0365 Perform a plain read into A
! 0368 Backup A
! 0369 Read the UART status
! 036B AND with a mask for all the error bits
! 036D Restore A
! 036E Return if no error bits were set
! 036F Use the default, C, in case of an error
! 0370 Check for zero
! 0371 Display C, if non-zero
! 0374 TODO
! 0377 Set the default to be zero, for any further reads

L 037F memSet
L 038B memSetLoop
# 037F
# 037F Fills a block of memory with a given byte value
# 037F
! 037F Read &start and &end, place them on the stack
! 0382 Read and convert the fill-value in A
! 0388 D := &end
! 0389 H := &start
! 038A B := fill-value
! 038B Overwrite the current memory byte with the fill-value
! 038C TODO: Fall-through to the monitor, if D == H
! 038F ++H
! 0390 Jump back, until the whole memory block is overwritten

L 0398 string1410ToAddr
L 039B stringDToAddr
L 039F accumulateMemHex
# 0398
# 0398 Converts the sequence of hex characters at memory address 1410
# 0398 to a 16-bit address, stored in (H, L). '0FFF' -> 0FFFh
# 0398 The lower byte (L) is also stored in A
# 0398
! 0398 D := 1410h
! 039B A := 0, (H, L) := (0, 0), B := 0
! 039F Store the next hex digit in A
! 03A2 Also copy it to C
! 03A3 Store the last valid byte in A, in case of a return
! 03A4 Return in case of a conversion error or end-of-string
! 03A5 'Append' the next hex digit to (H, L)
! 03A6 (H, L) := 16 * (H, L) + (0, C)
! 03AA Advance to the next memory address
! 03AB Loop until the char->hex conversion fails

L 03F6 write80hToIO7
! 03F6 A := 80h

L 03F8 writeIO7
! 03F8 Send A to IO-7, store it at memory address 1470

L 03EF toggleIO7
# 03EF
# 03EF Toggles the output to IO-7 between 00h and 80h. 
# 03EF The new value is also stored at memory address 1470
# 03EF

L 0E13 memToRegisters
# 0E13
# 0E13 Loads the values stored at 1404h ~ 140Fh (see memory map) to the system registers
# 0E13
! 0E13 Set the stack pointer to the base of the registers' memory storage
! 0E16 Load the next two bytes into PSW:  PSW := PSW*, SP := 1406h
! 0E17 Load the next two bytes into B:  B := B*, SP := 1408h
! 0E18 Load the next two bytes into D:  D := D*, SP := 140Ah
! 0E19 Load the next two bytes into H:  H := H*, SP := 140Ch
! 0E1A Load the next two bytes into H:  H := SP*, SP := 140Eh
! 0E1B Copy H into SP:  H := SP*, SP := SP*
! 0E1C H := PC*, SP := SP*
! 0E1F Push H (PC*) on the stack, as a fake return address
! 0E20 H := H*
! 0E23 "Return" to the last address on the stack, i.e. PC := PC*

L 0E24 registersToMem
# 0E24
# 0E24 Stores the system registers in memory, at addresses 1404h ~ 140Fh (see memory map)
# 0E24 The values stored (PC and SP, in particular) are the ones *before* the call to RST2
# 0E24 
! 0E24 H* := H
! 0E27 H := PC-before-last-call (it was on the top of the stack)
! 0E28 PC* := PC-before-last-call
! 0E2B Backup (A, F)
! 0E2C H := SP + 2 = SP-before-last-call
! 0E30 SP* := SP-before-last-call
! 0E33 Restore (A, F)
! 0E34 Set the stack base at 140Ah. Pushes will overwrite D*, B* and PSW*
! 0E37 D* := D
! 0E38 B* := B
! 0E39 PSW* := PSW
! 0E3A Set the stack base at 1470h (the default address)
! 0E3D TODO: Print the registers?

L 0E51 hexCharToValue
# 0E51
# 0E51 Converts the '0'~'9', 'A'~'F' character in A to a 00h~0Fh value.
# 0E51 The CARRY flag is set in case of an error.
# 0E51
! 0E51 '0' (30h) -> 00h
! 0E53 If A originally had an ASCII below '0', return with the error flag set
! 0E54 Compare A with 10 (0Ah), i.e. originally ':'
! 0E56 If less-than, i.e. A was '0'~'9', invert the carry flag to indicate success and return
! 0E58 Compare A with 17 (11h), i.e. originally 'A'
! 0E5A If less-than, return with an error
! 0E5B Compare A with 23 (17h), i.e. originally 'G'
! 0E5D If greater-or-equal, invert the carry flag to indicate an error and return
! 0E5F The value in A is 17 ~ 22. Subtract 7 (07h) to bring it to 10 ~ 15 (0Ah ~ 0Fh)

L 0E62 readFromUART
# 0E62
# 0E62 Waits for "Data Available" (DAV) and reads the UART data byte to A (IO address 0x04)
# 0E62
! 0E62 Read UART status byte
! 0E64 Check for DAV flag
! 0E66 Jump back if DAV flag is not set
! 0E69 Read UART data byte

L 0E98 string1410ToByte
L 0E9B stringDToByte
# 0E98
# 0E98 Converts a line of input at 1410h to a byte value stored in A
# 0E98
! 0E98 Set the address of the keyboard buffer in D
! 0E9B Backup H and B
! 0E9D Perform the conversion
! 0EA0 Restore H and B. The 16-bit conversion result (in H) are discarded
! 0EA1 and only the LSB byte remains in A

L 0EA3 jumpToAddress
# 0EA3
# 0EA3 Prompts for input of an address and jumps there
# 0EA3
! 0EA3 Get the address
! 0EA6 PC := HL, jump to the address

L 0F0F invert1472
# 0F0F
# 0F0F Inverts the byte at memory address 1472
# 0F0F
! 0F0F Set address to 1472

L 0F15 invert1401
# 0F15
# 0F15 Inverts the byte at memory address 1401
# 0F15
! 0F15 Set address to 1401

L 0F18 invertMemByte
# 0F18
# 0F18 Inverts (performs a bitwise NOT) the byte at the current memory address
# 0F18
! 0F18 Load memory byte into A
! 0F19 Invert A
! 0F1A Write back to memory

;
; Text areas
;
T 037A-037E	; 'READ'
T 0E40-0E46	; 'MORE?'
T 0E47-0E4C	; '\nEND'
T 0E4D-0E50	; 'TO:'
T 0EC0-0EC7	; 'PROGRAM'
T 0EC8-0ED5	; 'HLDEBCASTART:'
T 0ED6-0EDC	; ' ERROR'
T 0EDD-0EFB	; 'FUNCTION? ENTER MONITOR OPTION'
T 0F02-0F0E	; 'FILES FOUND:'
T 0FB2-0FB7	; 'BYTE:'
T 0FB8-0FC9	; 'ITKROM V1.2 \n END:'
T 0FCA-0FCF	; 'PORT:'
T 0FD0-0FDC	; 'TAPE HEADER:'
T 0FDD-0FFB	; 'A  C  B  E  D  L  H  SP   PC \n'

;
; Forced code regions
;
C 009A
C 00BE
C 014F

;
; Forced binary word / address regions
;

B 0C00-0CA1
# 0C00
# 0C00 BASIC literals? TODO...
# 0C00

W 0D80-0D89
# 0D80
# 0D80 TODO
# 0D80

A 0F7E-0FB1
# 0F7E
# 0F7E Jump table with 26 Monitor functions, 'A' to 'Z'
# 0F7E

;
; Ignored regions
;
I 03FE-03FF	; Last two bytes from the first EPROM - two NOPs
I 0400-0BFF	; N/A EPROMs
I 0FFC-0FFF	; Last four bytes from the second EPROM
