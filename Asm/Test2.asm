.org 0

; Test ALU operations

entry:
    nop         ; byte at 0x0000 should be a nop (0x00)
start:
    mvi a,1
    mvi b,2
    add a,b
    add b,a
    add a,b
    shl a
    shr b
    sub a,b
    and a,b

    nop
    nop

    mvi a,5
    inc a
    dec a

    nop
    nop

    mvi b,5
    sub a,b
    dec a

end:
