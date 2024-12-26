
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name project -dir "/home/abdullah/Documents/GitHub/matrix-multiplication-fpga/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/abdullah/Documents/GitHub/matrix-multiplication-fpga/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/abdullah/Documents/GitHub/matrix-multiplication-fpga} }
set_property target_constrs_file "constraints.ucf" [current_fileset -constrset]
add_files [list {constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
