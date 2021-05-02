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
NUMBER_OF_COLORS =		8d

; DATA SEGMENT
.data
foregroundColorCounter		BYTE	2
backgroundColorCounter		BYTE	2
sampleText					BYTE	"    jimmy was here whats good                                                                                             ", 0Dh, 0Ah, 0

; CODE SEGMENT
.code
; NOTE --------------------------------------------------------------------------------------------
; If you are acustom to programming in a C++ or Java environment, consider adopting the following
;  conventional pattern for structuring nested loops in Assembly.  The use of tabs to provide a
;  visual cue relating to how deep in the nested structure an instruction is can be very useful
;  for overall code readability.
; -------------------------------------------------------------------------------------------------
main PROC
	; Set up variables for OUTER loop.
	mov ECX, NUMBER_OF_COLORS
	mov backgroundColorCounter, 0
	backgroundLoop:
		; Set the background color in AL.
		movzx EAX, backgroundColorCounter
		
		; Shift the background color to the upper half of AL (where it belongs).
		shl EAX, 4

		; Preserve ECX contents upon entering INNER loop.
		push ECX
		
		; Set up variables for INNER loop.
		mov ECX, NUMBER_OF_COLORS
		mov foregroundColorCounter, 0
		foregroundLoop:
			; Set the newly forged text color and display the sample message.
			call SetTextColor
			call PrintSampleText

			; Move onto the next foreground color.
			inc AL
		loop foregroundLoop
		
		; Restore the ECX contents to allow OUTER loop to continue flowing naturally.
		pop ECX

		; Move into the next background color.
		inc backgroundColorCounter
	loop backgroundLoop
	
	; Indicate normal termination to OS.
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

END main		; End of program OPCODES.