onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib cl_design1_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {cl_design1.udo}

run -all

quit -force
