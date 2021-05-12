
;Currently working on how to display the side numbers 5/3
;can i just put in a call to print a number before call sampletext




; EXTERNAL DEPENDENCIES
INCLUDE		Irvine32.inc
INCLUDELIB	Irvine32.lib

; EXECUTION MODE PARAMETERS
.386
.model flat, stdcall
.stack 4096
; PROTOTYPES
ExitProcess PROTO, dwExitCode:DWORD

; SYMBOLIC CONSTANTS
NUMBER_OF_COLORS =		16d

; DATA SEGMENT
.data
topRowNumbers				BYTE    "+0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +11 +12 +13 +14 +15", 0
foregroundColorCounter		BYTE	1
backgroundColorCounter		BYTE	2
;moreText					BYTE    "help", 0Dh, 0Ah, 0
NumberByte					byte	1,2,3
sampleText					BYTE	"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 0Dh, 0Ah, 0

; CODE SEGMENT
.code
; NOTE --------------------------------------------------------------------------------------------
; If you are acustom to programming in a C++ or Java environment, consider adopting the following
;  conventional pattern for structuring nested loops in Assembly.  The use of tabs to provide a
;  visual cue relating to how deep in the nested structure an instruction is can be very useful
;  for overall code readability.
; -------------------------------------------------------------------------------------------------
main PROC


;Loop Instructions module 8 may be of help in making the side row of numbers 5/2/21



	; Set up variables for OUTER loop.
	mov edx, offset topRowNumbers
	
	mov ECX, NUMBER_OF_COLORS
	;MOVZX EAX, [NumberBYTE + 1]		; 2
	;CALL WriteDec													;This will show a number in the first line seperate from the line of text and color 
	
	mov backgroundColorCounter, 1	
	;BACKGROUND COLOR CHANGE IS HERE
	backgroundLoop:
					
		; Set the background color in AL.
		movzx EAX, backgroundColorCounter
		
		; Shift the background color to the upper half of AL (where it belongs).
		shl EAX, 4				;dont change 5/1

		; Preserve ECX contents upon entering INNER loop.
		push ECX
		
		; Set up variables for INNER loop.
		mov ECX, NUMBER_OF_COLORS
		mov foregroundColorCounter, 0				;FOREGROUND COLOR CHANGE IS HERE
		
			
			call SetTextColor
		call PrintSampleText
		;call PrintMoreText

		
		;originally part of the code example i copied this outline from, may come back to later not sure 5/1
		;foregroundLoop:
			; Set the newly forged text color and display the sample message.


			; Move onto the next foreground color.
		;	inc AL
		;loop foregroundLoop
		
		; Restore the ECX contents to allow OUTER loop to continue flowing naturally.
		pop ECX

		; Move into the next background color.
		inc backgroundColorCounter
	loop backgroundLoop
	
	; Indicate normal termination to OS.
	call crlf
	call crlf
	call crlf
	invoke ExitProcess, 0
main ENDP

PrintSampleText PROC
	; This procedure uses EDX internally, so preverve it.
	push EDX
	
	; Write the text.
	mov EDX, OFFSET sampleText
	call WriteString

	; Restore EDX upon procedure completion.
	pop EDX
	ret
PrintSampleText ENDP
;PrintMoreText PROC
	; This procedure uses EDX internally, so preverve it.
	;push EDX
	
	; Write the text.
;	mov EDX, OFFSET moreText
	;call WriteString

	; Restore EDX upon procedure completion.
	;pop EDX
;	ret
;PrintMoreText ENDP

END main		; End of program OPCODES.