module kinds
    use iso_fortran_env, only: real32, real64
    implicit none
    integer, parameter :: sp = real32
    integer, parameter :: dp = real64
end module kinds

program machine_epsilon
    use kinds
    implicit none
    real(sp) :: eps_sp
    real(dp) :: eps_dp
    eps_sp = 1.0_sp
    eps_dp = 1.0_dp
    do while (1.0_sp + eps_sp/2.0_sp > 1.0_sp)
        eps_sp = eps_sp / 2.0_sp
    end do
    do while (1.0_dp + eps_dp/2.0_dp > 1.0_dp)
        eps_dp = eps_dp / 2.0_dp
    end do
    print *, 'Machine epsilon (single precision):', eps_sp
    print *, 'Machine epsilon (double precision):', eps_dp
end program machine_epsilon
