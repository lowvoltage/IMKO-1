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
! 0093 Display a new-page (clear screen)
! 0094 Display 'ITKROM V1.2' and report the max memory address
! 009A Jump to the monitor

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

L 00B1 terminateStrD
! 00B1 Display the value in A, the last char read
! 00B4 DE <-> HL
! 00B5 Overwrite the new-line (0Dh) with a space (20h)
! 00B7 Move to the next memory byte
! 00B8 4-terminate the string
! 00BA Reset any flags? TODO
! 00BB DE <-> HL

L 00BF cmpDH
# 00BF
# 00BF 16-bit compare of [D, E] and [H, L]
# 00BF
! 00BF Compare the higher bytes, D and H
! 00C1 Return if different
! 00C2 Compare the lower bytes, E and L

L 00C5 delay6s
L 00C9 delay6sLoop
# 00C5
# 00C5 Performs 2047 calls to delay3ms() for a total delay of ~6.1s
# 00C5
! 00C5 Backup D
! 00C6 D := 2047
! 00CC --D
! 00CD A := High(D) | Low(D)
! 00CF Jump back if D != 0
! 00D2 Restore D

L 00D4 printNewPage
# 00D4
# 00D4 Displays the new-page char, i.e. clears the screen
# 00D4
! 00D4 Backup the value in A
! 00D5 A := 0Ch, the new-page char
! 00D7 Display the value in A
! 00DA Restore the original value of A

L 00DC delay3Ams
# 00DC
# 00DC Executes delay3ms() A times, for a total delay of ~3*A ms
# 00DC
! 00DC Wait
! 00DF Decrement A
! 00E0 Jump back until A becomes zero
! 00E3 Restore the original value of A

L 014A delay3ms
# 014A
# 014A Performs 256 iterations of a 2x NOP loop
# 014A
# 014A Duration in cycles:
# 014A CALL + PUSH + MVI + 256 * (DCR + NOP + NOP + JNZ) + POP + RET =
# 014A = 17 + 11 + 7 + 256 * (5 + 4 + 4 + 10) + 10 + 10 = 5943
# 014A At 2MHz clock speed, this takes ~3ms at the caller
# 014A
! 014A Backup D
! 014B D := 0
L 014D delay3msNopLoop
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

L 015B monitorNLError
# 015B
# 015B Display a new-line, then ' ERROR', then fall-through to the Monitor routine
# 015B
! 015B Print a new-line
L 015E monitorError
! 015E Set D to the address of ' ERROR'
L 0161 monitorDMsg
! 0161 Display the message pointed by D
L 0164 monitorNoMsg
! 0164 A := 40h
! 0166 Output 40h to IO-7
! 0168 B := 38 (26h)
L 016A delay3B
! 016A Call delay3ms() B times in a loop. Total delay ~114ms
! 0171 A := 00h
! 0172 Output 00h to IO-7

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
# 01B3 With the default value of 753 (02F1h) in memory, the delay is ~9ms
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

L 0231 toMonitorIfDeqH
# 0231
# 0231 Compares D and H and "returns" to the monitor if they are equal
# 0231
! 0231 Compare
! 0234 Regular return, if not equal
! 0235 Jump to the monitor, if equal

L 0238 readKbdNonZero
# 0238
# 0238 TODO. Reads from the keyboard a single non-zero byte into A
# 0238
! 023B Loop back until a non-zero value is entered

L 023F printMemAddrValue
# 023F
# 023F Displays the current memory address (H, L),
# 023F followed by the value of the byte at this address
# 023F
! 023F Print (H, L) in hex

L 0242 printMemHexByte
! 0242 Load the current memory byte into A
! 0243 Display A in hex

L 0246 writeStrToMem
# 0246
# 0246 Inputs a 4-terminated string into a specified memory location
# 0246
! 0246 Prompt for and input the target memory address in H
! 0249 Set 04h as a terminator char
! 024B Input the string in memory
! 024E Display 'END:' and report the string's end address
L 0251 printDHexH
! 0251 Print the string pointed by D, followed by the value of HL

