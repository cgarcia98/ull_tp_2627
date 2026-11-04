! Program that defines a module stats which contains a subroutine that calculates mean and std from an array of numbers and then defines
! a main program that calculates the mean and std from a given array

module stats
    implicit none
    private
    public :: mean_and_std

contains

    subroutine mean_and_std(x, mean, std)
    !! subroutine to calculate mean and standard deviation from an input array

        !! arguments
        real, intent(in) :: x(:)
        !! (in) input array of values
        real, intent(out) :: mean, std
        !! (out) output of mean and standard deviation of the array of values

        mean = sum(x)/size(x)
        std = sqrt(sum((x - mean)**2)/(size(x) - 1))
        write (*, "(a, f8.4, a, f8.4)") "Mean: ", mean, "; Standard deviation: ", std
        
    end subroutine mean_and_std

end module stats

program array_mean_std
    use stats, only: mean_and_std
    implicit none

    real :: mean, std
    real :: array(5) = [4.2, 3.9, 4.5, 4.1, 4.3]

    call mean_and_std(array, mean, std)
    
end program array_mean_std