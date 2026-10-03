# Repository setup helper. This creates a project; it does not build or program it.
# The included source/debug constraints preserve the located prototype configuration.
set repository_root [file normalize [file join [file dirname [info script]] ..]]
set project_dir [file join $repository_root build fpga_tdl]
set project_file [file join $project_dir fpga_tdl.xpr]
if {[file exists $project_file]} {
    error "Project already exists at $project_file. Open it in Vivado instead of overwriting it."
}
create_project fpga_tdl $project_dir -part xc7a35tcpg236-1
add_files -norecurse [file join $repository_root rtl tdl_capture.sv]
set_property file_type SystemVerilog [get_files tdl_capture.sv]
add_files -fileset constrs_1 -norecurse [file join $repository_root constraints basys3_tdc.xdc]
set_property top tdl_capture [get_filesets sources_1]
update_compile_order -fileset sources_1
puts "Project created: $project_file"
puts "Review debug constraints and tool messages before running synthesis or implementation."