L 0254 printHexHL
! 0254 First print the upper byte, H
! 0258 then the lower byte, L (followed by a space)

L 0259 printHexByteSpace
! 0259 Display A as hex
! 025C Append a space

L 0261 inputToM
# 0261
# 0261 Read from keyboard and store the input in memory, until the char in B is entered
# 0261
! 0261 Read a char in A
! 0264 Store the char in memory
! 0265 Advance to the next memory byte
! 0266 Check for end-of-string
! 0267 Return if found
! 0268 Display the char
! 026B Check for backspace (08h)
! 0270 Handle backspace - reduce the memory address by two

L 0275 promptByte
# 0275
# 0275 Displays a 'BYTE:' prompt and reads a line of input to memory address 1410h
# 0275
! 0275 Set D to the prompt string of 'BYTE:'

L 027B readLineTo1410
# 027B
# 027B Prompts for keyboard input and stores it at memory address 1410h
# 027B
! 027B Prompt char? TODO
! 027D D := 1410h
L 0280 showPrompt
! 0280 Display the prompt char in A
! 0283 Return if... TODO
L 0286 readCharToD
! 0286 Input a single char from the keyboard, into A
L 0289 handleLastKbdChar
! 0289 Check for and handle backspace (08h)
! 028E Store the char into mem[D]
! 028F Check for a new-line (0Dh)
! 0291 Terminat the string and return
! 0294 Prevent buffer overrun (1410h~142Fh), by checking the lower byte of DE
! 0295 The last non-termination symbol can be stored at 142Eh (E == 2Eh)
! 0297 Keep overwriting the char at 142Eh with new input
! 029A Restore the value in A to be the last char read
! 029B Advance to the next byte in the memory buffer
L 029F backspaceRead
! 029F Prevent buffer underrun (1410h~142Fh), by checking the lower byte of DE
! 02A0 The first symbol is always at 1410h (E == 10h)
! 02A2 Overwrite the char at 1410h with new input
! 02A5 Not at 1410h yet, so execute the backspace - take a step back
! 02A6 A := 08h (backspace)

L 02AB printHexByte
# 02AB
# 02AB Displays the value in A as a pair of '0' ~ 'F' ASCII chars
# 02AB 
! 02AB Backup A
! 02AC Shift right four times, the upper nibble takes the place of the lower nibble
! 02AD and will be displayed first
! 02B3 Restore A, display the lower nibble


L 02B4 printHexNibble
# 02B4
# 02B4 Prints the lower nibble of A as a '0' ~ 'F' ASCII char
# 02B4
! 02B4 Set zeros for the upper nibble of A
! 02B6 00h -> '0' (30h)
! 02B8 Compare with ':' (3Ah)
! 02BA If A is smaller, i.e. '0'~'9', display it and return
! 02BD Shift A to the 'A'~'F' range
! 02BF Display & return

L 02C2 writeUARTHeader
L 02CC writeCRLoop
L 02D6 write1410StrLoop
# 02C2
# 02C2 Prompts for 'Tape Header', reads a string to 1410h  and writes it to UART
# 02C2
! 02C2 Read input to 1410h
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

L 02E1 findProgInUART
# 02E1
# 02E1 Inputs a target tape-header string and locates the program body with this header
# 02E1
! 02E1 Prompt for a header string, store it at 1410h
! 02E4 Display 'FILES FOUND:'. All skipped headers will be listed

L 02EA findNextHeader
! 02ED Set the current memory address to 1410h

L 02F0 findLeading0Ds
! 02F0 64 ODh chars are written before each header. Find at least 32 (20h)

L 02F2 skipLeading0D
! 02F2 Read a char from UART
! 02F5 Check for 0Dh
! 02F7 If not a 0Dh, restart the search
! 02FA It's a 0Dh, decrement the target count
! 02FB Jump back if any more 0Ds need to be found

