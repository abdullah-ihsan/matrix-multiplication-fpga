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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/abdullah/Documents/GitHub/matrix-multiplication-fpga/rx.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {7, 0};
static int ng4[] = {2, 0};



static void Always_15_0(char *t0)
{
    char t14[8];
    char t34[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    int t13;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    int t33;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    char *t42;

LAB0:    t1 = (t0 + 3320U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(15, ng0);
    t2 = (t0 + 3640);
    *((int *)t2) = 1;
    t3 = (t0 + 3352);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(15, ng0);

LAB5:    xsi_set_current_line(16, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(21, ng0);

LAB10:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB11:    t5 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t5, 32);
    if (t13 == 1)
        goto LAB12;

LAB13:    t2 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 32);
    if (t13 == 1)
        goto LAB14;

LAB15:    t2 = ((char*)((ng4)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 32);
    if (t13 == 1)
        goto LAB16;

LAB17:
LAB18:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(16, ng0);

LAB9:    xsi_set_current_line(17, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 4, 0LL);
    xsi_set_current_line(18, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 10, 0LL);
    xsi_set_current_line(19, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(20, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB8;

LAB12:    xsi_set_current_line(23, ng0);

LAB19:    xsi_set_current_line(24, ng0);
    t11 = (t0 + 1368U);
    t12 = *((char **)t11);
    t11 = ((char*)((ng1)));
    memset(t14, 0, 8);
    t15 = (t12 + 4);
    t16 = (t11 + 4);
    t6 = *((unsigned int *)t12);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t15);
    t10 = *((unsigned int *)t16);
    t17 = (t9 ^ t10);
    t18 = (t8 | t17);
    t19 = *((unsigned int *)t15);
    t20 = *((unsigned int *)t16);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB23;

LAB20:    if (t21 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t14) = 1;

LAB23:    t25 = (t14 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t14);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB24;

LAB25:
LAB26:    xsi_set_current_line(28, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB18;

LAB14:    xsi_set_current_line(30, ng0);

LAB28:    xsi_set_current_line(31, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = (t0 + 2248);
    t11 = (t0 + 2248);
    t12 = (t11 + 72U);
    t15 = *((char **)t12);
    t16 = (t0 + 2088);
    t24 = (t16 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_generic_convert_bit_index(t14, t15, 2, t25, 4, 2);
    t31 = (t14 + 4);
    t6 = *((unsigned int *)t31);
    t33 = (!(t6));
    if (t33 == 1)
        goto LAB29;

LAB30:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng2)));
    memset(t14, 0, 8);
    xsi_vlog_unsigned_add(t14, 32, t5, 4, t11, 32);
    t12 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t12, t14, 0, 0, 4, 0LL);
    xsi_set_current_line(33, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng3)));
    memset(t14, 0, 8);
    t12 = (t5 + 4);
    t15 = (t11 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t12);
    t10 = *((unsigned int *)t15);
    t17 = (t9 ^ t10);
    t18 = (t8 | t17);
    t19 = *((unsigned int *)t12);
    t20 = *((unsigned int *)t15);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB34;

LAB31:    if (t21 != 0)
        goto LAB33;

LAB32:    *((unsigned int *)t14) = 1;

LAB34:    t24 = (t14 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t14);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB35;

LAB36:
LAB37:    goto LAB18;

LAB16:    xsi_set_current_line(37, ng0);

LAB39:    xsi_set_current_line(38, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng2)));
    memset(t14, 0, 8);
    t11 = (t5 + 4);
    t12 = (t3 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t3);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t11);
    t10 = *((unsigned int *)t12);
    t17 = (t9 ^ t10);
    t18 = (t8 | t17);
    t19 = *((unsigned int *)t11);
    t20 = *((unsigned int *)t12);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB43;

LAB40:    if (t21 != 0)
        goto LAB42;

LAB41:    *((unsigned int *)t14) = 1;

LAB43:    t16 = (t14 + 4);
    t26 = *((unsigned int *)t16);
    t27 = (~(t26));
    t28 = *((unsigned int *)t14);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB44;

LAB45:
LAB46:    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB18;

LAB22:    t24 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB23;

LAB24:    xsi_set_current_line(24, ng0);

LAB27:    xsi_set_current_line(25, ng0);
    t31 = ((char*)((ng2)));
    t32 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t32, t31, 0, 0, 2, 0LL);
    xsi_set_current_line(26, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    goto LAB26;

LAB29:    xsi_vlogvar_wait_assign_value(t3, t5, 0, *((unsigned int *)t14), 1, 0LL);
    goto LAB30;

LAB33:    t16 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t16) = 1;
    goto LAB34;

LAB35:    xsi_set_current_line(33, ng0);

LAB38:    xsi_set_current_line(34, ng0);
    t25 = ((char*)((ng4)));
    t31 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t31, t25, 0, 0, 2, 0LL);
    goto LAB37;

LAB42:    t15 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB43;

LAB44:    xsi_set_current_line(38, ng0);

LAB47:    xsi_set_current_line(39, ng0);
    t24 = (t0 + 2248);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    memset(t34, 0, 8);
    t32 = (t34 + 4);
    t35 = (t31 + 4);
    t36 = *((unsigned int *)t31);
    t37 = (t36 >> 0);
    *((unsigned int *)t34) = t37;
    t38 = *((unsigned int *)t35);
    t39 = (t38 >> 0);
    *((unsigned int *)t32) = t39;
    t40 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t40 & 255U);
    t41 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t41 & 255U);
    t42 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t42, t34, 0, 0, 8, 0LL);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB46;

}


extern void work_m_08783717527089842489_4213641838_init()
{
	static char *pe[] = {(void *)Always_15_0};
	xsi_register_didat("work_m_08783717527089842489_4213641838", "isim/top_tb_isim_beh.exe.sim/work/m_08783717527089842489_4213641838.didat");
	xsi_register_executes(pe);
}
