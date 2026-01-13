    .section .text.init
    .globl _start
_start:
    # =========================================================
    # REGISTER FILE SBST - Comprehensive Test
    # Target: >90% FC for regfile in RV32E (16 registers x0-x15)
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
    # Verify by reading back
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
    add  x11, x3, x0
    add  x12, x4, x0
    add  x13, x5, x0
    add  x14, x6, x0
    add  x15, x7, x0

    # Bit 16-23
    li   x1, 0x00010000
    li   x2, 0x00020000
    li   x3, 0x00040000
    li   x4, 0x00080000
    li   x5, 0x00100000
    li   x6, 0x00200000
    li   x7, 0x00400000
    li   x8, 0x00800000
    add  x9, x1, x0
    add  x10, x2, x0
    add  x11, x3, x0
    add  x12, x4, x0
    add  x13, x5, x0
    add  x14, x6, x0
    add  x15, x7, x0

    # Bit 24-31
    li   x1, 0x01000000
    li   x2, 0x02000000
    li   x3, 0x04000000
    li   x4, 0x08000000
    li   x5, 0x10000000
    li   x6, 0x20000000
    li   x7, 0x40000000
    li   x8, 0x80000000
    add  x9, x1, x0
    add  x10, x2, x0
    add  x11, x3, x0
    add  x12, x4, x0
    add  x13, x5, x0
    add  x14, x6, x0
    add  x15, x7, x0

    # ---------------------------------------------------------
    # Test 2: Walking 0s - Write inverted bit positions
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFE
    li   x2, 0xFFFFFFFD
    li   x3, 0xFFFFFFFB
    li   x4, 0xFFFFFFF7
    li   x5, 0xFFFFFFEF
    li   x6, 0xFFFFFFDF
    li   x7, 0xFFFFFFBF
    li   x8, 0xFFFFFF7F
    li   x9, 0xFFFFFEFF
    li   x10, 0xFFFFFDFF
    li   x11, 0xFFFFFBFF
    li   x12, 0xFFFFF7FF
    li   x13, 0xFFFFEFFF
    li   x14, 0xFFFFDFFF
    li   x15, 0xFFFFBFFF

    # Read all back
    add  x1, x1, x0
    add  x2, x2, x0
    add  x3, x3, x0
    add  x4, x4, x0
    add  x5, x5, x0
    add  x6, x6, x0
    add  x7, x7, x0
    add  x8, x8, x0

    li   x1, 0xFFFF7FFF
    li   x2, 0xFFFEFFFF
    li   x3, 0xFFFDFFFF
    li   x4, 0xFFFBFFFF
    li   x5, 0xFFF7FFFF
    li   x6, 0xFFEFFFFF
    li   x7, 0xFFDFFFFF
    li   x8, 0xFFBFFFFF
    li   x9, 0xFF7FFFFF
    li   x10, 0xFEFFFFFF
    li   x11, 0xFDFFFFFF
    li   x12, 0xFBFFFFFF
    li   x13, 0xF7FFFFFF
    li   x14, 0xEFFFFFFF
    li   x15, 0xDFFFFFFF

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
    li   x9, 0x55555555
    li   x10, 0xAAAAAAAA
    li   x11, 0x55555555
    li   x12, 0xAAAAAAAA
    li   x13, 0x55555555
    li   x14, 0xAAAAAAAA
    li   x15, 0x55555555

    # Verify with XOR (should give 0xFFFFFFFF)
    xor  x1, x1, x2
    xor  x3, x3, x4
    xor  x5, x5, x6
    xor  x7, x7, x8

    # ---------------------------------------------------------
    # Test 4: All 0s and All 1s
    # ---------------------------------------------------------
    li   x1, 0x00000000
    li   x2, 0x00000000
    li   x3, 0x00000000
    li   x4, 0x00000000
    li   x5, 0x00000000
    li   x6, 0x00000000
    li   x7, 0x00000000
    li   x8, 0x00000000
    li   x9, 0x00000000
    li   x10, 0x00000000
    li   x11, 0x00000000
    li   x12, 0x00000000
    li   x13, 0x00000000
    li   x14, 0x00000000
    li   x15, 0x00000000

    li   x1, 0xFFFFFFFF
    li   x2, 0xFFFFFFFF
    li   x3, 0xFFFFFFFF
    li   x4, 0xFFFFFFFF
    li   x5, 0xFFFFFFFF
    li   x6, 0xFFFFFFFF
    li   x7, 0xFFFFFFFF
    li   x8, 0xFFFFFFFF
    li   x9, 0xFFFFFFFF
    li   x10, 0xFFFFFFFF
    li   x11, 0xFFFFFFFF
    li   x12, 0xFFFFFFFF
    li   x13, 0xFFFFFFFF
    li   x14, 0xFFFFFFFF
    li   x15, 0xFFFFFFFF

    # ---------------------------------------------------------
    # Test 5: Register-to-register moves (test read ports)
    # ---------------------------------------------------------
    li   x1, 0x11111111
    li   x2, 0x22222222
    li   x3, 0x33333333
    li   x4, 0x44444444
    li   x5, 0x55555555
    li   x6, 0x66666666
    li   x7, 0x77777777
    li   x8, 0x88888888

    # Move between all register pairs (rs1 port test)
    add  x9, x1, x0
    add  x10, x2, x0
    add  x11, x3, x0
    add  x12, x4, x0
    add  x13, x5, x0
    add  x14, x6, x0
    add  x15, x7, x0

    # Use rs2 port
    add  x9, x0, x1
    add  x10, x0, x2
    add  x11, x0, x3
    add  x12, x0, x4
    add  x13, x0, x5
    add  x14, x0, x6
    add  x15, x0, x7

    # ---------------------------------------------------------
    # Test 6: Two-operand operations (both read ports)
    # ---------------------------------------------------------
    li   x1, 0x0F0F0F0F
    li   x2, 0xF0F0F0F0
    li   x3, 0x00FF00FF
    li   x4, 0xFF00FF00

    add  x5, x1, x2
    add  x6, x3, x4
    sub  x7, x5, x1
    sub  x8, x6, x3
    and  x9, x1, x2
    or   x10, x1, x2
    xor  x11, x3, x4
    
    add  x12, x1, x3
    add  x13, x2, x4
    sub  x14, x1, x4
    sub  x15, x2, x3

    # ---------------------------------------------------------
    # Test 7: Byte patterns
    # ---------------------------------------------------------
    li   x1, 0x000000FF
    li   x2, 0x0000FF00
    li   x3, 0x00FF0000
    li   x4, 0xFF000000
    li   x5, 0x0000FFFF
    li   x6, 0xFFFF0000
    li   x7, 0x00FFFF00
    li   x8, 0xFF0000FF

    or   x9, x1, x2
    or   x10, x3, x4
    or   x11, x9, x10

    # ---------------------------------------------------------
    # Test 8: Sequential values
    # ---------------------------------------------------------
    li   x1, 0x01234567
    li   x2, 0x89ABCDEF
    li   x3, 0xFEDCBA98
    li   x4, 0x76543210
    li   x5, 0x13579BDF
    li   x6, 0x2468ACE0
    li   x7, 0xDB97531F
    li   x8, 0xCA864200

    add  x9, x1, x2
    add  x10, x3, x4
    add  x11, x5, x6
    add  x12, x7, x8
    xor  x13, x9, x10
    xor  x14, x11, x12
    xor  x15, x13, x14

    # ---------------------------------------------------------
    # Test 9: Write-after-Write (WAW) test
    # ---------------------------------------------------------
    li   x1, 0xAAAAAAAA
    li   x1, 0x55555555
    li   x1, 0x12345678
    add  x2, x1, x0

    li   x3, 0x11111111
    li   x3, 0x22222222
    li   x3, 0x33333333
    add  x4, x3, x0

    # ---------------------------------------------------------
    # Test 10: Read-after-Write (RAW) hazard
    # ---------------------------------------------------------
    li   x1, 0xDEADBEEF
    add  x2, x1, x0
    add  x3, x2, x0
    add  x4, x3, x0
    add  x5, x4, x0
    add  x6, x5, x0
    add  x7, x6, x0
    add  x8, x7, x0

    # ---------------------------------------------------------
    # Test 11: All registers different values (address decode)
    # ---------------------------------------------------------
    li   x1, 0x00000001
    li   x2, 0x00000002
    li   x3, 0x00000003
    li   x4, 0x00000004
    li   x5, 0x00000005
    li   x6, 0x00000006
    li   x7, 0x00000007
    li   x8, 0x00000008
    li   x9, 0x00000009
    li   x10, 0x0000000A
    li   x11, 0x0000000B
    li   x12, 0x0000000C
    li   x13, 0x0000000D
    li   x14, 0x0000000E
    li   x15, 0x0000000F

    # Sum all to verify
    add  x1, x1, x2
    add  x1, x1, x3
    add  x1, x1, x4
    add  x1, x1, x5
    add  x1, x1, x6
    add  x1, x1, x7
    add  x1, x1, x8
    add  x1, x1, x9
    add  x1, x1, x10
    add  x1, x1, x11
    add  x1, x1, x12
    add  x1, x1, x13
    add  x1, x1, x14
    add  x1, x1, x15

    # ---------------------------------------------------------
    # Test 12: x0 always zero test
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFF
    add  x0, x1, x1
    add  x2, x0, x0
    
    # x2 should be 0
    bnez x2, fail

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
