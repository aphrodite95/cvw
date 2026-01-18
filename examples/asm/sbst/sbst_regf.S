    .section .text.init
    .globl _start
_start:
    # =========================================================
    # REGISTER FILE SAF TEST - RV32E (x0-x15)
    # Goal: >90% Stuck-At Fault Coverage
    # =========================================================

    # ---------------------------------------------------------
    # 0. Setup memory pointer for observability
    # Use a fixed address in data memory region
    # ---------------------------------------------------------
    lui  x10, %hi(obs_mem)
    addi x10, x10, %lo(obs_mem)

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

    # Observe: store all zeros
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

    # Observe: store all ones
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
    # 3. WALKING 1s (per bit, per register)
    # ---------------------------------------------------------
    li   x1, 0x00000001
    sw   x1, 112(x10)
    li   x2, 0x00000002
    sw   x2, 116(x10)
    li   x3, 0x00000004
    sw   x3, 120(x10)
    li   x4, 0x00000008
    sw   x4, 124(x10)
    li   x5, 0x00000010
    sw   x5, 128(x10)
    li   x6, 0x00000020
    sw   x6, 132(x10)
    li   x7, 0x00000040
    sw   x7, 136(x10)
    li   x8, 0x00000080
    sw   x8, 140(x10)
    li   x9, 0x00000100
    sw   x9, 144(x10)
    li   x11, 0x00000200
    sw   x11, 148(x10)
    li   x12, 0x00000400
    sw   x12, 152(x10)
    li   x13, 0x00000800
    sw   x13, 156(x10)
    li   x14, 0x00001000
    sw   x14, 160(x10)
    li   x15, 0x00002000
    sw   x15, 164(x10)

    # Continue walking 1s for remaining bit positions
    li   x1, 0x00004000
    sw   x1, 168(x10)
    li   x2, 0x00008000
    sw   x2, 172(x10)
    li   x3, 0x00010000
    sw   x3, 176(x10)
    li   x4, 0x00020000
    sw   x4, 180(x10)
    li   x5, 0x00040000
    sw   x5, 184(x10)
    li   x6, 0x00080000
    sw   x6, 188(x10)
    li   x7, 0x00100000
    sw   x7, 192(x10)
    li   x8, 0x00200000
    sw   x8, 196(x10)
    li   x9, 0x00400000
    sw   x9, 200(x10)
    li   x11, 0x00800000
    sw   x11, 204(x10)
    li   x12, 0x01000000
    sw   x12, 208(x10)
    li   x13, 0x02000000
    sw   x13, 212(x10)
    li   x14, 0x04000000
    sw   x14, 216(x10)
    li   x15, 0x08000000
    sw   x15, 220(x10)

    li   x1, 0x10000000
    sw   x1, 224(x10)
    li   x2, 0x20000000
    sw   x2, 228(x10)
    li   x3, 0x40000000
    sw   x3, 232(x10)
    li   x4, 0x80000000
    sw   x4, 236(x10)

    # ---------------------------------------------------------
    # 4. WALKING 0s (inverted)
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFE
    sw   x1, 240(x10)
    li   x2, 0xFFFFFFFD
    sw   x2, 244(x10)
    li   x3, 0xFFFFFFFB
    sw   x3, 248(x10)
    li   x4, 0xFFFFFFF7
    sw   x4, 252(x10)
    li   x5, 0xFFFFFFEF
    sw   x5, 256(x10)
    li   x6, 0xFFFFFFDF
    sw   x6, 260(x10)
    li   x7, 0xFFFFFFBF
    sw   x7, 264(x10)
    li   x8, 0xFFFFFF7F
    sw   x8, 268(x10)
    li   x9, 0xFFFFFEFF
    sw   x9, 272(x10)
    li   x11, 0xFFFFFDFF
    sw   x11, 276(x10)
    li   x12, 0xFFFFFBFF
    sw   x12, 280(x10)
    li   x13, 0xFFFFF7FF
    sw   x13, 284(x10)
    li   x14, 0xFFFFEFFF
    sw   x14, 288(x10)
    li   x15, 0xFFFFDFFF
    sw   x15, 292(x10)

    # ---------------------------------------------------------
    # 5. CHECKERBOARD & ALTERNATING PATTERNS
    # ---------------------------------------------------------
    li   x1, 0x55555555
    li   x2, 0xAAAAAAAA
    li   x3, 0x33333333
    li   x4, 0xCCCCCCCC
    li   x5, 0x0F0F0F0F
    li   x6, 0xF0F0F0F0
    li   x7, 0x00FF00FF
    li   x8, 0xFF00FF00
    li   x9, 0x0000FFFF
    li   x11, 0xFFFF0000
    li   x12, 0x12345678
    li   x13, 0x9ABCDEF0
    li   x14, 0x87654321
    li   x15, 0xDEADBEEF

    # Store all patterns
    sw   x1, 296(x10)
    sw   x2, 300(x10)
    sw   x3, 304(x10)
    sw   x4, 308(x10)
    sw   x5, 312(x10)
    sw   x6, 316(x10)
    sw   x7, 320(x10)
    sw   x8, 324(x10)
    sw   x9, 328(x10)
    sw   x11, 332(x10)
    sw   x12, 336(x10)
    sw   x13, 340(x10)
    sw   x14, 344(x10)
    sw   x15, 348(x10)

    # ---------------------------------------------------------
    # 6. REGISTER ADDRESSING TEST (unique values)
    # ---------------------------------------------------------
    li   x1, 0x11111111
    li   x2, 0x22222222
    li   x3, 0x33333333
    li   x4, 0x44444444
    li   x5, 0x55555555
    li   x6, 0x66666666
    li   x7, 0x77777777
    li   x8, 0x88888888
    li   x9, 0x99999999
    li   x11, 0xAAAAAAAA
    li   x12, 0xBBBBBBBB
    li   x13, 0xCCCCCCCC
    li   x14, 0xDDDDDDDD
    li   x15, 0xEEEEEEEE

    sw   x1, 352(x10)
    sw   x2, 356(x10)
    sw   x3, 360(x10)
    sw   x4, 364(x10)
    sw   x5, 368(x10)
    sw   x6, 372(x10)
    sw   x7, 376(x10)
    sw   x8, 380(x10)
    sw   x9, 384(x10)
    sw   x11, 388(x10)
    sw   x12, 392(x10)
    sw   x13, 396(x10)
    sw   x14, 400(x10)
    sw   x15, 404(x10)

    # ---------------------------------------------------------
    # 7. READ PORT TEST (use both rs1 and rs2)
    # ---------------------------------------------------------
    add  x1, x2, x3    # rs1=x2, rs2=x3
    sw   x1, 408(x10)
    sub  x2, x4, x5    # rs1=x4, rs2=x5
    sw   x2, 412(x10)
    and  x3, x6, x7    # rs1=x6, rs2=x7
    sw   x3, 416(x10)
    or   x4, x8, x9    # rs1=x8, rs2=x9
    sw   x4, 420(x10)
    xor  x5, x11, x12  # rs1=x11, rs2=x12
    sw   x5, 424(x10)

    # ---------------------------------------------------------
    # 8. x0 TEST (should always read 0)
    # ---------------------------------------------------------
    li   x1, 0xFFFFFFFF
    add  x2, x0, x0    # x2 = 0
    sw   x2, 428(x10)
    bnez x2, fail

    # ---------------------------------------------------------
    # SUCCESS - Write to pass flag
    # ---------------------------------------------------------
    # Load pass flag address
    lui  x1, %hi(pass_flag)
    addi x1, x1, %lo(pass_flag)
    li   x2, 1
    sw   x2, 0(x1)
    j pass

fail:
    lui  x1, %hi(pass_flag)
    addi x1, x1, %lo(pass_flag)
    li   x2, 0
    sw   x2, 0(x1)
    j fail

pass:
    j pass

    .section .data
    .align 4
obs_mem:
    .space 512   # Enough for all observations

pass_flag:
    .word 0

    .section .bss
    .align 4
stack:
    .space 256
stack_top:
