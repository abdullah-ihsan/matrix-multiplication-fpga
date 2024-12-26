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
static const char *ng0 = "/home/abdullah/Documents/GitHub/matrix-multiplication-fpga/top_tb.v";
static int ng1[] = {0, 0};
static int ng2[] = {8, 0};
static int ng3[] = {1, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {165U, 0U};



static int sp_uart_rx_byte(char *t1, char *t2)
{
    char t8[8];
    char t18[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 848);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(28, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t5 = ((char*)((ng1)));
    t6 = (t1 + 2200);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 1);
    xsi_set_current_line(31, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 104160000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(34, ng0);
    xsi_set_current_line(34, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 2680);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);

LAB7:    t4 = (t1 + 2680);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng2)));
    memset(t8, 0, 8);
    xsi_vlog_signed_less(t8, 32, t6, 32, t7, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(40, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 2200);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 104160000LL);
    *((char **)t3) = &&LAB12;
    t0 = 1;
    goto LAB1;

LAB8:    xsi_set_current_line(34, ng0);

LAB10:    xsi_set_current_line(35, ng0);
    t15 = (t1 + 2520);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t19 = (t1 + 2520);
    t20 = (t19 + 72U);
    t21 = *((char **)t20);
    t22 = (t1 + 2680);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    xsi_vlog_generic_get_index_select_value(t18, 1, t17, t21, 2, t24, 32, 1);
    t25 = (t1 + 2200);
    xsi_vlogvar_assign_value(t25, t18, 0, 0, 1);
    xsi_set_current_line(36, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 104160000LL);
    *((char **)t3) = &&LAB11;
    t0 = 1;
    goto LAB1;

LAB11:    xsi_set_current_line(34, ng0);
    t4 = (t1 + 2680);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t8, 0, 8);
    xsi_vlog_signed_add(t8, 32, t6, 32, t7, 32);
    t9 = (t1 + 2680);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 32);
    goto LAB7;

LAB12:    goto LAB4;

}

static void Always_22_0(char *t0)
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

LAB0:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 3400);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(22, ng0);
    t4 = (t0 + 1880);
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
    t24 = (t0 + 1880);
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

static void Initial_45_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    t1 = (t0 + 3840U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(45, ng0);

LAB4:    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1880);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(48, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2040);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(49, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2200);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(50, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2360);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 2);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3648);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2040);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 3648);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(58, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 3648);
    t4 = (t0 + 848);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t6 = (t0 + 2520);
    xsi_vlogvar_assign_value(t6, t2, 0, 0, 8);

LAB9:    t7 = (t0 + 3744);
    t8 = *((char **)t7);
    t9 = (t8 + 80U);
    t10 = *((char **)t9);
    t11 = (t10 + 272U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    t14 = *((char **)t13);
    t15 = ((int  (*)(char *, char *))t14)(t0, t8);

LAB11:    if (t15 != 0)
        goto LAB12;

LAB7:    t8 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t8);

LAB8:    t16 = (t0 + 3744);
    t17 = *((char **)t16);
    t16 = (t0 + 848);
    t18 = (t0 + 3648);
    t19 = 0;
    xsi_delete_subprogram_invocation(t16, t17, t0, t18, t19);
    xsi_set_current_line(61, ng0);
    t2 = (t0 + 3648);
    xsi_process_wait(t2, 2000000000LL);
    *((char **)t1) = &&LAB13;
    goto LAB1;

LAB10:;
LAB12:    t7 = (t0 + 3840U);
    *((char **)t7) = &&LAB9;
    goto LAB1;

LAB13:    xsi_set_current_line(64, ng0);
    xsi_vlog_stop(1);
    goto LAB1;

}


extern void work_m_10290421126032835850_3115858369_init()
{
	static char *pe[] = {(void *)Always_22_0,(void *)Initial_45_1};
	static char *se[] = {(void *)sp_uart_rx_byte};
	xsi_register_didat("work_m_10290421126032835850_3115858369", "isim/top_tb_isim_beh.exe.sim/work/m_10290421126032835850_3115858369.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