L 02FE skip0Ds
! 02FE Skip any remaining 0Ds
! 0306 The next char of the UART header is in A. Display it
! 0309 Compare it with the target char at mem[H]
! 030A Jump if different
! 030D Advance to the next memory byte
! 030E Check A for an end-of-string
! 0310 Jump back if more chars from the tape-header need to match

L 0314 headerMismatch
! 0314 Check A for an end-of-string
! 0316 If the UART header is over (and is not the one requested), skip the whole program body
! 0319 Read and display any remaining chars from the UART header
! 031F Jump back unitl the current UART header ends

L 0322 writeProgToUART
L 032C writeProgLoop
# 0322
# 0322 Inputs a tape header string, writes it to UART, followed by 
# 0322 the contents of the program located at memory address 1600
# 0322
! 0322 Prompt for a header string, write it to UART
! 0325 Set the memory address to 1600
! 0328 (D, E) := (mem[1601], mem[1600]) - the address after the last byte of the program
! 032B H is back at 1600. The end-of-program address is stored together with the program itself
! 032C Load the current memory byte into A
! 032D Send it to UART
! 0330 Advance to the next memory address
! 0331 Compare the current memory address with the end-of-program address (in DE)
! 0334 Jump back if DE has not been reached
! 0337 Wait for a while

L 033A endUART
L 033D monitorEnd
! 033D Set D to the address of the '\nEND' string
! 0340 Display the string in D, then fall-through to the Monitor

L 0343 readProgFrmUART
# 0343
# 0343 Prompts for a tape-header name and loads the program with this name from UART to 1600h in memory
# 0343
! 0343 Locate the program start
! 0346 Set the current memory address to 1600h
! 0349 Set '?' (3Fh) as the default value for the readUARTSafe() calls
! 034B Read the first UART byte, store it in E and at mem[1600h]
! 0350 H := 1601h
! 0351 Read the second UART byte, store it in D and at mem[1601h]
! 0354 This way, the program's end address is in both DE and mem[1601h, 1600h]
! 0356 H := 1602h

L 0357 readProgByte
! 0357 Read a byte from UART
! 035A Store it at the current memory location
! 035B Advance to the next memory byte
! 035C Check if the end-address D has been reached
! 035F Jump back if not
! 0362 TODO

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

L 03AE delayVideoCtrl
# 03AE
# 03AE Executes a delay for the correct processing of the video-control code in A
# 03AE See the SFF96364 datasheet for timing details
# 03AE
! 03AE Backup the original value of A. Restored in delay3Ams()
! 03AF Clear the first nibble of A
! 03B1 Check for 0Ch - 'new page' / 'clear screen'
! 03B3 Delay for 44 * 3ms = 132ms, if the control code is 0Ch
! 03B8 Delay for 3 * 3ms = 9ms, for any other control code

L 03C4 printNLHexWord
# 03C4
# 03C4 Prints a new line, then the value of (H, L) as a four-char '0'~'F' string
# 03C4
! 03C7 Also returns

L 03CA memList
# 03CA
# 03CA Prints a memory dump, starting from a given address, listing each byte on a separate line
# 03CA
! 03CA Read the start address in H

L 03CD memListPage
! 03CD Display 15 lines per page

L 03CF memListLine
! 03CF Print the current memory address H and its contents
! 03D2 Advance to the next byte
! 03D4 Loop back if there are more lines to print in this page
! 03D7 Prompt for input: 'MORE?'
! 03DD Check for a 'Y'
! 03DF Print another page, if 'Y'
! 03E2 TODO. Pop the 0174h from the stack? It'll be pushed again later?
! 03E3 Use the entered value for the monitor jump-table 

L 03E6 readLoopUART
# 03E6
# 03E6 Infinite loop of reading a char from UART and then displaying it
# 03E6

L 03EF toggleIO7
# 03EF
# 03EF Toggles the output to IO-7 between 00h and 80h. 
# 03EF The new value is also stored at memory address 1470
# 03EF

L 03F6 write80hToIO7
! 03F6 A := 80h

