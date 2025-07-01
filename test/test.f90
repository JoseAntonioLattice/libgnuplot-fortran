program test

  use matlib
  use gnuplotlib
  
  use iso_fortran_env, only : dp => real64
  implicit none

  
  integer, parameter :: n = 101
  real(dp), dimension(n) :: x, y1, y2,y3

  type(gnuplot) :: plot1
  
  x = linspace(0.0_dp,10.0_dp,n)
  y1 = sin(x)
  y2 = cos(x)
  y3 = sin(x)**2


  plot1%title = [character(20) :: ]
  call plot1%set_options('set key right bottom;')
  call plot1%set_options('set title "Trigonometric functions";')
  call plot1%plot(x,y1,"sin(x)")
  call plot1%plot(x,y2)
  call plot1%plot(x,y3,"sin^2(x)")
  call plot1%show()

end program test
