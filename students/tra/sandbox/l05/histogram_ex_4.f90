! Program to practice array allocation and making a "histogram" array

program histogram

    implicit none
    integer :: i, j, counter, read_stat, n_values, all_stat, counts_all_stat, min_val, max_val
    integer, dimension(:), allocatable :: array, counts

    write (*, *) "Enter the number of values you want to add to the array: "
    read (*, *, iostat=read_stat) n_values
    if (n_values<=0) stop "Input for array size must be greater than zero."

    if (read_stat/=0) then
        write (*, *) "Empty or invalid input detected. Try again."
        stop
    end if

    ! allocating the array
    allocate(array(n_values), stat=all_stat)
    if (all_stat/=0) stop "Allocation of array was not successful. Try again."

    write (*, *) "Enter the values to add to the array: "
    read (*, *, iostat=read_stat) array

    if (read_stat/=0) then
        write (*, *) "Empty input detected. Try again."
        stop
    end if

    ! defining the minimum and maximum value of the array
    min_val = minval(array)
    max_val = maxval(array)

    ! allocating the array counts
    allocate(counts(min_val:max_val), stat=counts_all_stat)
    if (counts_all_stat/=0) stop "Allocation of counts array was not successful. Try again."
    counts=0 ! necessary to initialize values to zero

    ! double do loop to store in counts array the number of times a value repeats itself
    do j=min_val, max_val
        counter=0
        do i=1, n_values
            if (j==array(i)) then
                counter = counter + 1
            end if
        end do
        counts(j)=counter
    end do

    ! printing every value with its count
    do i=min_val, max_val
        write (*, "(a, i5, a, i5)") "Number: ", i, "; Count: ", counts(i)
    end do

    ! printing bounds and size of counts array
    print *
    write (*, "(a, i4, a, i4)") "Lower bound: ", lbound(counts), "; Upper bound: ", ubound(counts)
    print *, "Size: ", size(counts)

end program histogram