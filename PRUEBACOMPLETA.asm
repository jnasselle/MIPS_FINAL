ADDI R5,R5,4
ADDI R4,R4,2
ADDI R6,R6,8
ADDI R7,R7,16
ADDI R8,R8,12
ADDI R9,R9,32
ADDI R10,R10,0
ADD R20,R5,R6
AND R21,R20,R8
BNE R7,R8,R4
LB R22,0(0)
OR R23,R5,R4
SLL R24,R5,2
SUB R25,R9,R7
XOR R26,R8,R6
ANDI R27,R9,32
SB R5,4(0)
LH R28,4(0)
HALT
 