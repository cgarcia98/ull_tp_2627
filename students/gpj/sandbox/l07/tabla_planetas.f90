! L07 exercise 1: formatted output. Planet table with P = a**1.5.
! Compile: gfortran -Wall -fcheck=all -o tabla_planetas tabla_planetas.f90
program planet_table
  implicit none
  integer, parameter :: n = 8
  real, parameter :: days_per_year = 365.25
  real, parameter :: seconds_per_day = 86400.0
  character(len=*), parameter :: row_fmt = '(a10, f10.3, f12.3, f12.1)'
  character(len=10) :: name(n) = [character(len=10) :: &
       'Mercury', 'Venus', 'Earth', 'Mars', &
       'Jupiter', 'Saturn', 'Uranus', 'Neptune']
  real :: a(n) = [0.387, 0.723, 1.000, 1.524, 5.203, 9.537, 19.19, 30.07]
  real :: p(n)
  integer :: i

  p = a**1.5

  ! 1) Table with header and aligned columns
  print '(a10, a10, a12, a12)', 'Planet    ', 'a [AU]', 'P [years]', 'P [days]'
  do i = 1, n
    print row_fmt, name(i), a(i), p(i), p(i) * days_per_year
  end do

  ! 2) Period in seconds with f, es and g0
  print *
  do i = 1, n
    print '(a10, f16.1, es12.3, 2x, g0)', name(i), &
         p(i) * days_per_year * seconds_per_day, &
         p(i) * days_per_year * seconds_per_day, &
         p(i) * days_per_year * seconds_per_day
  end do

  ! 3) Field too narrow: asterisks are printed
  print *
  print '(a, f5.1)', 'Neptune in days with f5.1: ', p(n) * days_per_year

  ! 4) All periods on one line with *(...)
  print *
  print '(a, *(f8.2))', 'Periods: ', p
end program planet_table