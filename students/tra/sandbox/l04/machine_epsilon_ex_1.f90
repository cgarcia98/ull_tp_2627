! Program to calculate the gap between the real 1.0 and the next larger real (this gap is called machine epsilon) for 32-bit and 
! 64-bit reals. We also compare with the intrinsic function of FORTRAN epsilon(x)

program machine_epsilon
    use iso_fortran_env, only: real32, real64
    implicit none
    integer, parameter :: sp = real32
    integer, parameter :: dp = real64
    real(kind=sp) :: eps_sp = 1.0_sp
    real(kind=dp) :: eps_dp = 1.0_dp

    do while (1.0 + eps_sp/2.0 > 1.0)
        eps_sp = eps_sp/2.0
    end do

    write (*, *) "Gap for the 32-bit real case: ", eps_sp
    write (*, *) "Gap calculated with the FORTRAN intrinsic function epsilon(x): ", epsilon(1.0_sp)

    do while (1.0 + eps_dp/2.0 > 1.0)
        eps_dp = eps_dp/2.0
    end do

    write (*, *) "Gap for the 64-bit real case: ", eps_dp   
    write (*, *) "Gap calculated with the FORTRAN intrinsic function epsilon(x): ", epsilon(1.0_dp)

end program machine_epsilon