/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/JasonLess/Documents/Lab/lab1_final/src_final/tb/tb.v";
static const char *ng1 = "%d ... Running instruction %08b";
static int ng2[] = {1, 0};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {0U, 0U};
static unsigned int ng5[] = {3U, 0U};
static unsigned int ng6[] = {1U, 0U};
static unsigned int ng7[] = {2U, 0U};
static const char *ng8 = "seq.code";
static const char *ng9 = "%d ... instruction %08b executed";
static const char *ng10 = "%d ... led output changed to %08b";



static int sp_tskRunInst(char *t1, char *t2)
{
    char t5[8];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 848);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(79, ng0);

LAB5:    xsi_set_current_line(80, ng0);
    *((int *)t5) = xsi_vlog_stime(1000.0000000000000, 1000.0000000000000);
    t6 = (t5 + 4);
    *((int *)t6) = 0;
    t7 = (t1 + 5048);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 848);
    xsi_vlogfile_write(1, 0, 0, ng1, 3, t10, (char)118, t5, 32, (char)118, t9, 8);
    xsi_set_current_line(81, ng0);
    t4 = (t1 + 5048);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t1 + 3928);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    xsi_set_current_line(82, ng0);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    xsi_process_wait(t6, 1500000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(82, ng0);
    t7 = ((char*)((ng2)));
    t8 = (t1 + 4408);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 1);
    xsi_set_current_line(83, ng0);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    xsi_process_wait(t6, 3000000000LL);
    *((char **)t3) = &&LAB7;
    t0 = 1;
    goto LAB1;

LAB7:    xsi_set_current_line(83, ng0);
    t7 = ((char*)((ng3)));
    t8 = (t1 + 4408);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 1);
    goto LAB4;

}

static int sp_tskRunPUSH(char *t1, char *t2)
{
    char t5[8];
    char t6[8];
    char t18[8];
    int t0;
    char *t3;
    char *t4;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    int t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1280);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(91, ng0);

LAB5:    xsi_set_current_line(92, ng0);
    t7 = (t1 + 5368);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t6, 0, 8);
    t10 = (t6 + 4);
    t11 = (t9 + 4);
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 0);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t11);
    t15 = (t14 >> 0);
    *((unsigned int *)t10) = t15;
    t16 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t16 & 15U);
    t17 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t17 & 15U);
    t19 = (t1 + 5208);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t18, 0, 8);
    t22 = (t18 + 4);
    t23 = (t21 + 4);
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t18) = t25;
    t26 = *((unsigned int *)t23);
    t27 = (t26 >> 0);
    *((unsigned int *)t22) = t27;
    t28 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t28 & 3U);
    t29 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t29 & 3U);
    t30 = ((char*)((ng4)));
    xsi_vlogtype_concat(t5, 8, 8, 3U, t30, 2, t18, 2, t6, 4);
    t31 = (t1 + 5528);
    xsi_vlogvar_assign_value(t31, t5, 0, 0, 8);
    xsi_set_current_line(93, ng0);
    t4 = (t1 + 5528);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t2 + 56U);
    t19 = *((char **)t11);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t19, &&LAB6);
    t20 = (t2 + 56U);
    t21 = *((char **)t20);
    t22 = (t1 + 848);
    t23 = xsi_create_subprogram_invocation(t21, 0, t1, t22, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t22, t23);
    t30 = (t1 + 5048);
    xsi_vlogvar_assign_value(t30, t8, 0, 0, 8);

LAB8:    t31 = (t2 + 64U);
    t32 = *((char **)t31);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t39 == -1)
        goto LAB9;

LAB10:    if (t39 != 0)
        goto LAB11;

LAB6:    t32 = (t1 + 848);
    xsi_vlog_subprogram_popinvocation(t32);

LAB7:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 848);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    t0 = -1;
    goto LAB1;

LAB11:    t31 = (t2 + 48U);
    *((char **)t31) = &&LAB8;
    goto LAB1;

}

static int sp_tskRunSEND(char *t1, char *t2)
{
    char t5[8];
    char t7[8];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    int t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1712);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(100, ng0);

