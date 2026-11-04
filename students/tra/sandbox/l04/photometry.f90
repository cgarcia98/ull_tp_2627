! Module photometry which calculates the magnitude from values of flux

module photometry
    implicit none

contains

    elemental real function flux_to_mag(flux)
    !! function to calculate magnitude from flux

        !! arguments
        real, intent(in) :: flux
        !! (in) input flux value

        flux_to_mag = -2.5*log10(flux)
        !print *, "Hello!" ! print statement not allowed within PURE procedure
        
    end function flux_to_mag 

end module photometry

program mag_calculation
    use photometry, only: flux_to_mag
    implicit none

    real :: flux_value = 10.0
    real :: mag_value
    real :: flux_array(5) = [1.0, 2.0, 3.0, 4.0, 5.0]
    real, dimension(:), allocatable :: mag
    integer :: all_stat

    ! allcoation of mag array
    allocate(mag(size(flux_array)), stat=all_stat)
    if (all_stat/=0) stop "Allocation was not successful."

    ! single value calculation
    mag_value = flux_to_mag(flux_value)
    print *, "Single magnitude value: ",  mag_value

    ! applying to an array of values
    where (flux_array > 0.0)
        mag = flux_to_mag(flux_array)
    elsewhere
        mag = 0
    end where
    
    ! printing the output
    print *, "Array of magnitude values: ", mag

end program mag_calculation