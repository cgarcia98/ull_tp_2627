program Kepler

real :: M = 3.2
a = 2.3
days_in_year = 365.25

if (.not. (M > 0)) stop 'Invalid mass'
if (.not. (a > 0)) stop 'Invalid axis'


T = sqrt(a**3 / M)


write(*,*) 'Period in years:', T
write(*,*) 'Period in days:', T*days_in_year
write(*,*) 'Period in whole days:', int(T*days_in_year)

end program Kepler
