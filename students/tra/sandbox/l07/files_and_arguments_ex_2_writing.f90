! Program to create and write a file with the tables from exercise 1

module planet_module
    implicit none

    type :: planet
        character(len=10) :: name
        real :: a            ! semi-major axis in AU
        real :: period_years ! period in years
        real :: period_days  ! period in days
    end type planet

end module planet_module

program write_table
    use planet_module, only: planet
    use iso_fortran_env, only: real32
    implicit none

    integer :: i, u, open_status
    integer, parameter :: sp = real32
    integer, parameter :: days_to_seconds = 24*60*60
    character(len=256) :: file_name, msg
    type(planet), dimension(8) :: planets
    real(kind=sp) :: a_array(8) = [0.387_sp, 0.723_sp, 1.000_sp, &
                                   1.524_sp, 5.203_sp, 9.537_sp, & 
                                   19.191_sp, 30.069_sp]
    character(len=10) :: names(8) = [character(len=10) :: "Mercury", & 
                                     "Venus", "Earth", "Mars", "Jupiter", &
                                     "Saturn", "Uranus", "Neptune"]
    character(len=*), parameter :: row_fmt = "(a10, f12.3, f15.3, f15.2)" ! formatting of the data
    character(len=*), parameter :: header_fmt = "(a10, a12, a15, a15)" ! formatting of the labels

    ! setting the command line argument for file naming in the terminal
    
    ! first we must give a msg when the number of arguments given is not the correct one
    if (command_argument_count() /= 1) then
        print *, "Usage: ./files_and_arguments <file_name>"
        stop "Command line is not correct. Try again but input the file name as an argument in the command line."
    end if

    call get_command_argument(1, file_name)

    print *, "Writing table inside ", trim(file_name) 

    ! opening the file where the table is going to be written on
    open(newunit=u, file=file_name, status="new", action="write", iostat=open_status, iomsg=msg)
    if (open_status /= 0) stop "File could not be opened. Try again."

    ! assigning each of the planets and their characteristics to the array planets
    planets%name = names
    planets%a = a_array
    planets%period_years = planets%a**(3.0/2.0)
    planets%period_days = planets%period_years*365.25

    ! printing the header
    write(u, header_fmt) "Planet", "Axis (AU)", "Period (yrs)", "Period (days)"
    write (u, "(a)") repeat("-", 52) ! separator line

    ! do loop for pritning the data in the respective row format defined (must trim the names due to the defaulat length of 10 given in the names array)
    do i=1, size(names)
        write(u, row_fmt) trim(planets(i)%name), planets(i)%a, planets(i)%period_years, planets(i)%period_days
    end do
    
    close(u)

end program write_table