LAB5:    xsi_set_current_line(101, ng0);
    t6 = ((char*)((ng4)));
    t8 = (t1 + 5688);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memset(t7, 0, 8);
    t11 = (t7 + 4);
    t12 = (t10 + 4);
    t13 = *((unsigned int *)t10);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t12);
    t16 = (t15 >> 0);
    *((unsigned int *)t11) = t16;
    t17 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t17 & 3U);
    t18 = *((unsigned int *)t11);
    *((unsigned int *)t11) = (t18 & 3U);
    t19 = ((char*)((ng5)));
    xsi_vlogtype_concat(t5, 8, 8, 3U, t19, 2, t7, 2, t6, 4);
    t20 = (t1 + 5848);
    xsi_vlogvar_assign_value(t20, t5, 0, 0, 8);
    xsi_set_current_line(102, ng0);
    t4 = (t1 + 5848);
    t6 = (t4 + 56U);
    t8 = *((char **)t6);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t2 + 56U);
    t12 = *((char **)t11);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t12, &&LAB6);
    t19 = (t2 + 56U);
    t20 = *((char **)t19);
    t21 = (t1 + 848);
    t22 = xsi_create_subprogram_invocation(t20, 0, t1, t21, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t21, t22);
    t23 = (t1 + 5048);
    xsi_vlogvar_assign_value(t23, t8, 0, 0, 8);

LAB8:    t24 = (t2 + 64U);
    t25 = *((char **)t24);
    t26 = (t25 + 80U);
    t27 = *((char **)t26);
    t28 = (t27 + 272U);
    t29 = *((char **)t28);
    t30 = (t29 + 0U);
    t31 = *((char **)t30);
    t32 = ((int  (*)(char *, char *))t31)(t1, t25);
    if (t32 == -1)
        goto LAB9;

LAB10:    if (t32 != 0)
        goto LAB11;

LAB6:    t25 = (t1 + 848);
    xsi_vlog_subprogram_popinvocation(t25);

LAB7:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t33 = (t1 + 848);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_delete_subprogram_invocation(t33, t34, t1, t36, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    t0 = -1;
    goto LAB1;

LAB11:    t24 = (t2 + 48U);
    *((char **)t24) = &&LAB8;
    goto LAB1;

}

static int sp_tskRunADD(char *t1, char *t2)
{
    char t5[8];
    char t6[8];
    char t18[8];
    char t30[8];
    int t0;
    char *t3;
    char *t4;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    int t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 2144);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(111, ng0);

LAB5:    xsi_set_current_line(112, ng0);
    t7 = (t1 + 6328);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t6, 0, 8);
    t10 = (t6 + 4);
    t11 = (t9 + 4);
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 0);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t11);
    t15 = (t14 >> 0);
    *((unsigned int *)t10) = t15;
    t16 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t16 & 3U);
    t17 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t17 & 3U);
    t19 = (t1 + 6168);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t18, 0, 8);
    t22 = (t18 + 4);
    t23 = (t21 + 4);
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t18) = t25;
    t26 = *((unsigned int *)t23);
    t27 = (t26 >> 0);
    *((unsigned int *)t22) = t27;
    t28 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t28 & 3U);
    t29 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t29 & 3U);
    t31 = (t1 + 6008);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memset(t30, 0, 8);
    t34 = (t30 + 4);
    t35 = (t33 + 4);
    t36 = *((unsigned int *)t33);
    t37 = (t36 >> 0);
    *((unsigned int *)t30) = t37;
    t38 = *((unsigned int *)t35);
    t39 = (t38 >> 0);
    *((unsigned int *)t34) = t39;
    t40 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t40 & 3U);
    t41 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t41 & 3U);
    t42 = ((char*)((ng6)));
    xsi_vlogtype_concat(t5, 8, 8, 4U, t42, 2, t30, 2, t18, 2, t6, 2);
    t43 = (t1 + 6488);
    xsi_vlogvar_assign_value(t43, t5, 0, 0, 8);
    xsi_set_current_line(113, ng0);
    t4 = (t1 + 6488);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t2 + 56U);
    t19 = *((char **)t11);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t19, &&LAB6);
    t20 = (t2 + 56U);
    t21 = *((char **)t20);
    t22 = (t1 + 848);
    t23 = xsi_create_subprogram_invocation(t21, 0, t1, t22, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t22, t23);
    t31 = (t1 + 5048);
    xsi_vlogvar_assign_value(t31, t8, 0, 0, 8);

LAB8:    t32 = (t2 + 64U);
    t33 = *((char **)t32);
    t34 = (t33 + 80U);
    t35 = *((char **)t34);
    t42 = (t35 + 272U);
    t43 = *((char **)t42);
    t44 = (t43 + 0U);
    t45 = *((char **)t44);
    t46 = ((int  (*)(char *, char *))t45)(t1, t33);
    if (t46 == -1)
        goto LAB9;

LAB10:    if (t46 != 0)
        goto LAB11;

LAB6:    t33 = (t1 + 848);
    xsi_vlog_subprogram_popinvocation(t33);

LAB7:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t47 = (t1 + 848);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t47, t48, t1, t50, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    t0 = -1;
    goto LAB1;

LAB11:    t32 = (t2 + 48U);
    *((char **)t32) = &&LAB8;
    goto LAB1;

}

