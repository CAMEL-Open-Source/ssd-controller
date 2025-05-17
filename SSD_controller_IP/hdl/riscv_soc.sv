/**
 * RISCV_SOC.sv
 * Copyright (C) 2021-2024 CAMELab
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * SPDX-License-Identifier: LGPL-3.0-or-later
 *
 * Copyright (C) 2019 CAMELab
 *
 * Author: Donghyun Gouk <kukdh1@camelab.org>
 */

`default_nettype wire

module DigitalTopWrapper(
  input sys_clock
  ,input sys_reset

  ,input          s_axi_fbus_aw_valid
  ,input  [  3:0] s_axi_fbus_aw_id
  ,input  [ 46:0] s_axi_fbus_aw_addr
  ,input  [  7:0] s_axi_fbus_aw_len
  ,input  [  2:0] s_axi_fbus_aw_size
  ,input  [  1:0] s_axi_fbus_aw_burst
  ,input          s_axi_fbus_aw_lock
  ,input  [  3:0] s_axi_fbus_aw_cache
  ,input  [  2:0] s_axi_fbus_aw_prot
  ,input  [  3:0] s_axi_fbus_aw_qos
  ,input          s_axi_fbus_w_valid
  ,input  [ 63:0] s_axi_fbus_w_data
  ,input  [  7:0] s_axi_fbus_w_strb
  ,input          s_axi_fbus_w_last
  ,input          s_axi_fbus_b_ready
  ,input          s_axi_fbus_ar_valid
  ,input  [  3:0] s_axi_fbus_ar_id
  ,input  [ 46:0] s_axi_fbus_ar_addr
  ,input  [  7:0] s_axi_fbus_ar_len
  ,input  [  2:0] s_axi_fbus_ar_size
  ,input  [  1:0] s_axi_fbus_ar_burst
  ,input          s_axi_fbus_ar_lock
  ,input  [  3:0] s_axi_fbus_ar_cache
  ,input  [  2:0] s_axi_fbus_ar_prot
  ,input  [  3:0] s_axi_fbus_ar_qos
  ,input          s_axi_fbus_r_ready
  ,output         s_axi_fbus_aw_ready
  ,output         s_axi_fbus_w_ready
  ,output         s_axi_fbus_b_valid
  ,output [  3:0] s_axi_fbus_b_id
  ,output [  1:0] s_axi_fbus_b_resp
  ,output         s_axi_fbus_ar_ready
  ,output         s_axi_fbus_r_valid
  ,output [  3:0] s_axi_fbus_r_id
  ,output [ 63:0] s_axi_fbus_r_data
  ,output [  1:0] s_axi_fbus_r_resp
  ,output         s_axi_fbus_r_last

  ,input          m_axi_dram_lo_aw_ready
  ,input          m_axi_dram_lo_w_ready
  ,input          m_axi_dram_lo_b_valid
  ,input  [  3:0] m_axi_dram_lo_b_id
  ,input  [  1:0] m_axi_dram_lo_b_resp
  ,input          m_axi_dram_lo_ar_ready
  ,input          m_axi_dram_lo_r_valid
  ,input  [  3:0] m_axi_dram_lo_r_id
  ,input  [ 63:0] m_axi_dram_lo_r_data
  ,input  [  1:0] m_axi_dram_lo_r_resp
  ,input          m_axi_dram_lo_r_last
  ,output         m_axi_dram_lo_aw_valid
  ,output [  3:0] m_axi_dram_lo_aw_id
  ,output [ 31:0] m_axi_dram_lo_aw_addr
  ,output [  7:0] m_axi_dram_lo_aw_len
  ,output [  2:0] m_axi_dram_lo_aw_size
  ,output [  1:0] m_axi_dram_lo_aw_burst
  ,output         m_axi_dram_lo_aw_lock
  ,output [  3:0] m_axi_dram_lo_aw_cache
  ,output [  2:0] m_axi_dram_lo_aw_prot
  ,output [  3:0] m_axi_dram_lo_aw_qos
  ,output         m_axi_dram_lo_w_valid
  ,output [ 63:0] m_axi_dram_lo_w_data
  ,output [  7:0] m_axi_dram_lo_w_strb
  ,output         m_axi_dram_lo_w_last
  ,output         m_axi_dram_lo_b_ready
  ,output         m_axi_dram_lo_ar_valid
  ,output [  3:0] m_axi_dram_lo_ar_id
  ,output [ 31:0] m_axi_dram_lo_ar_addr
  ,output [  7:0] m_axi_dram_lo_ar_len
  ,output [  2:0] m_axi_dram_lo_ar_size
  ,output [  1:0] m_axi_dram_lo_ar_burst
  ,output         m_axi_dram_lo_ar_lock
  ,output [  3:0] m_axi_dram_lo_ar_cache
  ,output [  2:0] m_axi_dram_lo_ar_prot
  ,output [  3:0] m_axi_dram_lo_ar_qos
  ,output         m_axi_dram_lo_r_ready

  ,input          m_axi_dram_hi_aw_ready
  ,input          m_axi_dram_hi_w_ready
  ,input          m_axi_dram_hi_b_valid
  ,input  [  3:0] m_axi_dram_hi_b_id
  ,input  [  1:0] m_axi_dram_hi_b_resp
  ,input          m_axi_dram_hi_ar_ready
  ,input          m_axi_dram_hi_r_valid
  ,input  [  3:0] m_axi_dram_hi_r_id
  ,input  [ 63:0] m_axi_dram_hi_r_data
  ,input  [  1:0] m_axi_dram_hi_r_resp
  ,input          m_axi_dram_hi_r_last
  ,output         m_axi_dram_hi_aw_valid
  ,output [  3:0] m_axi_dram_hi_aw_id
  ,output [ 46:0] m_axi_dram_hi_aw_addr
  ,output [  7:0] m_axi_dram_hi_aw_len
  ,output [  2:0] m_axi_dram_hi_aw_size
  ,output [  1:0] m_axi_dram_hi_aw_burst
  ,output         m_axi_dram_hi_aw_lock
  ,output [  3:0] m_axi_dram_hi_aw_cache
  ,output [  2:0] m_axi_dram_hi_aw_prot
  ,output [  3:0] m_axi_dram_hi_aw_qos
  ,output         m_axi_dram_hi_w_valid
  ,output [ 63:0] m_axi_dram_hi_w_data
  ,output [  7:0] m_axi_dram_hi_w_strb
  ,output         m_axi_dram_hi_w_last
  ,output         m_axi_dram_hi_b_ready
  ,output         m_axi_dram_hi_ar_valid
  ,output [  3:0] m_axi_dram_hi_ar_id
  ,output [ 46:0] m_axi_dram_hi_ar_addr
  ,output [  7:0] m_axi_dram_hi_ar_len
  ,output [  2:0] m_axi_dram_hi_ar_size
  ,output [  1:0] m_axi_dram_hi_ar_burst
  ,output         m_axi_dram_hi_ar_lock
  ,output [  3:0] m_axi_dram_hi_ar_cache
  ,output [  2:0] m_axi_dram_hi_ar_prot
  ,output [  3:0] m_axi_dram_hi_ar_qos
  ,output         m_axi_dram_hi_r_ready

  ,input          m_axi_mmio_lo_aw_ready
  ,input          m_axi_mmio_lo_w_ready
  ,input          m_axi_mmio_lo_b_valid
  ,input  [  3:0] m_axi_mmio_lo_b_id
  ,input  [  1:0] m_axi_mmio_lo_b_resp
  ,input          m_axi_mmio_lo_ar_ready
  ,input          m_axi_mmio_lo_r_valid
  ,input  [  3:0] m_axi_mmio_lo_r_id
  ,input  [ 63:0] m_axi_mmio_lo_r_data
  ,input  [  1:0] m_axi_mmio_lo_r_resp
  ,input          m_axi_mmio_lo_r_last
  ,output         m_axi_mmio_lo_aw_valid
  ,output [  3:0] m_axi_mmio_lo_aw_id
  ,output [ 30:0] m_axi_mmio_lo_aw_addr
  ,output [  7:0] m_axi_mmio_lo_aw_len
  ,output [  2:0] m_axi_mmio_lo_aw_size
  ,output [  1:0] m_axi_mmio_lo_aw_burst
  ,output         m_axi_mmio_lo_aw_lock
  ,output [  3:0] m_axi_mmio_lo_aw_cache
  ,output [  2:0] m_axi_mmio_lo_aw_prot
  ,output [  3:0] m_axi_mmio_lo_aw_qos
  ,output         m_axi_mmio_lo_w_valid
  ,output [ 63:0] m_axi_mmio_lo_w_data
  ,output [  7:0] m_axi_mmio_lo_w_strb
  ,output         m_axi_mmio_lo_w_last
  ,output         m_axi_mmio_lo_b_ready
  ,output         m_axi_mmio_lo_ar_valid
  ,output [  3:0] m_axi_mmio_lo_ar_id
  ,output [ 30:0] m_axi_mmio_lo_ar_addr
  ,output [  7:0] m_axi_mmio_lo_ar_len
  ,output [  2:0] m_axi_mmio_lo_ar_size
  ,output [  1:0] m_axi_mmio_lo_ar_burst
  ,output         m_axi_mmio_lo_ar_lock
  ,output [  3:0] m_axi_mmio_lo_ar_cache
  ,output [  2:0] m_axi_mmio_lo_ar_prot
  ,output [  3:0] m_axi_mmio_lo_ar_qos
  ,output         m_axi_mmio_lo_r_ready

  ,input          m_axi_mmio_hi_aw_ready
  ,input          m_axi_mmio_hi_w_ready
  ,input          m_axi_mmio_hi_b_valid
  ,input  [  3:0] m_axi_mmio_hi_b_id
  ,input  [  1:0] m_axi_mmio_hi_b_resp
  ,input          m_axi_mmio_hi_ar_ready
  ,input          m_axi_mmio_hi_r_valid
  ,input  [  3:0] m_axi_mmio_hi_r_id
  ,input  [ 63:0] m_axi_mmio_hi_r_data
  ,input  [  1:0] m_axi_mmio_hi_r_resp
  ,input          m_axi_mmio_hi_r_last
  ,output         m_axi_mmio_hi_aw_valid
  ,output [  3:0] m_axi_mmio_hi_aw_id
  ,output [ 35:0] m_axi_mmio_hi_aw_addr
  ,output [  7:0] m_axi_mmio_hi_aw_len
  ,output [  2:0] m_axi_mmio_hi_aw_size
  ,output [  1:0] m_axi_mmio_hi_aw_burst
  ,output         m_axi_mmio_hi_aw_lock
  ,output [  3:0] m_axi_mmio_hi_aw_cache
  ,output [  2:0] m_axi_mmio_hi_aw_prot
  ,output [  3:0] m_axi_mmio_hi_aw_qos
  ,output         m_axi_mmio_hi_w_valid
  ,output [ 63:0] m_axi_mmio_hi_w_data
  ,output [  7:0] m_axi_mmio_hi_w_strb
  ,output         m_axi_mmio_hi_w_last
  ,output         m_axi_mmio_hi_b_ready
  ,output         m_axi_mmio_hi_ar_valid
  ,output [  3:0] m_axi_mmio_hi_ar_id
  ,output [ 35:0] m_axi_mmio_hi_ar_addr
  ,output [  7:0] m_axi_mmio_hi_ar_len
  ,output [  2:0] m_axi_mmio_hi_ar_size
  ,output [  1:0] m_axi_mmio_hi_ar_burst
  ,output         m_axi_mmio_hi_ar_lock
  ,output [  3:0] m_axi_mmio_hi_ar_cache
  ,output [  2:0] m_axi_mmio_hi_ar_prot
  ,output [  3:0] m_axi_mmio_hi_ar_qos
  ,output         m_axi_mmio_hi_r_ready

  ,input          uart_rxd
  ,output         uart_txd

  ,output sdio_spi_sck
  ,output sdio_spi_cs
  ,output sdio_spi_mosi
  ,input  sdio_spi_miso

  ,input gpio_0_ival
  ,input gpio_1_ival
  ,input gpio_2_ival
  ,input gpio_3_ival
  ,output gpio_0_oval
  ,output gpio_0_oe
  ,output gpio_0_ie
  ,output gpio_1_oval
  ,output gpio_1_oe
  ,output gpio_1_ie
  ,output gpio_2_oval
  ,output gpio_2_oe
  ,output gpio_2_ie
  ,output gpio_3_oval
  ,output gpio_3_oe
  ,output gpio_3_ie
);

  /* Wire/Reg definitions */

  wire implicit_clock_clock;
  wire implicit_clock_reset;

  reg  spi_miso_buffer_0;
  reg  spi_miso_buffer_1;

  /* Modules */


  /* Digital Top instantiation */

  CAMELDigitalTop top (
     .clock(implicit_clock_clock)
    ,.reset(implicit_clock_reset)
    ,.auto_implicitClockGrouper_out_clock(implicit_clock_clock)
    ,.auto_implicitClockGrouper_out_reset(implicit_clock_reset)
    ,.auto_prci_ctrl_domain_reset_setter_clock_in_member_allClocks_uncore_clock(sys_clock)
    ,.auto_prci_ctrl_domain_reset_setter_clock_in_member_allClocks_uncore_reset(sys_reset)

    ,.l2_frontend_bus_axi4_0_aw_valid(s_axi_fbus_aw_valid)
    ,.l2_frontend_bus_axi4_0_aw_bits_id(s_axi_fbus_aw_id)
    ,.l2_frontend_bus_axi4_0_aw_bits_addr(s_axi_fbus_aw_addr)
    ,.l2_frontend_bus_axi4_0_aw_bits_len(s_axi_fbus_aw_len)
    ,.l2_frontend_bus_axi4_0_aw_bits_size(s_axi_fbus_aw_size)
    ,.l2_frontend_bus_axi4_0_aw_bits_burst(s_axi_fbus_aw_burst)
    ,.l2_frontend_bus_axi4_0_aw_bits_lock(s_axi_fbus_aw_lock)
    ,.l2_frontend_bus_axi4_0_aw_bits_cache(s_axi_fbus_aw_cache)
    ,.l2_frontend_bus_axi4_0_aw_bits_prot(s_axi_fbus_aw_prot)
    ,.l2_frontend_bus_axi4_0_aw_bits_qos(s_axi_fbus_aw_qos)
    ,.l2_frontend_bus_axi4_0_w_valid(s_axi_fbus_w_valid)
    ,.l2_frontend_bus_axi4_0_w_bits_data(s_axi_fbus_w_data)
    ,.l2_frontend_bus_axi4_0_w_bits_strb(s_axi_fbus_w_strb)
    ,.l2_frontend_bus_axi4_0_w_bits_last(s_axi_fbus_w_last)
    ,.l2_frontend_bus_axi4_0_b_ready(s_axi_fbus_b_ready)
    ,.l2_frontend_bus_axi4_0_ar_valid(s_axi_fbus_ar_valid)
    ,.l2_frontend_bus_axi4_0_ar_bits_id(s_axi_fbus_ar_id)
    ,.l2_frontend_bus_axi4_0_ar_bits_addr(s_axi_fbus_ar_addr)
    ,.l2_frontend_bus_axi4_0_ar_bits_len(s_axi_fbus_ar_len)
    ,.l2_frontend_bus_axi4_0_ar_bits_size(s_axi_fbus_ar_size)
    ,.l2_frontend_bus_axi4_0_ar_bits_burst(s_axi_fbus_ar_burst)
    ,.l2_frontend_bus_axi4_0_ar_bits_lock(s_axi_fbus_ar_lock)
    ,.l2_frontend_bus_axi4_0_ar_bits_cache(s_axi_fbus_ar_cache)
    ,.l2_frontend_bus_axi4_0_ar_bits_prot(s_axi_fbus_ar_prot)
    ,.l2_frontend_bus_axi4_0_ar_bits_qos(s_axi_fbus_ar_qos)
    ,.l2_frontend_bus_axi4_0_r_ready(s_axi_fbus_r_ready)
    ,.l2_frontend_bus_axi4_0_aw_ready(s_axi_fbus_aw_ready)
    ,.l2_frontend_bus_axi4_0_w_ready(s_axi_fbus_w_ready)
    ,.l2_frontend_bus_axi4_0_b_valid(s_axi_fbus_b_valid)
    ,.l2_frontend_bus_axi4_0_b_bits_id(s_axi_fbus_b_id)
    ,.l2_frontend_bus_axi4_0_b_bits_resp(s_axi_fbus_b_resp)
    ,.l2_frontend_bus_axi4_0_ar_ready(s_axi_fbus_ar_ready)
    ,.l2_frontend_bus_axi4_0_r_valid(s_axi_fbus_r_valid)
    ,.l2_frontend_bus_axi4_0_r_bits_id(s_axi_fbus_r_id)
    ,.l2_frontend_bus_axi4_0_r_bits_data(s_axi_fbus_r_data)
    ,.l2_frontend_bus_axi4_0_r_bits_resp(s_axi_fbus_r_resp)
    ,.l2_frontend_bus_axi4_0_r_bits_last(s_axi_fbus_r_last)

    ,.mem_axi4_0_aw_ready(m_axi_dram_lo_aw_ready)
    ,.mem_axi4_0_w_ready(m_axi_dram_lo_w_ready)
    ,.mem_axi4_0_b_valid(m_axi_dram_lo_b_valid)
    ,.mem_axi4_0_b_bits_id(m_axi_dram_lo_b_id)
    ,.mem_axi4_0_b_bits_resp(m_axi_dram_lo_b_resp)
    ,.mem_axi4_0_ar_ready(m_axi_dram_lo_ar_ready)
    ,.mem_axi4_0_r_valid(m_axi_dram_lo_r_valid)
    ,.mem_axi4_0_r_bits_id(m_axi_dram_lo_r_id)
    ,.mem_axi4_0_r_bits_data(m_axi_dram_lo_r_data)
    ,.mem_axi4_0_r_bits_resp(m_axi_dram_lo_r_resp)
    ,.mem_axi4_0_r_bits_last(m_axi_dram_lo_r_last)
    ,.mem_axi4_0_aw_valid(m_axi_dram_lo_aw_valid)
    ,.mem_axi4_0_aw_bits_id(m_axi_dram_lo_aw_id)
    ,.mem_axi4_0_aw_bits_addr(m_axi_dram_lo_aw_addr)
    ,.mem_axi4_0_aw_bits_len(m_axi_dram_lo_aw_len)
    ,.mem_axi4_0_aw_bits_size(m_axi_dram_lo_aw_size)
    ,.mem_axi4_0_aw_bits_burst(m_axi_dram_lo_aw_burst)
    ,.mem_axi4_0_aw_bits_lock(m_axi_dram_lo_aw_lock)
    ,.mem_axi4_0_aw_bits_cache(m_axi_dram_lo_aw_cache)
    ,.mem_axi4_0_aw_bits_prot(m_axi_dram_lo_aw_prot)
    ,.mem_axi4_0_aw_bits_qos(m_axi_dram_lo_aw_qos)
    ,.mem_axi4_0_w_valid(m_axi_dram_lo_w_valid)
    ,.mem_axi4_0_w_bits_data(m_axi_dram_lo_w_data)
    ,.mem_axi4_0_w_bits_strb(m_axi_dram_lo_w_strb)
    ,.mem_axi4_0_w_bits_last(m_axi_dram_lo_w_last)
    ,.mem_axi4_0_b_ready(m_axi_dram_lo_b_ready)
    ,.mem_axi4_0_ar_valid(m_axi_dram_lo_ar_valid)
    ,.mem_axi4_0_ar_bits_id(m_axi_dram_lo_ar_id)
    ,.mem_axi4_0_ar_bits_addr(m_axi_dram_lo_ar_addr)
    ,.mem_axi4_0_ar_bits_len(m_axi_dram_lo_ar_len)
    ,.mem_axi4_0_ar_bits_size(m_axi_dram_lo_ar_size)
    ,.mem_axi4_0_ar_bits_burst(m_axi_dram_lo_ar_burst)
    ,.mem_axi4_0_ar_bits_lock(m_axi_dram_lo_ar_lock)
    ,.mem_axi4_0_ar_bits_cache(m_axi_dram_lo_ar_cache)
    ,.mem_axi4_0_ar_bits_prot(m_axi_dram_lo_ar_prot)
    ,.mem_axi4_0_ar_bits_qos(m_axi_dram_lo_ar_qos)
    ,.mem_axi4_0_r_ready(m_axi_dram_lo_r_ready)

    ,.mem_axi4_sec_0_aw_ready(m_axi_dram_hi_aw_ready)
    ,.mem_axi4_sec_0_w_ready(m_axi_dram_hi_w_ready)
    ,.mem_axi4_sec_0_b_valid(m_axi_dram_hi_b_valid)
    ,.mem_axi4_sec_0_b_bits_id(m_axi_dram_hi_b_id)
    ,.mem_axi4_sec_0_b_bits_resp(m_axi_dram_hi_b_resp)
    ,.mem_axi4_sec_0_ar_ready(m_axi_dram_hi_ar_ready)
    ,.mem_axi4_sec_0_r_valid(m_axi_dram_hi_r_valid)
    ,.mem_axi4_sec_0_r_bits_id(m_axi_dram_hi_r_id)
    ,.mem_axi4_sec_0_r_bits_data(m_axi_dram_hi_r_data)
    ,.mem_axi4_sec_0_r_bits_resp(m_axi_dram_hi_r_resp)
    ,.mem_axi4_sec_0_r_bits_last(m_axi_dram_hi_r_last)
    ,.mem_axi4_sec_0_aw_valid(m_axi_dram_hi_aw_valid)
    ,.mem_axi4_sec_0_aw_bits_id(m_axi_dram_hi_aw_id)
    ,.mem_axi4_sec_0_aw_bits_addr(m_axi_dram_hi_aw_addr)
    ,.mem_axi4_sec_0_aw_bits_len(m_axi_dram_hi_aw_len)
    ,.mem_axi4_sec_0_aw_bits_size(m_axi_dram_hi_aw_size)
    ,.mem_axi4_sec_0_aw_bits_burst(m_axi_dram_hi_aw_burst)
    ,.mem_axi4_sec_0_aw_bits_lock(m_axi_dram_hi_aw_lock)
    ,.mem_axi4_sec_0_aw_bits_cache(m_axi_dram_hi_aw_cache)
    ,.mem_axi4_sec_0_aw_bits_prot(m_axi_dram_hi_aw_prot)
    ,.mem_axi4_sec_0_aw_bits_qos(m_axi_dram_hi_aw_qos)
    ,.mem_axi4_sec_0_w_valid(m_axi_dram_hi_w_valid)
    ,.mem_axi4_sec_0_w_bits_data(m_axi_dram_hi_w_data)
    ,.mem_axi4_sec_0_w_bits_strb(m_axi_dram_hi_w_strb)
    ,.mem_axi4_sec_0_w_bits_last(m_axi_dram_hi_w_last)
    ,.mem_axi4_sec_0_b_ready(m_axi_dram_hi_b_ready)
    ,.mem_axi4_sec_0_ar_valid(m_axi_dram_hi_ar_valid)
    ,.mem_axi4_sec_0_ar_bits_id(m_axi_dram_hi_ar_id)
    ,.mem_axi4_sec_0_ar_bits_addr(m_axi_dram_hi_ar_addr)
    ,.mem_axi4_sec_0_ar_bits_len(m_axi_dram_hi_ar_len)
    ,.mem_axi4_sec_0_ar_bits_size(m_axi_dram_hi_ar_size)
    ,.mem_axi4_sec_0_ar_bits_burst(m_axi_dram_hi_ar_burst)
    ,.mem_axi4_sec_0_ar_bits_lock(m_axi_dram_hi_ar_lock)
    ,.mem_axi4_sec_0_ar_bits_cache(m_axi_dram_hi_ar_cache)
    ,.mem_axi4_sec_0_ar_bits_prot(m_axi_dram_hi_ar_prot)
    ,.mem_axi4_sec_0_ar_bits_qos(m_axi_dram_hi_ar_qos)
    ,.mem_axi4_sec_0_r_ready(m_axi_dram_hi_r_ready)

    ,.mmio_axi4_0_aw_ready(m_axi_mmio_lo_aw_ready)
    ,.mmio_axi4_0_w_ready(m_axi_mmio_lo_w_ready)
    ,.mmio_axi4_0_b_valid(m_axi_mmio_lo_b_valid)
    ,.mmio_axi4_0_b_bits_id(m_axi_mmio_lo_b_id)
    ,.mmio_axi4_0_b_bits_resp(m_axi_mmio_lo_b_resp)
    ,.mmio_axi4_0_ar_ready(m_axi_mmio_lo_ar_ready)
    ,.mmio_axi4_0_r_valid(m_axi_mmio_lo_r_valid)
    ,.mmio_axi4_0_r_bits_id(m_axi_mmio_lo_r_id)
    ,.mmio_axi4_0_r_bits_data(m_axi_mmio_lo_r_data)
    ,.mmio_axi4_0_r_bits_resp(m_axi_mmio_lo_r_resp)
    ,.mmio_axi4_0_r_bits_last(m_axi_mmio_lo_r_last)
    ,.mmio_axi4_0_aw_valid(m_axi_mmio_lo_aw_valid)
    ,.mmio_axi4_0_aw_bits_id(m_axi_mmio_lo_aw_id)
    ,.mmio_axi4_0_aw_bits_addr(m_axi_mmio_lo_aw_addr)
    ,.mmio_axi4_0_aw_bits_len(m_axi_mmio_lo_aw_len)
    ,.mmio_axi4_0_aw_bits_size(m_axi_mmio_lo_aw_size)
    ,.mmio_axi4_0_aw_bits_burst(m_axi_mmio_lo_aw_burst)
    ,.mmio_axi4_0_aw_bits_lock(m_axi_mmio_lo_aw_lock)
    ,.mmio_axi4_0_aw_bits_cache(m_axi_mmio_lo_aw_cache)
    ,.mmio_axi4_0_aw_bits_prot(m_axi_mmio_lo_aw_prot)
    ,.mmio_axi4_0_aw_bits_qos(m_axi_mmio_lo_aw_qos)
    ,.mmio_axi4_0_w_valid(m_axi_mmio_lo_w_valid)
    ,.mmio_axi4_0_w_bits_data(m_axi_mmio_lo_w_data)
    ,.mmio_axi4_0_w_bits_strb(m_axi_mmio_lo_w_strb)
    ,.mmio_axi4_0_w_bits_last(m_axi_mmio_lo_w_last)
    ,.mmio_axi4_0_b_ready(m_axi_mmio_lo_b_ready)
    ,.mmio_axi4_0_ar_valid(m_axi_mmio_lo_ar_valid)
    ,.mmio_axi4_0_ar_bits_id(m_axi_mmio_lo_ar_id)
    ,.mmio_axi4_0_ar_bits_addr(m_axi_mmio_lo_ar_addr)
    ,.mmio_axi4_0_ar_bits_len(m_axi_mmio_lo_ar_len)
    ,.mmio_axi4_0_ar_bits_size(m_axi_mmio_lo_ar_size)
    ,.mmio_axi4_0_ar_bits_burst(m_axi_mmio_lo_ar_burst)
    ,.mmio_axi4_0_ar_bits_lock(m_axi_mmio_lo_ar_lock)
    ,.mmio_axi4_0_ar_bits_cache(m_axi_mmio_lo_ar_cache)
    ,.mmio_axi4_0_ar_bits_prot(m_axi_mmio_lo_ar_prot)
    ,.mmio_axi4_0_ar_bits_qos(m_axi_mmio_lo_ar_qos)
    ,.mmio_axi4_0_r_ready(m_axi_mmio_lo_r_ready)

    ,.mmio_axi4_sec_0_aw_ready(m_axi_mmio_hi_aw_ready)
    ,.mmio_axi4_sec_0_w_ready(m_axi_mmio_hi_w_ready)
    ,.mmio_axi4_sec_0_b_valid(m_axi_mmio_hi_b_valid)
    ,.mmio_axi4_sec_0_b_bits_id(m_axi_mmio_hi_b_id)
    ,.mmio_axi4_sec_0_b_bits_resp(m_axi_mmio_hi_b_resp)
    ,.mmio_axi4_sec_0_ar_ready(m_axi_mmio_hi_ar_ready)
    ,.mmio_axi4_sec_0_r_valid(m_axi_mmio_hi_r_valid)
    ,.mmio_axi4_sec_0_r_bits_id(m_axi_mmio_hi_r_id)
    ,.mmio_axi4_sec_0_r_bits_data(m_axi_mmio_hi_r_data)
    ,.mmio_axi4_sec_0_r_bits_resp(m_axi_mmio_hi_r_resp)
    ,.mmio_axi4_sec_0_r_bits_last(m_axi_mmio_hi_r_last)
    ,.mmio_axi4_sec_0_aw_valid(m_axi_mmio_hi_aw_valid)
    ,.mmio_axi4_sec_0_aw_bits_id(m_axi_mmio_hi_aw_id)
    ,.mmio_axi4_sec_0_aw_bits_addr(m_axi_mmio_hi_aw_addr)
    ,.mmio_axi4_sec_0_aw_bits_len(m_axi_mmio_hi_aw_len)
    ,.mmio_axi4_sec_0_aw_bits_size(m_axi_mmio_hi_aw_size)
    ,.mmio_axi4_sec_0_aw_bits_burst(m_axi_mmio_hi_aw_burst)
    ,.mmio_axi4_sec_0_aw_bits_lock(m_axi_mmio_hi_aw_lock)
    ,.mmio_axi4_sec_0_aw_bits_cache(m_axi_mmio_hi_aw_cache)
    ,.mmio_axi4_sec_0_aw_bits_prot(m_axi_mmio_hi_aw_prot)
    ,.mmio_axi4_sec_0_aw_bits_qos(m_axi_mmio_hi_aw_qos)
    ,.mmio_axi4_sec_0_w_valid(m_axi_mmio_hi_w_valid)
    ,.mmio_axi4_sec_0_w_bits_data(m_axi_mmio_hi_w_data)
    ,.mmio_axi4_sec_0_w_bits_strb(m_axi_mmio_hi_w_strb)
    ,.mmio_axi4_sec_0_w_bits_last(m_axi_mmio_hi_w_last)
    ,.mmio_axi4_sec_0_b_ready(m_axi_mmio_hi_b_ready)
    ,.mmio_axi4_sec_0_ar_valid(m_axi_mmio_hi_ar_valid)
    ,.mmio_axi4_sec_0_ar_bits_id(m_axi_mmio_hi_ar_id)
    ,.mmio_axi4_sec_0_ar_bits_addr(m_axi_mmio_hi_ar_addr)
    ,.mmio_axi4_sec_0_ar_bits_len(m_axi_mmio_hi_ar_len)
    ,.mmio_axi4_sec_0_ar_bits_size(m_axi_mmio_hi_ar_size)
    ,.mmio_axi4_sec_0_ar_bits_burst(m_axi_mmio_hi_ar_burst)
    ,.mmio_axi4_sec_0_ar_bits_lock(m_axi_mmio_hi_ar_lock)
    ,.mmio_axi4_sec_0_ar_bits_cache(m_axi_mmio_hi_ar_cache)
    ,.mmio_axi4_sec_0_ar_bits_prot(m_axi_mmio_hi_ar_prot)
    ,.mmio_axi4_sec_0_ar_bits_qos(m_axi_mmio_hi_ar_qos)
    ,.mmio_axi4_sec_0_r_ready(m_axi_mmio_hi_r_ready)

    ,.uart_0_rxd(uart_rxd)
    ,.uart_0_txd(uart_txd)

    ,.spi_0_sck    (sdio_spi_sck)
    ,.spi_0_dq_0_i (1'b0)
    ,.spi_0_dq_0_o (sdio_spi_mosi)
    ,.spi_0_dq_0_ie()
    ,.spi_0_dq_0_oe()
    ,.spi_0_dq_1_i (spi_miso_buffer_1)
    ,.spi_0_dq_1_o ()
    ,.spi_0_dq_1_ie()
    ,.spi_0_dq_1_oe()
    ,.spi_0_dq_2_i (1'b0)
    ,.spi_0_dq_2_o ()
    ,.spi_0_dq_2_ie()
    ,.spi_0_dq_2_oe()
    ,.spi_0_dq_3_i (1'b0)
    ,.spi_0_dq_3_o ()
    ,.spi_0_dq_3_ie()
    ,.spi_0_dq_3_oe()
    ,.spi_0_cs_0   (sdio_spi_cs)

    ,.gpio_0_pins_0_i_ival(gpio_0_ival)
    ,.gpio_0_pins_0_o_oval(gpio_0_oval)
    ,.gpio_0_pins_0_o_oe(gpio_0_oe)
    ,.gpio_0_pins_0_o_ie(gpio_0_ie)
    ,.gpio_0_pins_0_o_pue()
    ,.gpio_0_pins_0_o_ds()
    ,.gpio_0_pins_0_o_ds1()
    ,.gpio_0_pins_0_o_poe()
    ,.gpio_0_pins_1_i_ival(gpio_1_ival)
    ,.gpio_0_pins_1_o_oval(gpio_1_oval)
    ,.gpio_0_pins_1_o_oe(gpio_1_oe)
    ,.gpio_0_pins_1_o_ie(gpio_1_ie)
    ,.gpio_0_pins_1_o_pue()
    ,.gpio_0_pins_1_o_ds()
    ,.gpio_0_pins_1_o_ds1()
    ,.gpio_0_pins_1_o_poe()
    ,.gpio_0_pins_2_i_ival(gpio_2_ival)
    ,.gpio_0_pins_2_o_oval(gpio_2_oval)
    ,.gpio_0_pins_2_o_oe(gpio_2_oe)
    ,.gpio_0_pins_2_o_ie(gpio_2_ie)
    ,.gpio_0_pins_2_o_pue()
    ,.gpio_0_pins_2_o_ds()
    ,.gpio_0_pins_2_o_ds1()
    ,.gpio_0_pins_2_o_poe()
    ,.gpio_0_pins_3_i_ival(gpio_3_ival)
    ,.gpio_0_pins_3_o_oval(gpio_3_oval)
    ,.gpio_0_pins_3_o_oe(gpio_3_oe)
    ,.gpio_0_pins_3_o_ie(gpio_3_ie)
    ,.gpio_0_pins_3_o_pue()
    ,.gpio_0_pins_3_o_ds()
    ,.gpio_0_pins_3_o_ds1()
    ,.gpio_0_pins_3_o_poe()
  );

  /* FSMs and assignments */

  always @(posedge sys_clock) begin
    spi_miso_buffer_0 <= sdio_spi_miso;
    spi_miso_buffer_1 <= spi_miso_buffer_0;
  end

endmodule

module AsyncResetSynchronizer (
  input  clock,
  input  reset,
  input  io_d,
  output io_q
);
  reg sync_0;
  reg sync_1;
  reg sync_2;

  assign io_q = sync_0;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      sync_0 <= 1'h0;
      sync_1 <= 1'h0;
      sync_2 <= 1'h0;
    end else begin
      sync_0 <= sync_1;
      sync_1 <= sync_2;
      sync_2 <= io_d;
    end
  end
endmodule
