module gnuplotlib

  use number2string
  use iso_fortran_env, only : dp => real64
  implicit none
  
  type gnuplot
     character(:), allocatable :: options
     integer :: unit
     integer :: nplots = 0
     character(20), allocatable :: title(:)
   contains
     procedure :: set_options
     procedure :: plot
     procedure :: show
  end type gnuplot

contains
  
  subroutine set_options(this,string)
    class(gnuplot) :: this
    character(*), intent(in) :: string
    integer :: options_unit
    
    this%options = trim(this%options)//trim(string)
    
  end subroutine set_options

  subroutine plot(this,x,y,title)
    class(gnuplot) :: this
    real(dp), intent(in), dimension(:) :: x, y
    character(:),allocatable :: filename
    character(*), intent(in), optional :: title
    integer :: i, ou
    
    this%nplots = this%nplots + 1
    filename = "tmp"//int2str(this%nplots)//".dat"
    if(present(title))then
       this%title = [this%title, title]
    else
       this%title = [this%title, "plot "//int2str(this%nplots)]
    end if
    open(newunit=ou,file=filename)
    do i = 1, size(y)
       write(ou,*) x(i), y(i)
    end do
    close(ou)
  end subroutine plot

  subroutine show(this)
    class(gnuplot) :: this
    integer :: i
    character(:),allocatable :: command


    command = ''
    do i = 1, this%nplots
       command = command//"'"//trim(this%title(i))//"'"
    end do
        
    call execute_command_line("gnuplot -c plot.plt "//&
         int2str(this%nplots)//' "'//command//'"' )
    
  end subroutine show
  
end module gnuplotlib
