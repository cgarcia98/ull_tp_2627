! Program for sigma cliping and practicing with array allocation

module sigma_clipping

    implicit none

contains

    function clip(x, nsigma) result(clipped_array)
    !! function for sigma clipping with a sigma value of nsigma
    !! for an array x

        !! arguments
        real, allocatable :: clipped_array(:)
        !! clipped array result
        real, dimension(:), intent(in) :: x ! rank 1 array
        !! (in) input array
        real :: mean, sigma
        !! output of mean and sigma from the array
        integer, intent(in) :: nsigma
        !! (in) sigma value for sigma clipping
        integer :: i, j, counter, all_stat

        mean = sum(x)/size(x)
        sigma = sqrt((sum((x - mean)**2)/(size(x)-1)))

        ! do loop to know the number of elements that verify the logical condition
        counter=0
        do i=1, size(x)
            if ((x(i)>=(mean - nsigma*sigma)) .and. (x(i)<=(mean + nsigma*sigma))) then
                counter = counter + 1
            else 
                cycle
            end if
        end do

        ! allocating the clip array as we know the number of elements that verify our logical condition
        allocate(clipped_array(counter), stat=all_stat)
        if (all_stat /= 0) stop "Array could not be allocated."

        ! do loop to copy the elements into the allocatable array
        j=1
        do i=1, size(x)
        if ((x(i)>=(mean - nsigma*sigma)) .and. (x(i)<=(mean + nsigma*sigma))) then
                clipped_array(j) = x(i)
                j = j + 1 ! iterating clip array index
            end if
        end do

    end function clip

end module sigma_clipping

program sigma_clip
    use sigma_clipping, only: clip
    implicit none
    real :: a(7) = [10.1, 9.8, 10.3, 9.9, 55.0, 10.0, 10.2]
    integer, parameter :: n_sigma=2
    real, dimension(:), allocatable :: alloc_array
    integer :: clipping_counter, old_size

    print "(a)", "Here is the clipped array: "
    print "(*(f8.1))", clip(a, n_sigma)

    ! repeating the clipping until no more values are removed
    alloc_array=a
    clipping_counter=0
    do 
        old_size = size(alloc_array)

        alloc_array = clip(alloc_array, n_sigma)

        if (old_size==size(alloc_array)) then
            exit
        else 
            clipping_counter = clipping_counter + 1
        end if
       
    end do

    print "(*(f8.1))", alloc_array

end program sigma_clip