@echo  Creation exe file for Pm
call gnatbl -o  %1  %1.ali %2 %3 %4 %5 %6 %7 %8 %9
call emxbind -bp -d%1.def -r%1.res d:\gnat30\bin\emxl %1
del %1