L 03F8 writeIO7
! 03F8 Send A to IO-7, store it at memory address 1470

L 0CA2 memEdit
# 0CA2
# 0CA2 Displays and allows for modification of the memory contents, starting at a given address 
! 0CA2 Input the target starting address
L 0CA6 memEditNext
! 0CA6 Advance to the next byte in memory
L 0CA7 memEditCurrent
! 0CA7 Display the current address and its contents
! 0CAA D := 1410h, the start of the keyboard buffer
! 0CAD Read a single char from the keyboard into A
! 0CB0 Check for a new-line (0Dh)
! 0CB2 If equal, move to the next byte
! 0CB5 Check for '^' (5Eh)
! 0CB7 If equal, move to the previous byte
! 0CBA Store A at 1410h and read the rest of the input string
! 0CBD Backup F
! 0CBE Convert the input string to a byte
! 0CC1 Overwrite the current memory location with it
! 0CC2 Restore the original F
! 0CC3 Move to the next byte
L 0CC6 memEditPrev
! 0CC6 Move to the previous memory address

L 0CCA setMemRegisters
# 0CCA
# 0CCA Modifies the registers' in-memory storage values, 1404h ~ 140Fh
# 0CCA This subroutine does not alter the registers' own values! This is done in memToRegisters().
# 0CCA
! 0CCA Input a letter into A TODO: No prompt?
! 0CD0 Compare A with ' ' (20h)
! 0CD2 If equal, display current memory values and return
! 0CD5 Compare A with 'F' (46h)
! 0CD7 If equal, modify the F memory byte and return
! 0CDA Position H to the start of the 'HLDEBCA' sequence
! 0CDD B := 0, C := 7 - the number of register names to check

L 0CE0 checkRegName
! 0CE0 Compare A with the current memory byte / register name
! 0CE1 If equal, modify a single register memory byte (A ~ H) and return
! 0CE4 Advance H to the next register name char
! 0CE5 Decrement the C counter
! 0CE9 Set H to the base of the SP memory word
! 0CEC Compare A with 'S' (53h)
! 0CEE If equal, modify the SP memory word (currently pointed by H)
! 0CF1 Compare A with 'P' (50h)
! 0CF3 If not equal, it's an error
! 0CF6 Advance H to the memory word for the PC register

L 0CF8 setRegisterWord
! 0CF8 Store the current memory word in DE
! 0CFC DE <-> HL, the current value is now in HL, current mem address is in DE
! 0CFD Backup the current memory address DE
! 0CFE Display the current register value HL
! 0D01 Read a new-value word in H
! 0D04 Restore the current memory address in DE
! 0D05 DE <-> HL, the new-value is now in DE, the current mem address is in HL
! 0D06 Store the new-value word (in DE) in memory

L 0D0A setRegisterByte
! 0D0A Set H to before the start of the A ~ H memory region
! 0D0D HL := HL + BC. Add the offset for the matched register name
! 0D0E Display the current register value
! 0D11 Read a new-value string
! 0D14 Convert the new-value string to a byte in A
! 0D17 Store the new-value byte in memory

L 0D19 setFlags
! 0D19 Display the currently set flags
! 0D1C Read a string to 1410h
! 0D1F Set D to the start of the input string
! 0D22 C := 0, will accumulate the new value for the F register

L 0D24 setSingleFlag
! 0D24 A := mem[D], the current char from the input string
! 0D25 Position H to the base of the 'Flag Char' <-> 'BitMask' array
! 0D28 B := 5, the number of flag-chars to check

L 0D2A checkFlagName
! 0D2A Compare the current input char A with the current 'Flag Char' in mem[H]
! 0D2B Always move H to the next byte, which is the bitmask
! 0D2C If equal, set the flag's bit (to 1)
! 0D2F Not equal. Move H to the next byte, the next 'Flag Char'
! 0D30 Decrement B, the number of remaining flag-chars to check
! 0D31 Loop back if B is non-zero
! 0D34 The current input char A is not a 'Flag Char'. A := the new flags byte
! 0D35 mem[1404h] := A, store the new-value byte in memory