static int sp_tskRunMULT(char *t1, char *t2)
{
    char t5[8];
    char t6[8];
    char t18[8];
    char t30[8];
    int t0;
    char *t3;
    char *t4;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    int t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 2576);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(122, ng0);

LAB5:    xsi_set_current_line(123, ng0);
    t7 = (t1 + 6968);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t6, 0, 8);
    t10 = (t6 + 4);
    t11 = (t9 + 4);
    t12 = *((unsigned int *)t9);
    t13 = (t12 >> 0);
    *((unsigned int *)t6) = t13;
    t14 = *((unsigned int *)t11);
    t15 = (t14 >> 0);
    *((unsigned int *)t10) = t15;
    t16 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t16 & 3U);
    t17 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t17 & 3U);
    t19 = (t1 + 6808);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t18, 0, 8);
    t22 = (t18 + 4);
    t23 = (t21 + 4);
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t18) = t25;
    t26 = *((unsigned int *)t23);
    t27 = (t26 >> 0);
    *((unsigned int *)t22) = t27;
    t28 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t28 & 3U);
    t29 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t29 & 3U);
    t31 = (t1 + 6648);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memset(t30, 0, 8);
    t34 = (t30 + 4);
    t35 = (t33 + 4);
    t36 = *((unsigned int *)t33);
    t37 = (t36 >> 0);
    *((unsigned int *)t30) = t37;
    t38 = *((unsigned int *)t35);
    t39 = (t38 >> 0);
    *((unsigned int *)t34) = t39;
    t40 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t40 & 3U);
    t41 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t41 & 3U);
    t42 = ((char*)((ng7)));
    xsi_vlogtype_concat(t5, 8, 8, 4U, t42, 2, t30, 2, t18, 2, t6, 2);
    t43 = (t1 + 7128);
    xsi_vlogvar_assign_value(t43, t5, 0, 0, 8);
    xsi_set_current_line(124, ng0);
    t4 = (t1 + 7128);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t2 + 56U);
    t19 = *((char **)t11);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t19, &&LAB6);
    t20 = (t2 + 56U);
    t21 = *((char **)t20);
    t22 = (t1 + 848);
    t23 = xsi_create_subprogram_invocation(t21, 0, t1, t22, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t22, t23);
    t31 = (t1 + 5048);
    xsi_vlogvar_assign_value(t31, t8, 0, 0, 8);

LAB8:    t32 = (t2 + 64U);
    t33 = *((char **)t32);
    t34 = (t33 + 80U);
    t35 = *((char **)t34);
    t42 = (t35 + 272U);
    t43 = *((char **)t42);
    t44 = (t43 + 0U);
    t45 = *((char **)t44);
    t46 = ((int  (*)(char *, char *))t45)(t1, t33);
    if (t46 == -1)
        goto LAB9;

LAB10:    if (t46 != 0)
        goto LAB11;

LAB6:    t33 = (t1 + 848);
    xsi_vlog_subprogram_popinvocation(t33);

LAB7:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t47 = (t1 + 848);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t47, t48, t1, t50, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    t0 = -1;
    goto LAB1;

LAB11:    t32 = (t2 + 48U);
    *((char **)t32) = &&LAB8;
    goto LAB1;

}

