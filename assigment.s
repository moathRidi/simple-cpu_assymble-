   AREA RESET, DATA, READONLY

    EXPORT __Vectors

__Vectors DCD 0x20001000

                DCD Reset_Handler

               ALIGN

       AREA MYRAM, DATA, READWRITE

SUMS  DCD 0
EVENS DCD 0
ARR  DCD 0	

       AREA MYCODE, CODE, READONLY

        ENTRY
        EXPORT Reset_Handler

Reset_Handler
             LDR R4,=ARR
	         MOV R2,#10 ;R2 = 10 (decimal) for counter
EVEN         RN R9  ;R9 = 0 (even sum)
SUM          RN R0  ;R0 = 0 ( sum)
			 MOV EVEN ,#0
			 MOV SUM ,#0
             LDR R1, =My_Array; r1 pointing at the first of the array 
SumLoop	     LDR R5,[R1] ; load the amount of r1 to r5
             ADD SUM ,SUM,R5  ;add the first element to the sum
              
			 ;******************EVEN SUM*********************************;
			 MOV R8,#2
             UDIV    R6, R5, R8      ; div to get quotient
             MUL     R7, R6, R8      ; need for computing remainder
             SUBS    R3, R5, R7      ; the mod (remainder)	
			 BEQ evenSum ;findig the sum
			 B L2
			 ;*******************POW********************************;
L2			 MOV R6,#0
			 MOV R8,#0
 			 BL POW ; call pow function
             
		     STR R6,[R4]
			 ADD R4,R4,#4

			 ADD R1,R1,#4; increment the address by one		
	         SUBS R2,R2,#1 ;R2 = R2 - 1 and set the flags. Decrement counter
		     BNE SumLoop ;repeat until COUNT = 0 (when Z = 1)
			 LDR R11,=SUMS
			 LDR R12,=EVENS
			
			 STR R0,[R11] ; move the sum to r4 
			 STR R9,[R12]
here B here


evenSum 	ADD EVEN ,EVEN,R5  ;add the element to the sum
            B L2		; unconditinal branch

My_Array DCD 34,56,27,156,200,68,128,235,17,45

POW MOV R7,#0     ;set the counter =0
     MOV R8,#2
LX   MOV R10,R5   ;copy the regster to save the previous value
L3   MOVS R10,R10,LSR #1     ;1 bit shift reg
     BCC count               ;check if the curry is zero
     B xx                    ; if not then skip
count ADD R7,R7,#1   ;increment the counter 
     B L3            ; go back to check for mor zeros
 
xx   CMP R7,#0
     BLS one
     B mull
   
one  ADD R6,#1
     B return
 
mull MOV R6,#2
ss   SUBS R7,R7,#1
     BNE d
     B return

d    MUL R6,R6,R8
     B ss
 
 
 
return  BX  LR
        
 

    end