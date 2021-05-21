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

counterBackGround	DB 0
counterForeGround	DB 0

Letter_X_Text	DB "XXXX",0
topText		DB "    +0  +1  +2  +3  +4  +5  +6  +7  +8  +9  +10 +11 +12 +13 +14 +15",0dh,0ah,0




; CODE SEGMENT
.code
main PROC
	MOV EDX, OFFSET topText		
	CALL WriteString				; Prints top text

	MOV ECX, 16						; Prime ecx for background color loop
	MOV EDX, OFFSET Letter_X_Text		; Prime EDX for printing

	backgroundLoop:

		MOVZX EAX, counterBackGround		; Move BackGround number to EAX
		CALL WriteDec				; Print ^

		PUSH ECX					; Preserve count for outside loop
		MOV ECX, 16					; Set number for inside loop
		foregroundLoop:
			
			MOVZX EAX, counterBackGround	; Move BackGround number to EAX
			SHl EAX, 4				; Move it to the right part
			MOV AL, counterForeGround		; Move the Foreground color into the right place
			CALL SetTextColor		; Change the color
			CALL WriteString		; Print
			INC counterForeGround			; Shift to next Foreground color
		
		LOOP foregroundLoop
		
		POP ECX						; Return to outside loop number
		ADD counterBackGround, 16			; Increment BackGround color
		MOV EAX, 7					
		CALL SetTextColor			; Set to default console color
		CALL Crlf

	LOOP backgroundLoop

	CALL Crlf
	CALL WaitMsg
	
	
	INVOKE ExitProcess, 0      ; Return
main ENDP

END main