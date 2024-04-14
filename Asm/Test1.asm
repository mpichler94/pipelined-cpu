.org 0

; Test 8-bit register transfers

entry:
    nop         ; byte at 0x0000 should be a nop (0x00)
start:
    mvi a,1
    mov b,a
    mvi a,2
    mov b,a
    mvi a,4
    mov b,a
    mvi a,8
    mov b,a
    mvi a,16
    mov b,a
    mvi a,32
    mov b,a
    mvi a,64
    mov b,a
    mvi a,128
    mov b,a


end:
