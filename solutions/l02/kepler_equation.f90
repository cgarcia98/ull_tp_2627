! Lecture 2, Exercise 5: Kepler's equation
!
! Solves Kepler's equation E - e sin(E) = M for the eccentric anomaly E,
! given the mean anomaly M (rad) and eccentricity e, using Newton's method.
! To test another case, change the input values and recompile.
program kepler_equation
  implicit none
  real, parameter :: tol = 1.0e-6
  integer, parameter :: max_iter = 50
  real :: m_anom, e, ecc_anom, delta
  integer :: n_iter
  logical :: converged

  ! Input values
  m_anom = 1.0
  e = 0.5

  if (e < 0.0 .or. e >= 1.0) stop 'Error: eccentricity must satisfy 0 <= e < 1.'

  ecc_anom = m_anom
  n_iter = 0
  converged = .false.

  do while (.not. converged .and. n_iter < max_iter)
    n_iter = n_iter + 1
    delta = (ecc_anom - e*sin(ecc_anom) - m_anom) / (1.0 - e*cos(ecc_anom))
    ecc_anom = ecc_anom - delta
    converged = (abs(delta) < tol)
  end do

  if (converged) then
    print *, 'Eccentric anomaly E (rad):', ecc_anom
    print *, 'Iterations:', n_iter
  else
    print *, 'Warning: no convergence after', max_iter, 'iterations.'
  end if
end program kepler_equation
