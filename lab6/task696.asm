         ORG 0x000
V0:      WORD $DEFAULT, 0x180
V1:      WORD $DEFAULT, 0x180
V2:      WORD $INT2, 0x180
V3:      WORD $INT3, 0x180
V4:      WORD $DEFAULT, 0x180
V5:      WORD $DEFAULT, 0x180
V6:      WORD $DEFAULT, 0x180
V7:      WORD $DEFAULT, 0x180
DEFAULT: DI
         PUSH
         IN 0x0
         IN 0x4
         IN 0x6
         IN 0x8
         IN 0x18
         IN 0x1C
         CLA
         OUT 0x2
         OUT 0xC
         OUT 0x10
         OUT 0x14
         POP
         EI
         IRET
         ORG 0x020
START:   DI
         LD #0xA
         OUT 0x5
         LD #0xB
         OUT 0x7
         CLA
         OUT 0x1
         OUT 0x3
         OUT 0xB
         OUT 0xE
         OUT 0x12
         OUT 0x16
         OUT 0x1A
         OUT 0x1E
         JUMP $PROG
         ORG 0x030
ADDR_X: WORD 0x031
X:       WORD 0x0000
PROG:  EI
LD ADDR_X
PUSH
INCLP: CALL $ATOMIC_INC_BY_TWO
         JUMP INCLP
ORG 0x040
TEMP_ADDR: WORD ?
ATOMIC_INC_BY_TWO: DI
LD &1
ST TEMP_ADDR
LD (TEMP_ADDR)
INC
INC
CALL $AAV_CHECK
ST (TEMP_ADDR)
EI
RET
         ORG 0x050
INT2:  DI
         NOP
         PUSH
         IN 0x4
         SXTB
         NEG
         AND MASK
         ST $X
         POP
         NOP
         EI
         IRET
MASK: WORD 0x00FF
         ORG 0x060
INT3: DI
         NOP
         PUSH
         LD $X
         ASL
         ADD $X  
         SUB #5
         OUT 6
         POP
         NOP
         EI
         IRET
ORG 0x070
AAV_CHECK: CMP MAX_VAL
BGE RESET
CMP MIN_VAL
BGE AAV_RET
RESET: LD MIN_VAL
AAV_RET: RET
MIN_VAL: WORD 0xFFD5
MAX_VAL: WORD 0x002A

