! Lecture 2, Exercise 3: Habitable zone
!
! Reports whether a planet stays inside its star's habitable zone, given
! the stellar luminosity (solar luminosities) and the semi-major axis (AU)
! and eccentricity of the planet's orbit.
! To test another case, change the input values and recompile.
program habitable_zone
  implicit none
  real :: lum, a, e
  real :: hz_inner, hz_outer, r_peri, r_apo
  logical :: peri_in, apo_in

  ! Input values: the Earth
  lum = 1.0
  a = 1.0
  e = 0.017

  if (lum <= 0.0 .or. a <= 0.0) stop 'Error: luminosity and semi-major axis must be positive.'
  if (e < 0.0 .or. e >= 1.0) stop 'Error: eccentricity must satisfy 0 <= e < 1.'

  hz_inner = sqrt(lum / 1.1)
  hz_outer = sqrt(lum / 0.53)
  r_peri = a * (1.0 - e)
  r_apo  = a * (1.0 + e)

  peri_in = (r_peri >= hz_inner .and. r_peri <= hz_outer)
  apo_in  = (r_apo  >= hz_inner .and. r_apo  <= hz_outer)

  print *, 'Habitable zone (AU):', hz_inner, hz_outer
  print *, 'Periapsis, apoapsis (AU):', r_peri, r_apo

  if (peri_in .and. apo_in) then
    print *, 'The planet is always in the habitable zone.'
  else if (peri_in .neqv. apo_in) then
    print *, 'The planet is in the habitable zone for part of its orbit.'
  else if (r_apo < hz_inner) then
    print *, 'The planet is never in the habitable zone: too hot.'
  else if (r_peri > hz_outer) then
    print *, 'The planet is never in the habitable zone: too cold.'
  else
    print *, 'The orbit crosses the whole habitable zone.'
  end if
end program habitable_zone
