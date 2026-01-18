    .section .text.init
    .globl _start
_start:
    # Minimal SBST for MDU - quick termination
    
    # Base address for result storage
    li   x15, 0x80001000

    # MUL tests
    li   x1, 3
    li   x2, 7
    mul  x3, x1, x2
    sw   x3, 0(x15)

    li   x1, 0x12345678
    li   x2, 0x87654321
    mul  x3, x1, x2
    sw   x3, 4(x15)
    
    mulh x4, x1, x2
    sw   x4, 8(x15)
    
    mulhu x5, x1, x2
    sw   x5, 12(x15)

    # DIV tests
    li   x1, 100
    li   x2, 7
    div  x3, x1, x2
    sw   x3, 16(x15)
    
    divu x4, x1, x2
    sw   x4, 20(x15)
    
    rem  x5, x1, x2
    sw   x5, 24(x15)
    
    remu x6, x1, x2
    sw   x6, 28(x15)

    # Edge cases
    li   x1, -1
    li   x2, 2
    div  x3, x1, x2
    sw   x3, 32(x15)
    
    li   x1, 0x80000000
    li   x2, -1
    div  x3, x1, x2
    sw   x3, 36(x15)

    # Signature and terminate
    li   x1, 0x12345678
    sw   x1, 40(x15)
    
    # Write to trickbox to terminate simulation
    li   x1, 1
    li   x2, 0x80000000
    sw   x1, 0(x2)

    j    .