L 0D39 setFlagBit
! 0D39 A := C, the current flags byte
! 0D3A OR with the bit-mask at mem[H]
! 0D3B Store the updated flags byte back into C
! 0D3C Move to and process the next byte of keyboard input

L 0D40 printRegisters
# 0D40
# 0D40 Displays the values of the system registers, as stored in memory (at 1404h ~ 140Fh)
# 0D40
! 0D40 Print the register names' header
! 0D46 Set the current memory address at 1405h
! 0D49 Iterate the seven single-byte registers: A, C, B, E, D, L and H

L 0D4B printRegH
! 0D4B Load the current memory byte in A and display it
! 0D4F Advance to the next memory byte, decrement the loop counter
! 0D51 Jump back if there are more single-byte registers to print
! 0D54 HL := mem[140C] - load and display the 16-bit value for SP
! 0D5A HL := mem[140E] - load and display the 16-bit value for PC
! 0D60 Display the status flags

L 0D66 printFlagsReg
# 0D66
# 0D66 Displays the F-registers flags, which are currently set (as stored in memory, at 1404h)
# 0D66 These are the 'S', 'Z', 'A', 'P' and 'C' flags
# 0D66
! 0D66 Set the memory address to the start of the flags-to-bit array
! 0D69 Five flags to check

L 0D6B printFlag
! 0D6B Load the whole status register in A
! 0D6E AND with the bitmask for the current flag
! 0D6F Display the flag, if its bit was set
! 0D72 Advance to the memory location for the next flag
! 0D75 Jump back, until all flags have been processed

L 0D79 printFlagName
# 0D79
# 0D79 Displays the name of the status flag, whose bit-mask is currently being pointed-at by H
# 0D79 
! 0D79 The flag name is in the previous byte
! 0D7A Load the flag name into A and display it
! 0D7E Restore H to its original value

L 0D8A memFind
# 0D8A
# 0D8A Finds all ocurrencies of a byte sequence in a given memory range.
# 0D8A The search sequence is entered as a comma-sequence of hex pairs, stored at 1410h.
# 0D8A Then this sequence is converted to bytes, stored again at 1410h.
# 0D8A
! 0D8A Input start and end address, place them on the stack
! 0D8D Input a comma-separated list of bytes to search for. Stored at 1410h
! 0D90 H := 1410h, the address of the keyboard input buffer
! 0D93 D := 1410h
! 0D95 C := 00h - counter for the search byte-sequence length

L 0D97 commaListToBytes
! 0D97 Convert the current pair of hex chars to a byte in A
! 0D9A Store it at mem[H]
! 0D9B ++H - position it at the next byte of the search sequnce
! 0D9C A := mem[D], the latest char of the input string
! 0D9D ++D - move to the next char of the input string
! 0D9E ++C - keep the sequence-length updated
! 0D9F Check A for ',' (2Ch) - the list separator
! 0DA1 Loop back, if there is another byte listed
! 0DA4 H := &end
! 0DA5 H := &start. &end goes to the top of the stack
! 0DA6 Reset the output items counter

L 0DA9 findAtH
! 0DA9 Set D to the start of the search-sequence
! 0DAC B := number-of-bytes-to-search-for

L 0DAD matchDH
! 0DAD Load the next target byte into A
! 0DAE Compare with the current mem[H]
! 0DAF Abort the comparison, in case of a mismatch
! 0DB2 Increment both H (memory) and D (target)
! 0DB4 Decrement B, number of remaining bytes to find
! 0DB5 Loop back if there are more bytes to find
! 0DB8 Match found. Adjust H to the start of the sequence
! 0DB9 HL := HL - 0C  (B is zero)
! 0DBE Display the match address
! 0DC1 Decrement the output items counter

L 0DC4 findAtNextH
! 0DC4 DE <-> HL. D := current memory address
! 0DC5 mem[SP] <-> HL. H := &end
! 0DC6 "Return" if &current == &end
! 0DC9 Restore the original values. H := current memory address
! 0DCB Advance to the next memory address
! 0DCC Test for a match at the new address

L 0DCF dcr1471
# 0DCF
# 0DCF Up to 12 five-byte 'XXXX ' addresses can be displayed on a single line.
# 0DCF mem[1471h] contains the number of available slots, on the current display line.
# 0DCF When this counter reaches zero, a new-line is displayed and the counter restarted
# 0DCF
! 0DCF Decrement mem[1471h]. A := mem[1471h]
! 0DD2 --A
! 0DD3 mem[1471h] := A
! 0DD6 Return if A is non-zero. Otherwise, reset to 0Ch

L 0DD7 reset1471
! 0DD7 mem[1471h] := 0Ch
! 0DDC Print a new-line and return

L 0DDF memCopy
# 0DDF
# 0DDF Copies a memory block from one location to another
# 0DDF To avoid corruption, data is copied forward if &start > &to and backward if &start < &to
# 0DDF
! 0DDF Read start & end addresses, put them on the stack
! 0DE2 Prompt 'TO:' and read the destination address
! 0DE5 H := &to
! 0DE8 B := &end
! 0DE9 D := &start
! 0DEA Compare &to and &start. Return if equal
! 0DED Swap B and H. H := &end, B := &to
! 0DF1 Copy memory backwards

L 0DF4 memCopyForward
! 0DF4 mem[B] := mem[D]
! 0DF6 Compare the 'current-from' D with &end H. Return if equal
! 0DF9 Increment both 'current-from' D and 'current-to' B

L 0DFE setBDestEnd
# 0DFE Memory will be copied backwards. Change B from 'destination-start' to 'destination-end'
! 0DFE Backup H
! 0DFF H := (H - D) = (&end - &start), the legth of the copied block
! 0E05 H += B, i.e. H := &to + (&end - &start)
! 0E06 B := H, i.e. B := &to + (&end - &start)
! 0E08 Restore the original value of H

L 0E09 memCopyBackward
! 0E09 mem[B] := mem[H]
! 0E0B Compare the 'current-from' H with &start D. Return if equal
! 0E0E Decrement both 'current-from' H and 'current-to' B

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

L 0E6C promptTapeHeader
# 0E6C
# 0E6C Displays a 'TAPE HEADER:' prompt and reads input to the 1410h memory buffer
# 0E6C
! 0E6F Display the 'TAPE HEADER:' prompt
! 0E75 Read the keyboard input
! 0E78 Also returns

L 0E7B monitorReadError
# 0E7B
# 0E7B Display 'READ ERROR' and fall-through to the Monitor
# 0E7B
! 0E7B Set D to the address of the 'READ' string

L 0E7E monitorDError
! 0E7E Print a new-line and the string in D
! 0E81 Display ' ERROR' and go to monitor

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

L 0EA7 memDump
# 0EA7
# 0EA7 Prints a hex dump of a memory region. 
# 0EA7 Each line starts with a memory address, followed by (up to) 16 bytes of memory data
# 0EA7
! 0EA7 Read start & end addresses, put them on the stack
! 0EAA D := &end
! 0EAB H := &start
L 0EAC memDumpAddress
! 0EAC Print a new-line and the current memory address
L 0EAF memDumpByte
! 0EAF Print the current memory byte
! 0EB2 If D == H, jump to monitor
! 0EB5 Advance to the next memory address
! 0EB6 Check if the new address ends in a zero nibble
! 0EB9 If not, continue with the byte-dumps
! 0EBC If yes, start a new line of print

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

L 0F72 monitorProgError
# 0F72
# 0F72 Display 'PROGRAM ERROR' and fall-through to the Monitor
# 0F72
! 0F72 Set D to the address of the 'PROGRAM' string
! 0F75 Print a new-line, the string in D, ' ERROR' and go to monitor

L 0F78 readLoopKBD
# 0F78
# 0F78 Infinite loop of reading a char from the keyboard and then displaying it
# 0F78

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
