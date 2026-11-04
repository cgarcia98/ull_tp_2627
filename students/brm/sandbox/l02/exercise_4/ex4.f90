program wiens_law
    implicit none

    real :: lambda
    integer :: T
    !real, parameter :: b = 2.897772*10**6
    integer, parameter :: b=2897772 !If we use integers, the numbers are not rounded up but truncated.
    ! We end up getting 965 nm for 3000K and not 966 even though it is 965.92

    do T = 3000, 30000, 3000
        lambda = b/T
        print *, "For T=", T, "K, lambda=", lambda, "nm."
    end do
    print *, "The temperature is now", T, "K" !The loop stops when the condition is not met.
    !When T is 3000, it is still met since it checks <=. Hence, it stops when it gets to 33000.

    do T = 30000, 3000, -3000
        lambda = b/T
        print *, "For T=", T, "K, lambda=", lambda, "nm."
    end do
    print *, "The temperature is now", T, "K"

end program