
# XM-Sim Command File
# TOOL:	xmsim(64)	22.03-s012
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
set vcd_compact_mode 0
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_uart_rx.baud_tick tb_uart_rx.clk tb_uart_rx.data tb_uart_rx.frame_err tb_uart_rx.os_tick tb_uart_rx.overrun_err tb_uart_rx.parity_err tb_uart_rx.rst_n tb_uart_rx.rx tb_uart_rx.rx_data tb_uart_rx.rx_empty tb_uart_rx.rx_full tb_uart_rx.rx_ready tb_uart_rx.rx_valid tb_uart_rx.u_rx.rx_sync2 tb_uart_rx.u_rx.rx_sync1 tb_uart_rx.u_rx.rx_sync0 tb_uart_rx.u_rx.vote_7 tb_uart_rx.u_rx.vote_8 tb_uart_rx.u_rx.vote_result tb_uart_rx.u_rx.vote_sample_tick tb_uart_rx.u_rx.state tb_uart_rx.u_rx.sampling_cnt tb_uart_rx.u_rx.next_state

simvision -input /home/hah001/Basic_SoC_Implementation/1_RTL/2_TINY_PROJECT/Protocol/UART/UART_RX/.simvision/253183_hah001_kopo-seongnam_autosave.tcl.svcf
