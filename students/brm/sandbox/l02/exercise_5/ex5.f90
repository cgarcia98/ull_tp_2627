program keplers_equation
    implicit none

    real :: M, ecc, E, E_next
    integer :: i
    logical :: converged

    M = 1.0
    ecc = 0.5

    E = M
    i = 0
    converged = .false.

    do while (.not. converged .and. i < 50)
        E_next = E - (E - ecc*sin(E) - M)/(1.0 - e*cos(E))
        i = i + 1
        
        if (abs(E_next - E) < 1e-6) then
            converged = .true.
        end if
        
        E = E_next
    end do

    if (converged) then
        print *, "Converged in", i, "iterations."
        print *, "E =", E
    else
        print *, "Warning: did not converge after 50 steps."
    end if

end program