    .section .text.init
    .globl _start
_start:
    # =========================================================
    # COMBINED SBST - Register File + Multiply/Divide Unit
    # Target: >90% FC for regfile and MDU in RV32E with M ext
    # =========================================================

    # =========================================================
    # PART 1: REGISTER FILE TESTS
    # =========================================================

    # ---------------------------------------------------------
    # Test 1: Walking 1s - Write each bit position
    # ---------------------------------------------------------
    # Bit 0-7
    li   x1, 0x00000001
    li   x2, 0x00000002
    li   x3, 0x00000004
    li   x4, 0x00000008
    li   x5, 0x00000010
    li   x6, 0x00000020
    li   x7, 0x00000040
    li   x8, 0x00000080
    add  x9, x1, x0
    add  x10, x2, x0
    add  x11, x3, x0
    add  x12, x4, x0
    add  x13, x5, x0
    add  x14, x6, x0
    add  x15, x7, x0

    # Bit 8-15
    li   x1, 0x00000100
    li   x2, 0x00000200
    li   x3, 0x00000400
    li   x4, 0x00000800
    li   x5, 0x00001000
    li   x6, 0x00002000
    li   x7, 0x00004000
    li   x8, 0x00008000
    add  x9, x1, x0
    add  x10, x2, x0

    # Bit 16-23
    li   x1, 0x00010000
    li   x2, 0x00020000
    li   x3, 0x00040000
    li   x4, 0x00080000
    li   x5, 0x00100000
    li   x6, 0x00200000
    li   x7, 0x00400000
    li   x8, 0x00800000

    # Bit 24-31
    li   x1, 0x01000000
    li   x2, 0x02000000
    li   x3, 0x04000000
    li   x4, 0x08000000
    li   x5, 0x10000000
    li   x6, 0x20000000
    li   x7, 0x40000000
    li   x8, 0x80000000

    # ---------------------------------------------------------
    # Test 2: Walking 0s
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFE
    li   x2, 0xFFFFFFFD
    li   x3, 0xFFFFFFFB
    li   x4, 0xFFFFFFF7
    li   x5, 0xFFFFFFEF
    li   x6, 0xFFFFFFDF
    li   x7, 0xFFFFFFBF
    li   x8, 0xFFFFFF7F

    li   x1, 0xFFFF7FFF
    li   x2, 0xFFFEFFFF
    li   x3, 0xFFFDFFFF
    li   x4, 0xFFFBFFFF
    li   x5, 0xFFF7FFFF
    li   x6, 0xFFEFFFFF
    li   x7, 0xFFDFFFFF
    li   x8, 0xFF7FFFFF

    # ---------------------------------------------------------
    # Test 3: Checkerboard patterns
    # ---------------------------------------------------------
    li   x1, 0x55555555
    li   x2, 0xAAAAAAAA
    li   x3, 0x55555555
    li   x4, 0xAAAAAAAA
    li   x5, 0x55555555
    li   x6, 0xAAAAAAAA
    li   x7, 0x55555555
    li   x8, 0xAAAAAAAA
    xor  x9, x1, x2
    xor  x10, x3, x4

    # ---------------------------------------------------------
    # Test 4: All 0s and All 1s
    # ---------------------------------------------------------
    li   x1, 0x00000000
    li   x2, 0x00000000
    li   x3, 0x00000000
    li   x4, 0x00000000
    li   x5, 0xFFFFFFFF
    li   x6, 0xFFFFFFFF
    li   x7, 0xFFFFFFFF
    li   x8, 0xFFFFFFFF

    # ---------------------------------------------------------
    # Test 5: Register-to-register moves
    # ---------------------------------------------------------
    li   x1, 0x11111111
    li   x2, 0x22222222
    add  x9, x1, x0
    add  x10, x0, x2
    add  x11, x1, x2
    sub  x12, x2, x1

    # =========================================================
    # PART 2: MULTIPLY/DIVIDE UNIT TESTS
    # =========================================================

    # ---------------------------------------------------------
    # Test M1: Basic MUL - Lower 32 bits of multiplication
    # ---------------------------------------------------------
    # Small values
    li   x1, 3
    li   x2, 7
    mul  x3, x1, x2       # 3 * 7 = 21

    li   x1, 10
    li   x2, 20
    mul  x3, x1, x2       # 10 * 20 = 200

    # Power of 2
    li   x1, 16
    li   x2, 8
    mul  x3, x1, x2       # 16 * 8 = 128

    # Walking 1s multiplication
    li   x1, 0x00000001
    li   x2, 0x00000001
    mul  x3, x1, x2
    li   x1, 0x00000002
    mul  x4, x1, x2
    li   x1, 0x00000004
    mul  x5, x1, x2
    li   x1, 0x00000008
    mul  x6, x1, x2
    li   x1, 0x80000000
    mul  x7, x1, x2

    # Large value multiplication
    li   x1, 0x12345678
    li   x2, 0x87654321
    mul  x3, x1, x2

    li   x1, 0xFFFFFFFF
    li   x2, 0xFFFFFFFF
    mul  x3, x1, x2

    # ---------------------------------------------------------
    # Test M2: MULH - Upper 32 bits (signed x signed)
    # ---------------------------------------------------------
    li   x1, 0x7FFFFFFF     # Max positive
    li   x2, 0x7FFFFFFF
    mulh x3, x1, x2

    li   x1, 0x80000000     # Min negative
    li   x2, 0x80000000
    mulh x4, x1, x2

    li   x1, 0x7FFFFFFF
    li   x2, 0x80000000
    mulh x5, x1, x2

    li   x1, 0xFFFFFFFF     # -1
    li   x2, 0xFFFFFFFF     # -1
    mulh x6, x1, x2

    # ---------------------------------------------------------
    # Test M3: MULHU - Upper 32 bits (unsigned x unsigned)
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFF
    li   x2, 0xFFFFFFFF
    mulhu x3, x1, x2

    li   x1, 0x80000000
    li   x2, 0x80000000
    mulhu x4, x1, x2

    li   x1, 0x12345678
    li   x2, 0xABCDEF01
    mulhu x5, x1, x2

    # ---------------------------------------------------------
    # Test M4: MULHSU - Upper 32 bits (signed x unsigned)
    # ---------------------------------------------------------
    li   x1, 0x7FFFFFFF     # Positive signed
    li   x2, 0xFFFFFFFF     # Large unsigned
    mulhsu x3, x1, x2

    li   x1, 0x80000000     # Negative signed
    li   x2, 0xFFFFFFFF
    mulhsu x4, x1, x2

    li   x1, 0xFFFFFFFF     # -1 signed
    li   x2, 0x00000002
    mulhsu x5, x1, x2

    # ---------------------------------------------------------
    # Test M5: DIV - Signed division
    # ---------------------------------------------------------
    li   x1, 100
    li   x2, 10
    div  x3, x1, x2        # 100 / 10 = 10

    li   x1, 100
    li   x2, 7
    div  x3, x1, x2        # 100 / 7 = 14

    li   x1, -100
    li   x2, 10
    div  x4, x1, x2        # -100 / 10 = -10

    li   x1, 100
    li   x2, -10
    div  x5, x1, x2        # 100 / -10 = -10

    li   x1, -100
    li   x2, -10
    div  x6, x1, x2        # -100 / -10 = 10

    # Division by zero (result should be -1)
    li   x1, 100
    li   x2, 0
    div  x7, x1, x2

    # Overflow case
    li   x1, 0x80000000    # MIN_INT
    li   x2, -1
    div  x8, x1, x2        # MIN_INT / -1 = MIN_INT (overflow)

    # ---------------------------------------------------------
    # Test M6: DIVU - Unsigned division
    # ---------------------------------------------------------
    li   x1, 100
    li   x2, 10
    divu x3, x1, x2        # 100 / 10 = 10

    li   x1, 0xFFFFFFFF
    li   x2, 2
    divu x4, x1, x2        # Max unsigned / 2

    li   x1, 0x80000000
    li   x2, 0x10000000
    divu x5, x1, x2

    # Division by zero (result should be max unsigned)
    li   x1, 100
    li   x2, 0
    divu x6, x1, x2

    # ---------------------------------------------------------
    # Test M7: REM - Signed remainder
    # ---------------------------------------------------------
    li   x1, 100
    li   x2, 7
    rem  x3, x1, x2        # 100 % 7 = 2

    li   x1, -100
    li   x2, 7
    rem  x4, x1, x2        # -100 % 7 = -2

    li   x1, 100
    li   x2, -7
    rem  x5, x1, x2        # 100 % -7 = 2

    li   x1, -100
    li   x2, -7
    rem  x6, x1, x2        # -100 % -7 = -2

    # Remainder by zero
    li   x1, 100
    li   x2, 0
    rem  x7, x1, x2

    # ---------------------------------------------------------
    # Test M8: REMU - Unsigned remainder
    # ---------------------------------------------------------
    li   x1, 100
    li   x2, 7
    remu x3, x1, x2        # 100 % 7 = 2

    li   x1, 0xFFFFFFFF
    li   x2, 0x10000000
    remu x4, x1, x2

    li   x1, 0x80000000
    li   x2, 3
    remu x5, x1, x2

    # Remainder by zero
    li   x1, 100
    li   x2, 0
    remu x6, x1, x2

    # ---------------------------------------------------------
    # Test M9: Bit pattern tests for MDU
    # ---------------------------------------------------------
    # Walking 1s through multiplier
    li   x1, 0x00000001
    li   x2, 0xFFFFFFFF
    mul  x3, x1, x2
    li   x1, 0x00000002
    mul  x4, x1, x2
    li   x1, 0x00000004
    mul  x5, x1, x2
    li   x1, 0x00000008
    mul  x6, x1, x2
    li   x1, 0x00000010
    mul  x7, x1, x2
    li   x1, 0x00000020
    mul  x8, x1, x2
    li   x1, 0x00000040
    mul  x9, x1, x2
    li   x1, 0x00000080
    mul  x10, x1, x2

    # Checkerboard multiplication
    li   x1, 0x55555555
    li   x2, 0xAAAAAAAA
    mul  x3, x1, x2
    mulh x4, x1, x2
    mulhu x5, x1, x2
    mulhsu x6, x1, x2

    # Large value division
    li   x1, 0x7FFFFFFF
    li   x2, 3
    div  x7, x1, x2
    divu x8, x1, x2
    rem  x9, x1, x2
    remu x10, x1, x2

    # ---------------------------------------------------------
    # Test M10: Sequential operations stress test
    # ---------------------------------------------------------
    li   x1, 12345
    li   x2, 67
    mul  x3, x1, x2
    div  x4, x3, x2
    rem  x5, x3, x2
    mul  x6, x4, x2
    add  x7, x6, x5        # Should equal x3

    # Mix of all MDU operations
    li   x1, 0xDEADBEEF
    li   x2, 0x12345678
    mul  x3, x1, x2
    mulh x4, x1, x2
    mulhu x5, x1, x2
    mulhsu x6, x1, x2
    div  x7, x1, x2
    divu x8, x1, x2
    rem  x9, x1, x2
    remu x10, x1, x2

    # ---------------------------------------------------------
    # SUCCESS
    # ---------------------------------------------------------
pass:
    j pass

fail:
    j fail

    .section .bss
    .align 4
stack:
    .space 256
stack_top:
