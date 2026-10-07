! Program to solve kepler's eq. to obtain the eccentric anomaly E using Newton's method given the mean anomaly M (rad) and
! the eccentricity of the orbit

program kepler_eq

    implicit none
    integer :: counter
    real, parameter :: tol = 1e-6
    real :: numerator, denominator
    real :: mean_anomaly, eccentricity, ecc_anomaly, prev_ecc_anomaly
    logical :: converged

    ! asking the user to input the values of mean anomaly and eccentricity
    write (*, *) "Enter the value of mean anomaly: "
    read (*, *) mean_anomaly
    write (*, *) "Enter the value of eccentricity: "
    read (*, *) eccentricity

    print *
    print *, "Loop"
    print *, "--------------------------------------------------------------------------------------------------"

    ! do while loop to obtain the value of eccentric anomaly of the planet with an accuracy given by the tolerance constant
    ecc_anomaly = mean_anomaly
    converged = .false.
    counter=0
    do while (.not. converged .and. counter <= 50)

        if (counter==50) stop "50 iterations have been reached and the program terminated without convergence."
        counter = counter + 1
        prev_ecc_anomaly = ecc_anomaly ! previous step eccentric anomaly
        
        numerator = ecc_anomaly - eccentricity*sin(ecc_anomaly) - mean_anomaly
        denominator = 1 - eccentricity*cos(ecc_anomaly)

        ecc_anomaly = ecc_anomaly - numerator/denominator

        converged = abs(ecc_anomaly - prev_ecc_anomaly) < tol

        write (*, "(a, f12.4, a, f12.4)") "Previous eccentric anomaly: ", prev_ecc_anomaly, & ! printing the previous and current step E
                                        " | Current eccentric anomaly: ", ecc_anomaly
    end do

    print *
    write (*, "(a, i3)") "Number of iterations: ", counter
    write (*, "(a, f12.4)") "The final eccentric anomaly value E: ", ecc_anomaly

end program kepler_eq