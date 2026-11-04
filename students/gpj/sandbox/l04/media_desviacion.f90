! L04 exercise "a subroutine with several results":
! Compile: gfortran -Wall -fcheck=all -o media_desviacion media_desviacion.f90
module stats
  implicit none
  private
  public :: mean_and_std    

contains

  subroutine mean_and_std(x, mean, std)
    real, intent(in)  :: x(:)      
    real, intent(out) :: mean, std
    integer :: n

    n = size(x)
    mean = sum(x) / n
    std = sqrt(sum((x - mean)**2) / (n - 1))
    ! If we add "x(1) = 0.0" here, the compiler gives an error
    ! because x is intent(in).
  end subroutine mean_and_std

end module stats


program mean_std
  use stats, only: mean_and_std
  implicit none
  real :: mags(5) = [4.2, 3.9, 4.5, 4.1, 4.3]
  real :: mean, std

  call mean_and_std(mags, mean, std)
  print *, 'Mean:              ', mean
  print *, 'Standard deviation:  ', std
end program mean_std
