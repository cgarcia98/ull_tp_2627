! Program to practice a bit with formatted output in the context of planetary physics
! We will print as output the values of semi-major axis, period in days and years and the name of each planet in our solar system

! here we will solve the exercise by using a derived type which we will import from a module
module planet_module
    implicit none

    type :: planet
        character(len=10) :: name
        real :: a            ! semi-major axis in AU
        real :: period_years ! period in years
        real :: period_days  ! period in days
    end type planet

end module planet_module

program formatted_print
    use planet_module, only: planet
    use iso_fortran_env, only: real32
    implicit none

    integer :: i
    integer, parameter :: sp = real32
    integer, parameter :: days_to_seconds = 24*60*60
    type(planet), dimension(8) :: planets
    real(kind=sp) :: a_array(8) = [0.387_sp, 0.723_sp, 1.000_sp, &
                                   1.524_sp, 5.203_sp, 9.537_sp, & 
                                   19.191_sp, 30.069_sp]
    character(len=10) :: names(8) = [character(len=10) :: "Mercury", & 
                                     "Venus", "Earth", "Mars", "Jupiter", &
                                     "Saturn", "Uranus", "Neptune"]
    character(len=*), parameter :: row_fmt = "(a10, f12.3, f15.3, f15.2)" ! formatting of the data
    character(len=*), parameter :: header_fmt = "(a10, a12, a15, a15)" ! formatting of the labels

    ! assigning each of the planets and their characteristics to the array planets
    planets%name = names
    planets%a = a_array
    planets%period_years = planets%a**(3.0/2.0)
    planets%period_days = planets%period_years*365.25

    ! printing the header
    write(*, header_fmt) "Planet", "Axis (AU)", "Period (yrs)", "Period (days)"
    print *, repeat("-", 52) ! separator line

    ! do loop for pritning the data in the respective row format defined (must trim the names due to the defaulat length of 10 given in the names array)
    do i=1, size(names)
        write(*, row_fmt) trim(planets(i)%name), planets(i)%a, planets(i)%period_years, planets(i)%period_days
    end do

    ! now we are going to print the periods in seconds with the formats (f, es, g0)
    print *
    print *, "Formatting of the periods in seconds:"
    write (*, "(a, 8f15.2)") "Decimal f format:", planets%period_days*days_to_seconds
    write (*, "(a, 8es15.2)") "Scientific notation format:", planets%period_days*days_to_seconds
    write (*, "(a, 8g0)") "Minimal width g0 format:", planets%period_days*days_to_seconds

    ! making now one field too narrow (symbols appear and the correct printing of the value is not properly carried out)
    print *
    print *, "Now making a field too narrow"
    write (*, "(a, f2.1)") "Making a field too narrow: ", planets%period_days*days_to_seconds

    ! printing all the periods in one line with the *(...) formatting
    print *
    write (*, "(a, 8f15.2)") "Using the group *(...) formatting: ", planets%period_days*days_to_seconds

    
end program formatted_print