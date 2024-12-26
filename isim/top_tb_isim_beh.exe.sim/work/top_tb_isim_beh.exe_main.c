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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_05718809200827989258_4233862032_init();
    work_m_08783717527089842489_4213641838_init();
    work_m_00650444503356268493_2910696936_init();
    work_m_03787338451016850632_3823007873_init();
    work_m_10290421126032835850_3115858369_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_10290421126032835850_3115858369");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
