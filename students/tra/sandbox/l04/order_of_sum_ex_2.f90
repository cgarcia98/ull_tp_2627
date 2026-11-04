! Program to calculate the sum {sum_i=1^N (1/k)} of the first 1e7 integers by using the 32-bit (forwards and backwards) 
! and 64-bit (reference value )real number cases

! It seems the backwards sum gives a better estimate of the result of the sum
! This is because the gap between real numbers grow with magnitude, and in the case of the backwards sum it is carried from smallest to 
! largest, so the gap is smaller, and rounding-off due to the sum of numbers not fitting the gap is less frequent than in the forwards case

program order_sum
    use iso_fortran_env, only: real32, real64
    implicit none
    
    integer, parameter :: sp = real32
    integer, parameter :: dp = real64
    real(kind=sp) :: i_fwd = 0.0_sp
    real(kind=sp) :: i_bwd = 0.0_sp
    real(kind=dp) :: i_dp = 0.0_dp
    integer :: k
    integer, parameter :: initial=1, final=1e7, step=1

    do k=initial, final, step
        i_fwd = i_fwd + 1/real(k)
    end do

    print *, "Result of the forwards sum: ", i_fwd

    do k=final, initial, -step
        i_bwd = i_bwd + 1/real(k)
    end do

    print *, "Result of the backwards sum: ", i_bwd ! backwards is closer to the 64-bit result, why?

    do k=initial, final, step
        i_dp = i_dp + 1/real(k)
    end do

    print *, "Double precision reference value: ", i_dp

end program order_sum