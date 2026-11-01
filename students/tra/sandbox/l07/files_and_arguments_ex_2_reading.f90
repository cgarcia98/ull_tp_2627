! Program to read the data from a file, calculate and print some output
! In this case we are going to read the planets table file skipping the header and storing the data into allcocatable arrays for
! a posterior printing of the mean period of the planets

program read_table
    use iso_fortran_env, only: iostat_end, error_unit
    implicit none

    integer :: i, u, n, read_status, open_status, all_stat, rew_stat, open_status_planet, t, t_steps
    real, parameter :: pi = 3.14159
    real :: mean_period_yrs, x, y
    logical :: found
    character(len=256) :: prefix, suffix
    character(len=256) :: file_name, arg, planet_file
    character(len=*), parameter :: lbl_fmt = "(a8, a12, a12)"
    character(len=*), parameter :: wrt_fmt = "(i3, f16.4, f13.4)"
    real, dimension(:), allocatable :: a, period_years, period_days
    character(len=:), allocatable :: names(:)

    ! first we must give a msg when the number of arguments given is not the correct one
    if (command_argument_count() /= 2) then
        print *, "Usage: ./files_and_arguments <file_name> <t_steps>"
        stop "Command line is not correct. & 
              & Try again but input the file name as an argument in the command line and the numbe of time steps."
    end if

    call get_command_argument(1, file_name)

    print *, "Reading table inside ", trim(file_name) 

    ! see if the file exists and if not report to error_unit (cosntant of iso_fortran_env module)
    inquire(file=file_name, exist=found)
    if (.not. found) then
        write (error_unit, "(a)") "Error: input file was not found."
        stop "Try again."
    else
        print *, "Found input file."
    end if

    ! opening the file
    open(newunit=u, file=file_name, action="read", iostat=open_status)
    if (open_status /= 0) stop "The file could not be opened."
    n = -2 ! skipping the header and the separation line (---) below the header

    ! retieving the number of lines inside the file
    do
        read(unit=u, fmt=*, iostat=read_status) 
        if (read_status == iostat_end) exit
        n = n+1
    end do

    ! allcoation of the arrays and the array of names (the latter is an array of strings)
    allocate(a(n), period_years(n), period_days(n))

    allocate(character(len=10) :: names(n), stat=all_stat)
    if (all_stat > 0) stop "Dynamics string could not be allocated." 

    ! starting again from the beginning of the file, skipping the header and separation line and reading the values for storage
    rewind(unit=u, iostat=rew_stat)
    read(u, *)
    read(u, *)

    do i=1, n
        read (u, *) names(i), a(i), period_years(i), period_days(i)
    end do

    ! calcualting the mean period of the array
    mean_period_yrs = sum(period_years)/size(period_years)

    print *, "The mean period of the planets in years is: ", mean_period_yrs, " [yrs]."

    close(u)

    ! writing the positions of the orbit (x, y) of each planet into their own planet file
    call get_command_argument(2, arg)
    read (arg, *) t_steps

    ! suffix and prefix of the planets filenames, which are going to be named sequentially
    prefix = "orbit_"
    suffix = ".dat"
    
    do i=1, n
        ! open file and write action
        write (planet_file, fmt="(a, i1, a)") trim(prefix), i, trim(suffix)
        open(unit=i, file=planet_file, form="formatted", action="write", status="new", iostat=open_status_planet) 
        if (open_status_planet /= 0) stop "Planet file could not be opened for writing. Try again."

        write (i, lbl_fmt) "Timestep ", "x (AU) ", "y (AU)"

        do t=1, t_steps
            x = a(i)*cos(2.0*pi*0.01*t*period_years(i)/period_years(i))
            y = a(i)*sin(2.0*pi*0.01*t*period_years(i)/period_years(i))
            write (i, wrt_fmt) t, x, y
        end do
        close(i) ! close each created file
    end do

end program read_table