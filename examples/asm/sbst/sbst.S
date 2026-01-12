    .section .text.init
    .globl _start
_start:
    /* -------------------------------------------------
     * Basic setup
     * ------------------------------------------------- */
    la   sp, stack_top        /* initialize stack pointer */

    /* -------------------------------------------------
     * Test 1: x0 must always be zero
     * ------------------------------------------------- */
    li   x1, 0x12345678
    mv   x0, x1               /* attempt to write x0 */
    bnez x0, fail             /* x0 must still be zero */

    /* -------------------------------------------------
     * Test 2: Write and read all general registers
     * ------------------------------------------------- */
    li   x1,  1
    li   x2,  2
    li   x3,  3
    li   x4,  4
    li   x5,  5
    li   x6,  6
    li   x7,  7
    li   x8,  8
    li   x9,  9
    li   x10, 10
    li   x11, 11
    li   x12, 12
    li   x13, 13
    li   x14, 14
    li   x15, 15

    /* read-after-write checks */
    li   t0, 1
    bne  x1,  t0, fail
    li   t0, 2

    /* -------------------------------------------------
     * Test 3: Write-after-write (WAW)
     * ------------------------------------------------- */
    li   x5,  0xAAAA
    li   x5,  0x5555
    li   t0,  0x5555
    bne  x5,  t0, fail

    /* -------------------------------------------------
     * Test 4: Two-read one-write behavior
     * ------------------------------------------------- */
    li   x6,  0x10
    li   x7,  0x20
    add  x8,  x6, x7           /* x8 = 0x30 */
    li   t0,  0x30
    bne  x8,  t0, fail

    /* -------------------------------------------------
     * SUCCESS: infinite loop
     * ------------------------------------------------- */
pass:
    j pass

/* -----------------------------------------------------
 * FAILURE: trap loop
 * ----------------------------------------------------- */
fail:
    j fail

/* -----------------------------------------------------
 * Stack
 * ----------------------------------------------------- */
    .section .bss
    .align 4
stack:
    .space 256
stack_top:
