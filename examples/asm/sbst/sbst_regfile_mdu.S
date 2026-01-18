.section .text.init
.globl _start
_start:
    # =========================================================
    # SETUP - Use fixed address for observability
    # =========================================================
    # Use 0x80000000 as base (typical RAM base, works in Wally)
    li x10, 0x80000000
    
    # =========================================================
    # PART 1: REGISTER FILE TEST (from your 48% coverage test)
    # =========================================================
    
    # ---------------------------------------------------------
    # 1. ALL REGISTERS = 0x00000000
    # ---------------------------------------------------------
    li   x1, 0
    li   x2, 0
    li   x3, 0
    li   x4, 0
    li   x5, 0
    li   x6, 0
    li   x7, 0
    li   x8, 0
    li   x9, 0
    li   x11, 0
    li   x12, 0
    li   x13, 0
    li   x14, 0
    li   x15, 0

    # Store zeros (creates many observable writes)
    sw   x1, 0(x10)
    sw   x2, 4(x10)
    sw   x3, 8(x10)
    sw   x4, 12(x10)
    sw   x5, 16(x10)
    sw   x6, 20(x10)
    sw   x7, 24(x10)
    sw   x8, 28(x10)
    sw   x9, 32(x10)
    sw   x11, 36(x10)
    sw   x12, 40(x10)
    sw   x13, 44(x10)
    sw   x14, 48(x10)
    sw   x15, 52(x10)

    # ---------------------------------------------------------
    # 2. ALL REGISTERS = 0xFFFFFFFF
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFF
    li   x2, 0xFFFFFFFF
    li   x3, 0xFFFFFFFF
    li   x4, 0xFFFFFFFF
    li   x5, 0xFFFFFFFF
    li   x6, 0xFFFFFFFF
    li   x7, 0xFFFFFFFF
    li   x8, 0xFFFFFFFF
    li   x9, 0xFFFFFFFF
    li   x11, 0xFFFFFFFF
    li   x12, 0xFFFFFFFF
    li   x13, 0xFFFFFFFF
    li   x14, 0xFFFFFFFF
    li   x15, 0xFFFFFFFF

    sw   x1, 56(x10)
    sw   x2, 60(x10)
    sw   x3, 64(x10)
    sw   x4, 68(x10)
    sw   x5, 72(x10)
    sw   x6, 76(x10)
    sw   x7, 80(x10)
    sw   x8, 84(x10)
    sw   x9, 88(x10)
    sw   x11, 92(x10)
    sw   x12, 96(x10)
    sw   x13, 100(x10)
    sw   x14, 104(x10)
    sw   x15, 108(x10)

    # ---------------------------------------------------------
    # 3. KEY PATTERNS (most important from walking 1s/0s)
    # ---------------------------------------------------------
    # Walking 1s - just key positions to save space
    li   x1, 0x00000001
    li   x2, 0x00000002
    li   x3, 0x00000004
    li   x4, 0x00000008
    li   x5, 0x00000010
    li   x6, 0x00000020
    li   x7, 0x00000040
    li   x8, 0x00000080
    
    sw   x1, 112(x10)
    sw   x2, 116(x10)
    sw   x3, 120(x10)
    sw   x4, 124(x10)
    sw   x5, 128(x10)
    sw   x6, 132(x10)
    sw   x7, 136(x10)
    sw   x8, 140(x10)
    
    # High bits
    li   x9, 0x80000000
    li   x11, 0x40000000
    li   x12, 0x20000000
    li   x13, 0x10000000
    
    sw   x9, 144(x10)
    sw   x11, 148(x10)
    sw   x12, 152(x10)
    sw   x13, 156(x10)

    # ---------------------------------------------------------
    # 4. CHECKERBOARD PATTERNS
    # ---------------------------------------------------------
    li   x1, 0x55555555
    li   x2, 0xAAAAAAAA
    li   x3, 0x33333333
    li   x4, 0xCCCCCCCC
    
    sw   x1, 160(x10)
    sw   x2, 164(x10)
    sw   x3, 168(x10)
    sw   x4, 172(x10)

    # ---------------------------------------------------------
    # 5. REGISTER ADDRESSING TEST (unique values)
    # ---------------------------------------------------------
    li   x1, 0x11111111
    li   x2, 0x22222222
    li   x3, 0x33333333
    li   x4, 0x44444444
    li   x5, 0x55555555
    
    sw   x1, 176(x10)
    sw   x2, 180(x10)
    sw   x3, 184(x10)
    sw   x4, 188(x10)
    sw   x5, 192(x10)

    # ---------------------------------------------------------
    # 6. READ PORT TEST
    # ---------------------------------------------------------
    add  x6, x1, x2      # 0x11111111 + 0x22222222 = 0x33333333
    sub  x7, x3, x1      # 0x33333333 - 0x11111111 = 0x22222222
    and  x8, x1, x2      # 0x11111111 & 0x22222222 = 0x00000000
    or   x9, x1, x2      # 0x11111111 | 0x22222222 = 0x33333333
    
    sw   x6, 196(x10)
    sw   x7, 200(x10)
    sw   x8, 204(x10)
    sw   x9, 208(x10)

    # =========================================================
    # PART 2: MUL/DIV TEST (from your 28% coverage test)
    # =========================================================
    
    # ---------------------------------------------------------
    # 7. MUL family
    # ---------------------------------------------------------
    li   x1, 6
    li   x2, 7
    mul  x3, x1, x2      # 42
    sw   x3, 212(x10)
    
    # Verify with load+branch (creates observability)
    lw   x4, 212(x10)
    li   x5, 42
    bne  x4, x5, test_fail
    
    li   x1, 0x12345678
    li   x2, 0x9ABCDEF0
    mulh x3, x1, x2
    sw   x3, 216(x10)
    
    mulhu x3, x1, x2
    sw   x3, 220(x10)
    
    mulhsu x3, x1, x2
    sw   x3, 224(x10)
    
    # ---------------------------------------------------------
    # 8. DIV family
    # ---------------------------------------------------------
    li   x1, 1000
    li   x2, 17
    div  x3, x1, x2      # 58
    sw   x3, 228(x10)
    
    lw   x4, 228(x10)
    li   x5, 58
    bne  x4, x5, test_fail
    
    divu x3, x1, x2      # Also 58
    sw   x3, 232(x10)
    
    lw   x4, 232(x10)
    bne  x4, x5, test_fail
    
    rem  x3, x1, x2      # 1000 % 17 = 14
    sw   x3, 236(x10)
    
    lw   x4, 236(x10)
    li   x5, 14
    bne  x4, x5, test_fail
    
    remu x3, x1, x2      # Also 14
    sw   x3, 240(x10)
    
    lw   x4, 240(x10)
    bne  x4, x5, test_fail
    
    # ---------------------------------------------------------
    # 9. Edge cases
    # ---------------------------------------------------------
    li   x1, 0x80000000   # -2^31
    li   x2, 0xFFFFFFFF   # -1
    div  x3, x1, x2      # 0x80000000
    sw   x3, 244(x10)
    
    lw   x4, 244(x10)
    bne  x4, x1, test_fail
    
    li   x1, 0xFFFFFFFF   # Large unsigned
    li   x2, 2
    divu x3, x1, x2      # 0x7FFFFFFF
    sw   x3, 248(x10)
    
    lw   x4, 248(x10)
    li   x5, 0x7FFFFFFF
    bne  x4, x5, test_fail
    
    # ---------------------------------------------------------
    # 10. Chain operations
    # ---------------------------------------------------------
    li   x1, 15
    li   x2, 4
    li   x3, 7
    mul  x4, x1, x2      # 60
    div  x5, x4, x3      # 8
    rem  x6, x4, x3      # 4
    
    # Verify chain
    li   x7, 60
    bne  x4, x7, test_fail
    li   x7, 8
    bne  x5, x7, test_fail
    li   x7, 4
    bne  x6, x7, test_fail
    
    sw   x4, 252(x10)
    sw   x5, 256(x10)
    sw   x6, 260(x10)
    
    # ---------------------------------------------------------
    # 11. Use MUL/DIV results in register file operations
    # ---------------------------------------------------------
    # x4 = 60, x5 = 8, x6 = 4 from previous chain
    add  x7, x4, x5      # 68
    sub  x8, x4, x6      # 56
    and  x9, x5, x6      # 0
    or   x11, x5, x6     # 12
    
    sw   x7, 264(x10)    # 68
    sw   x8, 268(x10)    # 56
    sw   x9, 272(x10)    # 0
    sw   x11, 276(x10)   # 12
    
    # Verify x9 is 0
    bnez x9, test_fail
    
    # =========================================================
    # SUCCESS - Write completion markers
    # =========================================================
test_success:
    # Write success pattern to multiple locations
    li   x31, 0xCAFEBABE
    
    # Markers at different offsets
    sw   x31, 280(x10)   # Marker 1
    sw   x31, 284(x10)   # Marker 2
    sw   x31, 288(x10)   # Marker 3
    
    # Also write to completely different address
    li   x30, 0x80001000
    sw   x31, 0(x30)
    
    # Fill small range with pattern (extra observability)
    li   x1, 300
    li   x2, 320
fill_loop:
    add  x3, x10, x1
    sw   x1, 0(x3)
    addi x1, x1, 4
    blt  x1, x2, fill_loop
    
    # Successful infinite loop
    j .
    
    # =========================================================
    # FAILURE
    # =========================================================
test_fail:
    li   x31, 0xDEADDEAD
    sw   x31, 280(x10)
    sw   x31, 284(x10)
    sw   x31, 288(x10)
    j .
    
    # =========================================================
    # DATA SECTION
    # =========================================================
    .section .data
    .align 4
    .space 1024  # Reserve space if needed
