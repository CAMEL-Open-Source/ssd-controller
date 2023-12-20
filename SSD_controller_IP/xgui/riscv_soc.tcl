# SPDX-License-Identifier: LGPL-3.0-or-later
#
# Copyright (C) 2019 CAMELab
#
# Author: Donghyun Gouk <kukdh1@camelab.org>
#

proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"

  ## Page 0
  set page0 [ipgui::add_page $IPINST -name "Page 0"]

  # SoC information
  set soc [ipgui::add_group $IPINST -name "SoC Information" -parent $page0]
  ipgui::add_static_text $IPINST -name "soc_desc" -parent $soc -text {Basic RISC-V SoC Information.}

  set table [ipgui::add_table $IPINST -name soc_table -rows 3 -columns 2 -parent $soc]

  set header_0 [ipgui::add_static_text $IPINST -name soc_table_0 -parent $table -text "Item"]
  set_property cell_location 0,0 $header_0

  set header_1 [ipgui::add_static_text $IPINST -name soc_table_1 -parent $table -text "Value"]
  set_property cell_location 0,1 $header_1

  set row_1_0 [ipgui::add_static_text $IPINST -name soc_table_1_0 -parent $table -text "Hardware threads (core)"]
  set_property cell_location 1,0 $row_1_0

  set row_1_1 [ipgui::add_static_text $IPINST -name soc_table_1_1 -parent $table -text "1"]
  set_property cell_location 1,1 $row_1_1

  set row_2_0 [ipgui::add_static_text $IPINST -name soc_table_2_0 -parent $table -text "Frequency"]
  set_property cell_location 2,0 $row_2_0

  set row_2_1 [ipgui::add_static_text $IPINST -name soc_table_2_1 -parent $table -text "100.000 MHz"]
  set_property cell_location 2,1 $row_2_1

  # Address space information
  set addr [ipgui::add_group $IPINST -name "Address Space" -parent $page0]
  ipgui::add_static_text $IPINST -name "addr_desc" -parent $addr -text {Address space information of each AXI or TileLink port.}

  set table [ipgui::add_table $IPINST -name addr_table -rows 6 -columns 3 -parent $addr]

  set header_0 [ipgui::add_static_text $IPINST -name addr_table_0 -parent $table -text "Interface"]
  set_property cell_location 0,0 $header_0

  set header_1 [ipgui::add_static_text $IPINST -name addr_table_1 -parent $table -text "Base"]
  set_property cell_location 0,1 $header_1

  set header_2 [ipgui::add_static_text $IPINST -name addr_table_2 -parent $table -text "Size"]
  set_property cell_location 0,2 $header_2

  set row_1_0 [ipgui::add_static_text $IPINST -name addr_table_1_0 -parent $table -text "s_axi_fbus"]
  set_property cell_location 1,0 $row_1_0

  set row_1_1 [ipgui::add_static_text $IPINST -name addr_table_1_1 -parent $table -text "0x0"]
  set_property cell_location 1,1 $row_1_1

  set row_1_2 [ipgui::add_static_text $IPINST -name addr_table_1_2 -parent $table -text "0x800000000000 (128.00 TB)"]
  set_property cell_location 1,2 $row_1_2

  set row_2_0 [ipgui::add_static_text $IPINST -name addr_table_2_0 -parent $table -text "m_axi_dram_lo"]
  set_property cell_location 2,0 $row_2_0

  set row_2_1 [ipgui::add_static_text $IPINST -name addr_table_2_1 -parent $table -text "0x80000000 (2.00 GB)"]
  set_property cell_location 2,1 $row_2_1

  set row_2_2 [ipgui::add_static_text $IPINST -name addr_table_2_2 -parent $table -text "0x80000000 (2.00 GB)"]
  set_property cell_location 2,2 $row_2_2

  set row_3_0 [ipgui::add_static_text $IPINST -name addr_table_3_0 -parent $table -text "m_axi_dram_hi"]
  set_property cell_location 3,0 $row_3_0

  set row_3_1 [ipgui::add_static_text $IPINST -name addr_table_3_1 -parent $table -text "0x1000000000 (64.00 GB)"]
  set_property cell_location 3,1 $row_3_1

  set row_3_2 [ipgui::add_static_text $IPINST -name addr_table_3_2 -parent $table -text "0x7ff000000000 (127.94 TB)"]
  set_property cell_location 3,2 $row_3_2

  set row_4_0 [ipgui::add_static_text $IPINST -name addr_table_4_0 -parent $table -text "m_axi_mmio_lo"]
  set_property cell_location 4,0 $row_4_0

  set row_4_1 [ipgui::add_static_text $IPINST -name addr_table_4_1 -parent $table -text "0x40000000 (1.00 GB)"]
  set_property cell_location 4,1 $row_4_1

  set row_4_2 [ipgui::add_static_text $IPINST -name addr_table_4_2 -parent $table -text "0x40000000 (1.00 GB)"]
  set_property cell_location 4,2 $row_4_2

  set row_5_0 [ipgui::add_static_text $IPINST -name addr_table_5_0 -parent $table -text "m_axi_mmio_hi"]
  set_property cell_location 5,0 $row_5_0

  set row_5_1 [ipgui::add_static_text $IPINST -name addr_table_5_1 -parent $table -text "0x100000000 (4.00 GB)"]
  set_property cell_location 5,1 $row_5_1

  set row_5_2 [ipgui::add_static_text $IPINST -name addr_table_5_2 -parent $table -text "0xf00000000 (60.00 GB)"]
  set_property cell_location 5,2 $row_5_2

  # Peripheral device information
  set peri [ipgui::add_group $IPINST -name "Peripheral Device" -parent $page0]
  ipgui::add_static_text $IPINST -name "peri_desc" -parent $peri -text {List of peripheral device(s) included in RISC-V SoC.}

  set table [ipgui::add_table $IPINST -name peri_table -rows 4 -columns 2 -parent $peri]

  set header_0 [ipgui::add_static_text $IPINST -name peri_table_0 -parent $table -text "Peripheral"]
  set_property cell_location 0,0 $header_0

  set header_1 [ipgui::add_static_text $IPINST -name peri_table_1 -parent $table -text "Description"]
  set_property cell_location 0,1 $header_1

  set row_1_0 [ipgui::add_static_text $IPINST -name peri_table_1_0 -parent $table -text "UART"]
  set_property cell_location 1,0 $row_1_0

  set row_1_1 [ipgui::add_static_text $IPINST -name peri_table_1_1 -parent $table -text "base: 0x10000000, size: 0x1000"]
  set_property cell_location 1,1 $row_1_1

  set row_2_0 [ipgui::add_static_text $IPINST -name peri_table_2_0 -parent $table -text "SPI"]
  set_property cell_location 2,0 $row_2_0

  set row_2_1 [ipgui::add_static_text $IPINST -name peri_table_2_1 -parent $table -text "base: 0x10001000, size: 0x1000"]
  set_property cell_location 2,1 $row_2_1

  set row_3_0 [ipgui::add_static_text $IPINST -name peri_table_3_0 -parent $table -text "GPIO"]
  set_property cell_location 3,0 $row_3_0

  set row_3_1 [ipgui::add_static_text $IPINST -name peri_table_3_1 -parent $table -text "base: 0x10002000, size: 0x1000"]
  set_property cell_location 3,1 $row_3_1

}
