
################################################################
# This is a generated script based on design: cl_design1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source cl_design1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu9p-flga2104-1-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name cl_design1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set S00_AXI_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name S00_AXI_0_araddr direction I left 63 right 0 } \
   ARBURST { physical_name S00_AXI_0_arburst direction I left 1 right 0 } \
   ARCACHE { physical_name S00_AXI_0_arcache direction I left 3 right 0 } \
   ARID { physical_name S00_AXI_0_arid direction I left 1 right 0 } \
   ARLEN { physical_name S00_AXI_0_arlen direction I left 7 right 0 } \
   ARLOCK { physical_name S00_AXI_0_arlock direction I left 0 right 0 } \
   ARPROT { physical_name S00_AXI_0_arprot direction I left 2 right 0 } \
   ARQOS { physical_name S00_AXI_0_arqos direction I left 3 right 0 } \
   ARREADY { physical_name S00_AXI_0_arready direction O left 0 right 0 } \
   ARSIZE { physical_name S00_AXI_0_arsize direction I left 2 right 0 } \
   ARVALID { physical_name S00_AXI_0_arvalid direction I left 0 right 0 } \
   AWADDR { physical_name S00_AXI_0_awaddr direction I left 63 right 0 } \
   AWBURST { physical_name S00_AXI_0_awburst direction I left 1 right 0 } \
   AWCACHE { physical_name S00_AXI_0_awcache direction I left 3 right 0 } \
   AWID { physical_name S00_AXI_0_awid direction I left 1 right 0 } \
   AWLEN { physical_name S00_AXI_0_awlen direction I left 7 right 0 } \
   AWLOCK { physical_name S00_AXI_0_awlock direction I left 0 right 0 } \
   AWPROT { physical_name S00_AXI_0_awprot direction I left 2 right 0 } \
   AWQOS { physical_name S00_AXI_0_awqos direction I left 3 right 0 } \
   AWREADY { physical_name S00_AXI_0_awready direction O left 0 right 0 } \
   AWSIZE { physical_name S00_AXI_0_awsize direction I left 2 right 0 } \
   AWVALID { physical_name S00_AXI_0_awvalid direction I left 0 right 0 } \
   BID { physical_name S00_AXI_0_bid direction O left 1 right 0 } \
   BREADY { physical_name S00_AXI_0_bready direction I left 0 right 0 } \
   BRESP { physical_name S00_AXI_0_bresp direction O left 1 right 0 } \
   BVALID { physical_name S00_AXI_0_bvalid direction O left 0 right 0 } \
   RDATA { physical_name S00_AXI_0_rdata direction O left 63 right 0 } \
   RID { physical_name S00_AXI_0_rid direction O left 1 right 0 } \
   RLAST { physical_name S00_AXI_0_rlast direction O left 0 right 0 } \
   RREADY { physical_name S00_AXI_0_rready direction I left 0 right 0 } \
   RRESP { physical_name S00_AXI_0_rresp direction O left 1 right 0 } \
   RVALID { physical_name S00_AXI_0_rvalid direction O left 0 right 0 } \
   WDATA { physical_name S00_AXI_0_wdata direction I left 63 right 0 } \
   WLAST { physical_name S00_AXI_0_wlast direction I left 0 right 0 } \
   WREADY { physical_name S00_AXI_0_wready direction O left 0 right 0 } \
   WSTRB { physical_name S00_AXI_0_wstrb direction I left 7 right 0 } \
   WVALID { physical_name S00_AXI_0_wvalid direction I left 0 right 0 } \
   } \
  S00_AXI_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {1} \
   CONFIG.INSERT_VIP {0} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0.0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S00_AXI_0
  set_property HDL_ATTRIBUTE.LOCKED {TRUE} [get_bd_intf_ports S00_AXI_0]

  set S_AXI_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 -portmaps { \
   ARADDR { physical_name S_AXI_0_araddr direction I left 31 right 0 } \
   ARPROT { physical_name S_AXI_0_arprot direction I left 2 right 0 } \
   ARREADY { physical_name S_AXI_0_arready direction O } \
   ARVALID { physical_name S_AXI_0_arvalid direction I } \
   AWADDR { physical_name S_AXI_0_awaddr direction I left 31 right 0 } \
   AWPROT { physical_name S_AXI_0_awprot direction I left 2 right 0 } \
   AWREADY { physical_name S_AXI_0_awready direction O } \
   AWVALID { physical_name S_AXI_0_awvalid direction I } \
   BREADY { physical_name S_AXI_0_bready direction I } \
   BRESP { physical_name S_AXI_0_bresp direction O left 1 right 0 } \
   BVALID { physical_name S_AXI_0_bvalid direction O } \
   RDATA { physical_name S_AXI_0_rdata direction O left 31 right 0 } \
   RREADY { physical_name S_AXI_0_rready direction I } \
   RRESP { physical_name S_AXI_0_rresp direction O left 1 right 0 } \
   RVALID { physical_name S_AXI_0_rvalid direction O } \
   WDATA { physical_name S_AXI_0_wdata direction I left 31 right 0 } \
   WREADY { physical_name S_AXI_0_wready direction O } \
   WSTRB { physical_name S_AXI_0_wstrb direction I left 3 right 0 } \
   WVALID { physical_name S_AXI_0_wvalid direction I } \
   } \
  S_AXI_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.INSERT_VIP {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PHASE {0.0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S_AXI_0
  set_property HDL_ATTRIBUTE.LOCKED {TRUE} [get_bd_intf_ports S_AXI_0]


  # Create ports
  set rsta_busy_0 [ create_bd_port -dir O rsta_busy_0 ]
  set s_axi_aclk_0 [ create_bd_port -dir I -type clk -freq_hz 10000000 s_axi_aclk_0 ]
  set s_axi_aresetn_0 [ create_bd_port -dir I -type rst s_axi_aresetn_0 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_crossbar_0, and set properties
  set axi_crossbar_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_crossbar:2.1 axi_crossbar_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.ID_WIDTH {2} \
   CONFIG.M00_A00_ADDR_WIDTH {64} \
   CONFIG.M00_A00_BASE_ADDR {0x0000000000000000} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S01_BASE_ID {0x00000002} \
   CONFIG.S02_BASE_ID {0x00000004} \
   CONFIG.S03_BASE_ID {0x00000006} \
   CONFIG.S04_BASE_ID {0x00000008} \
   CONFIG.S05_BASE_ID {0x0000000a} \
   CONFIG.S06_BASE_ID {0x0000000c} \
   CONFIG.S07_BASE_ID {0x0000000e} \
   CONFIG.S08_BASE_ID {0x00000010} \
   CONFIG.S09_BASE_ID {0x00000012} \
   CONFIG.S10_BASE_ID {0x00000014} \
   CONFIG.S11_BASE_ID {0x00000016} \
   CONFIG.S12_BASE_ID {0x00000018} \
   CONFIG.S13_BASE_ID {0x0000001a} \
   CONFIG.S14_BASE_ID {0x0000001c} \
   CONFIG.S15_BASE_ID {0x0000001e} \
 ] $axi_crossbar_0

  # Create instance: axi_dwidth_converter_0, and set properties
  set axi_dwidth_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dwidth_converter:2.1 axi_dwidth_converter_0 ]
  set_property -dict [ list \
   CONFIG.PROTOCOL {AXI4LITE} \
 ] $axi_dwidth_converter_0

  # Create instance: axi_protocol_convert_0, and set properties
  set axi_protocol_convert_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {64} \
   CONFIG.MI_PROTOCOL {AXI4} \
   CONFIG.SI_PROTOCOL {AXI4LITE} \
   CONFIG.TRANSLATION_MODE {2} \
 ] $axi_protocol_convert_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Read_Width_A {64} \
   CONFIG.Read_Width_B {64} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Write_Width_A {64} \
   CONFIG.Write_Width_B {64} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $blk_mem_gen_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_0_1 [get_bd_intf_ports S00_AXI_0] [get_bd_intf_pins axi_crossbar_0/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_0_1 [get_bd_intf_ports S_AXI_0] [get_bd_intf_pins axi_dwidth_converter_0/S_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_crossbar_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_dwidth_converter_0_M_AXI [get_bd_intf_pins axi_dwidth_converter_0/M_AXI] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_0_M_AXI [get_bd_intf_pins axi_crossbar_0/S01_AXI] [get_bd_intf_pins axi_protocol_convert_0/M_AXI]

  # Create port connections
  connect_bd_net -net blk_mem_gen_0_rsta_busy [get_bd_ports rsta_busy_0] [get_bd_pins blk_mem_gen_0/rsta_busy]
  connect_bd_net -net s_axi_aclk_0_1 [get_bd_ports s_axi_aclk_0] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_crossbar_0/aclk] [get_bd_pins axi_dwidth_converter_0/s_axi_aclk] [get_bd_pins axi_protocol_convert_0/aclk]
  connect_bd_net -net s_axi_aresetn_0_1 [get_bd_ports s_axi_aresetn_0] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_crossbar_0/aresetn] [get_bd_pins axi_dwidth_converter_0/s_axi_aresetn] [get_bd_pins axi_protocol_convert_0/aresetn]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


