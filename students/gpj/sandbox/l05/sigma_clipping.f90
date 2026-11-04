! L05 exercise "sigma clipping": function with allocatable result.
! Compile: gfortran -Wall -fcheck=all -o sigma_clipping sigma_clipping.f90
module clipping
  implicit none

contains

  function clip(x, nsigma) result(y)
    real, intent(in) :: x(:), nsigma
    real, allocatable :: y(:)
    real :: media, desv
    integer :: i, n

    media = sum(x) / size(x)
    desv = sqrt(sum((x - media)**2) / (size(x) - 1))

    ! 1) Count how many elements will remain after clipping
    n = count(abs(x - media) <= nsigma * desv)
    ! 2) Allocate the result array
    allocate(y(n))
    ! 3) copy the elements that pass the clipping criterion
    n = 0
    do i = 1, size(x)
      if (abs(x(i) - media) <= nsigma * desv) then
        n = n + 1
        y(n) = x(i)
      end if
    end do
  end function clip

end module clipping


program sigma_clipping
  use clipping
  implicit none
  real :: datos(7) = [10.1, 9.8, 10.3, 9.9, 55.0, 10.0, 10.2]
  real, allocatable :: good(:), new(:)

  ! We dont need to allocate: the assignment reserves "good" automatically
  good = clip(datos, 2.0)
  print *, 'Tras un recorte: ', good

  ! Repeat until no more elements are removed
  do
    new = clip(good, 2.0)
    if (size(new) == size(good)) exit
    good = new
  end do
  print *, 'Final:           ', good
  print *, 'Final Mean:     ', sum(good) / size(good)
end program sigma_clipping
