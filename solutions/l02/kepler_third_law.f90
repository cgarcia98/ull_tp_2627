! Lecture 2, Exercise 1: Kepler's third law
!
! Computes the orbital period of a planet in years and in days from its
! semi-major axis (AU) and the mass of its star (solar masses).
! To test another case, change the input values and recompile.
program kepler_third_law
  implicit none
  real, parameter :: days_per_year = 365.25
  real :: a, m_star, p_years, p_days
  integer :: whole_days

  ! Input values: Jupiter
  a = 5.2
  m_star = 1.0

  if (a <= 0.0 .or. m_star <= 0.0) stop 'Error: both values must be positive.'

  p_years = sqrt(a**3 / m_star)
  p_days = p_years * days_per_year
  whole_days = int(p_days)   ! truncates; plain assignment would too, but silently

  print *, 'Orbital period (years):', p_years
  print *, 'Orbital period (days): ', p_days
  print *, 'Whole days:            ', whole_days
end program kepler_third_law
