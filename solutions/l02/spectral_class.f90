! Lecture 2, Exercise 2: Spectral classification
!
! Prints the spectral class of a star in the OBAFGKM sequence from its
! effective temperature (K).
! To test another case, change the input value and recompile.
program spectral_class
  implicit none
  integer :: t_eff
  character(len=1) :: sp_class

  ! Input value: the Sun
  t_eff = 5772

  select case (t_eff)
  case (30000:)
    sp_class = 'O'
  case (10000:29999)
    sp_class = 'B'
  case (7500:9999)
    sp_class = 'A'
  case (6000:7499)
    sp_class = 'F'
  case (5200:5999)
    sp_class = 'G'
  case (3700:5199)
    sp_class = 'K'
  case (2400:3699)
    sp_class = 'M'
  case default
    sp_class = '?'
  end select

  if (sp_class == '?') then
    print *, 'The temperature is outside the OBAFGKM sequence.'
  else
    print *, 'Spectral class: ' // sp_class
  end if
end program spectral_class
