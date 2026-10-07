program wien_law
    implicit none
    real, parameter :: b = 2.897772e6       ! Wien's constant (nm K)
    integer, parameter :: b_int = 2897772   ! same constant as an integer
    integer :: t                            ! temperature (K)

    print *, "Coolest first:   T (K)   lambda_max (nm)   with integer b"
    do t = 3000, 30000, 3000
        print *, t, b / t, b_int / t
    end do
    print *, "Loop variable after the loop: t =", t

    print *
    print *, "Hottest first:   T (K)   lambda_max (nm)"
    do t = 30000, 3000, -3000
        print *, t, b / t
    end do
    print *, "Loop variable after the loop: t =", t
end program wien_law
