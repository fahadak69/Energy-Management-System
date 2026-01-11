# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\stch_\OneDrive\Xilinx_ZCU104\btmems_zcu104\btmzcu104_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\stch_\OneDrive\Xilinx_ZCU104\btmems_zcu104\btmzcu104_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {btmzcu104_wrapper}\
-hw {C:\Users\stch_\OneDrive\Xilinx_ZCU104\btmems_zcu104\zcu104_wrapper.xsa}\
-proc {psu_cortexa53} -os {linux} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {C:/Users/stch_/OneDrive/Xilinx_ZCU104/btmems_zcu104}

platform write
platform active {btmzcu104_wrapper}
domain active {zynqmp_pmufw}
bsp reload
bsp write
domain active {zynqmp_fsbl}
bsp reload
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
bsp write
bsp config extra_compiler_flags "-g -Wall -Wextra -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
platform active {btmzcu104_wrapper}
platform active {btmzcu104_wrapper}
domain create -name {standalone} -os {standalone} -proc {psu_cortexa53_0} -arch {64-bit} -display-name {standalone} -desc {} -runtime {cpp}
platform generate -domains 
domain -report -json
platform write
bsp reload
bsp setlib -name xilffs -ver 4.8
bsp removelib -name xilfpga
bsp setlib -name xilpm -ver 4.1
bsp removelib -name xilskey
bsp reload
domain remove standalone
platform generate -domains 
platform write
domain create -name {standalone} -os {standalone} -proc {psu_cortexa53_0} -arch {64-bit} -display-name {standalone} -desc {} -runtime {cpp}
platform generate -domains 
domain -report -json
platform write
bsp reload
bsp setlib -name xilffs -ver 4.8
bsp setlib -name xilpm -ver 4.1
bsp setlib -name xilsecure -ver 5.0
bsp write
bsp reload
catch {bsp regenerate}
domain active {zynqmp_pmufw}
bsp reload
bsp reload
platform clean
domain active {standalone}
catch {bsp regenerate}
domain active {zynqmp_pmufw}
catch {bsp regenerate}
domain active {zynqmp_fsbl}
bsp reload
catch {bsp regenerate}
platform active {btmzcu104_wrapper}
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {btmzcu104_wrapper}
bsp reload
bsp config use_trim "false"
bsp config use_trim "false"
bsp config word_access "true"
bsp config extra_compiler_flags "-g -Wall -Wextra -fno-tree-loop-distribute-patterns"
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone 
platform clean
platform generate
domain create -name {psu_pmu_0} -os {standalone} -proc {psu_pmu_0} -arch {32-bit} -display-name {psu_pmu_0} -desc {} -runtime {cpp}
platform generate -domains 
domain -report -json
platform write
domain active {zynqmp_pmufw}
bsp reload
bsp reload
platform generate -domains psu_pmu_0 
platform clean
platform generate
platform active {btmzcu104_wrapper}
domain active {standalone}
bsp reload
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone 
domain active {zynqmp_pmufw}
bsp reload
domain active {psu_pmu_0}
bsp reload
bsp config extra_compiler_flags "-g -ffunction-sections -fdata-sections -Wall -Wextra -Os -flto -ffat-lto-objects"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains psu_pmu_0 
bsp config extra_compiler_flags "-g -ffunction-sections -fdata-sections -Wall -Wextra -fno-tree-loop-distribute-patterns -Os -flto -ffat-lto-objects"
bsp write
bsp reload
catch {bsp regenerate}
domain active {standalone}
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone,psu_pmu_0 
domain active {psu_pmu_0}
bsp write
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform active {btmzcu104_wrapper}
platform active {btmzcu104_wrapper}
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/stch_/OneDrive/Xilinx_ZCU104/btmems_zcu104/zcu104_wrapper.xsa}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104_2022p2/btmems_zcu104/zcu104_wrapper.xsa}
platform generate
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104_2023p1/btmems_zcu104/zcu104_wrapper.xsa}
platform generate -domains 
platform generate
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
platform clean
platform clean
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
bsp reload
catch {bsp regenerate}
catch {bsp regenerate}
domain active {zynqmp_pmufw}
bsp reload
catch {bsp regenerate}
domain remove psu_pmu_0
platform write
domain remove standalone
platform generate -domains 
platform write
domain create -name {psu_pmu_0} -os {standalone} -proc {psu_cortexa53_0} -arch {64-bit} -display-name {psu_pmu_0} -desc {} -runtime {cpp}
platform generate -domains 
platform write
domain -report -json
domain remove psu_pmu_0
platform generate -domains 
platform write
domain create -name {psu_pmu_0} -os {standalone} -proc {psu_pmu_0} -arch {32-bit} -display-name {psu_pmu_0} -desc {} -runtime {cpp}
platform generate -domains 
domain -report -json
platform write
bsp reload
catch {bsp regenerate}
bsp write
domain create -name {standalone} -os {standalone} -proc {psu_cortexa53_0} -arch {64-bit} -display-name {standalone} -desc {} -runtime {cpp}
platform generate -domains 
domain -report -json
platform write
bsp reload
bsp setlib -name xilffs -ver 5.0
bsp setlib -name xilpm -ver 5.0
bsp setlib -name xilsecure -ver 5.1
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp write
bsp reload
catch {bsp regenerate}
domain active {zynqmp_fsbl}
bsp reload
catch {bsp regenerate}
platform clean
platform active {btmzcu104_wrapper}
domain active {psu_pmu_0}
bsp reload
bsp reload
domain active {standalone}
bsp reload
bsp reload
domain active {zynqmp_fsbl}
bsp reload
catch {bsp regenerate}
bsp write
catch {bsp regenerate}
bsp setdriver -ip psu_i2c_1 -driver iicps -ver 3.17
bsp write
bsp reload
catch {bsp regenerate}
domain active {zynqmp_pmufw}
bsp reload
catch {bsp regenerate}
bsp setdriver -ip psu_i2c_1 -driver iicps -ver 3.17
bsp write
bsp reload
catch {bsp regenerate}
domain active {psu_pmu_0}
bsp write
platform clean
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
platform generate
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
domain active {standalone}
bsp reload
bsp reload
platform generate -domains 
platform generate
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
platform generate -domains 
platform active {btmzcu104_wrapper}
platform active {btmzcu104_wrapper}
platform config -updatehw {C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu106_2023p1/btmems_zcu104/zcu106_wrapper.xsa}
platform generate
platform active {btmzcu104_wrapper}
bsp reload
domain active {zynqmp_fsbl}
bsp reload
platform generate -domains 
platform active {btmzcu104_wrapper}
domain active {psu_pmu_0}
bsp reload
bsp config device_series "XSK_FPGA_SERIES_ULTRA_PLUS"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains psu_pmu_0 
domain active {zynqmp_pmufw}
bsp reload
bsp reload
domain active {psu_pmu_0}
bsp reload
domain active {standalone}
bsp reload
bsp reload
domain active {zynqmp_fsbl}
bsp reload
bsp reload
domain active {psu_pmu_0}
bsp reload
domain active {standalone}
bsp config extra_compiler_flags "-g -Wall -Wextra -Os -flto -ffat-lto-objects -fno-tree-loop-distribute-patterns"
bsp reload
platform active {btmzcu104_wrapper}
platform generate
platform generate
platform active {btmzcu104_wrapper}
platform generate
platform generate
platform generate
