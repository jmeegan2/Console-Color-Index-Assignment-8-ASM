; EXTERNAL DEPENDENCIES
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; EXECUTION MODE PARAMETERS
.386
.model flat, stdcall

.stack 4096

; PROTOTYPES
ExitProcess PROTO, dwExitCode:DWORD



; DATA SEGMENT
.data

Letter_X_Text	DB "XXXX",0
topText		DB "    +0  +1  +2  +3  +4  +5  +6  +7  +8  +9  +10 +11 +12 +13 +14 +15",0dh,0ah,0

counterBG	DB 0
counterFG	DB 0


; CODE SEGMENT
.code
main PROC
	MOV EDX, OFFSET topText		
	CALL WriteString				; Prints top text

	MOV ECX, 16						; Prime ecx for bg color loop
	MOV EDX, OFFSET Letter_X_Text		; Prime EDX for printing

	bgLoop:
		MOVZX EAX, counterBG		; Move BG number to EAX
		CALL WriteDec				; Print ^

		PUSH ECX					; Preserve count for outside loop
		MOV ECX, 16					; Set number for inside loop
		fgLoop:
			MOVZX EAX, counterBG	; Move BG number to EAX
			SHl EAX, 4				; Move it to the right part
			MOV AL, counterFG		; Move the FG color into the right place
			CALL SetTextColor		; Change the color
			CALL WriteString		; Print
			INC counterFG			; Shift to next FG color
		LOOP fgLoop
		POP ECX						; Return to outside loop number
		ADD counterBG, 16			; Increment BG color

		MOV EAX, 7					
		CALL SetTextColor			; Set to default console color
		CALL Crlf
	LOOP bgLoop

	CALL Crlf
	CALL WaitMsg
	INVOKE ExitProcess, 0      ; Return
main ENDP

END main