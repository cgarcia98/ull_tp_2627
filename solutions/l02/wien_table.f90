! Lecture 2, Exercise 4: Wien's displacement law
!
! Prints the wavelength of peak blackbody emission for a range of
! temperatures, first coolest first and then hottest first.
program wien_table
  implicit none
  real, parameter :: b_wien = 2.897772e6   ! Wien's displacement constant (nm K)
  integer :: t
  real :: lambda_max

  print *, 'Coolest first: T (K), lambda_max (nm)'
  do t = 3000, 30000, 3000
    lambda_max = b_wien / t   ! real / integer gives a real
    print *, t, lambda_max
  end do
  print *, 'After the loop, t =', t

  print *, 'Hottest first: T (K), lambda_max (nm)'
  do t = 30000, 3000, -3000
    lambda_max = b_wien / t
    print *, t, lambda_max
  end do
  print *, 'After the loop, t =', t
end program wien_table