static void Initial_20_0(char *t0)
{
    char t5[8];
    char t21[8];
    char t32[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    int t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;

LAB0:    t1 = (t0 + 8048U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);

LAB4:    xsi_set_current_line(25, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(26, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4568);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(27, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(28, ng0);
    t2 = (t0 + 7856);
    xsi_process_wait(t2, 1000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(28, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 4568);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(29, ng0);
    t2 = (t0 + 7856);
    xsi_process_wait(t2, 1500000000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 4088);
    xsi_vlogfile_readmemb(ng8, 0, t2, 0, 0, 0, 0);
    xsi_set_current_line(44, ng0);
    t2 = (t0 + 4088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = (t0 + 4088);
    t7 = (t6 + 72U);
    t8 = *((char **)t7);
    t9 = (t0 + 4088);
    t10 = (t9 + 64U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng3)));
    xsi_vlog_generic_get_array_select_value(t5, 11, t4, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t0 + 4728);
    xsi_vlogvar_assign_value(t13, t5, 0, 0, 11);
    xsi_set_current_line(47, ng0);
    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4888);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB7:    t2 = (t0 + 4888);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = (t0 + 4728);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t5, 0, 8);
    t9 = (t4 + 4);
    if (*((unsigned int *)t9) != 0)
        goto LAB9;

LAB8:    t10 = (t8 + 4);
    if (*((unsigned int *)t10) != 0)
        goto LAB9;

LAB12:    if (*((unsigned int *)t4) < *((unsigned int *)t8))
        goto LAB10;

LAB11:    t12 = (t5 + 4);
    t14 = *((unsigned int *)t12);
    t15 = (~(t14));
    t16 = *((unsigned int *)t5);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB13;

LAB14:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 7856);
    xsi_process_wait(t2, 1000000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB9:    t11 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB11;

LAB10:    *((unsigned int *)t5) = 1;
    goto LAB11;

LAB13:    xsi_set_current_line(48, ng0);
    t13 = (t0 + 4088);
    t19 = (t13 + 56U);
    t20 = *((char **)t19);
    t22 = (t0 + 4088);
    t23 = (t22 + 72U);
    t24 = *((char **)t23);
    t25 = (t0 + 4088);
    t26 = (t25 + 64U);
    t27 = *((char **)t26);
    t28 = (t0 + 4888);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = ((char*)((ng2)));
    memset(t32, 0, 8);
    xsi_vlog_signed_add(t32, 32, t30, 32, t31, 32);
    xsi_vlog_generic_get_array_select_value(t21, 8, t20, t24, t27, 2, 1, t32, 32, 1);
    t33 = (t0 + 7856);
    t34 = (t0 + 848);
    t35 = xsi_create_subprogram_invocation(t33, 0, t0, t34, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t34, t35);
    t36 = (t0 + 5048);
    xsi_vlogvar_assign_value(t36, t21, 0, 0, 8);

LAB17:    t37 = (t0 + 7952);
    t38 = *((char **)t37);
    t39 = (t38 + 80U);
    t40 = *((char **)t39);
    t41 = (t40 + 272U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    t44 = *((char **)t43);
    t45 = ((int  (*)(char *, char *))t44)(t0, t38);

LAB19:    if (t45 != 0)
        goto LAB20;

LAB15:    t38 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t38);

LAB16:    t46 = (t0 + 7952);
    t47 = *((char **)t46);
    t46 = (t0 + 848);
    t48 = (t0 + 7856);
    t49 = 0;
    xsi_delete_subprogram_invocation(t46, t47, t0, t48, t49);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 4888);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = ((char*)((ng2)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t4, 32, t6, 32);
    t7 = (t0 + 4888);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 32);
    goto LAB7;

LAB18:;
LAB20:    t37 = (t0 + 8048U);
    *((char **)t37) = &&LAB17;
    goto LAB1;

LAB21:    xsi_set_current_line(51, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}

static void Always_54_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 8296U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 8104);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(54, ng0);
    t4 = (t0 + 4248);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 4248);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

}

static void Always_128_2(char *t0)
{
    char t14[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    t1 = (t0 + 8544U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(128, ng0);
    t2 = (t0 + 9112);
    *((int *)t2) = 1;
    t3 = (t0 + 8576);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(129, ng0);
    t4 = (t0 + 11400);
    t5 = *((char **)t4);
    t6 = ((((char*)(t5))) + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (~(t9));
    t11 = *((unsigned int *)t7);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB5;

LAB6:
LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(130, ng0);
    *((int *)t14) = xsi_vlog_stime(1000.0000000000000, 1000.0000000000000);
    t15 = (t14 + 4);
    *((int *)t15) = 0;
    t16 = (t0 + 11424);
    t17 = *((char **)t16);
    t18 = ((((char*)(t17))) + 56U);
    t19 = *((char **)t18);
    xsi_vlogfile_write(1, 0, 0, ng9, 3, t0, (char)118, t14, 32, (char)118, t19, 8);
    goto LAB7;

}

static void Always_132_3(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 8792U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(132, ng0);
    t2 = (t0 + 9128);
    *((int *)t2) = 1;
    t3 = (t0 + 8824);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(133, ng0);
    *((int *)t4) = xsi_vlog_stime(1000.0000000000000, 1000.0000000000000);
    t5 = (t4 + 4);
    *((int *)t5) = 0;
    t6 = (t0 + 3528U);
    t7 = *((char **)t6);
    xsi_vlogfile_write(1, 0, 0, ng10, 3, t0, (char)118, t4, 32, (char)118, t7, 8);
    goto LAB2;

}


extern void work_m_00000000003011939191_3671711236_init()
{
	static char *pe[] = {(void *)Initial_20_0,(void *)Always_54_1,(void *)Always_128_2,(void *)Always_132_3};
	static char *se[] = {(void *)sp_tskRunInst,(void *)sp_tskRunPUSH,(void *)sp_tskRunSEND,(void *)sp_tskRunADD,(void *)sp_tskRunMULT};
	xsi_register_didat("work_m_00000000003011939191_3671711236", "isim/tb_isim_beh.exe.sim/work/m_00000000003011939191_3671711236.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
