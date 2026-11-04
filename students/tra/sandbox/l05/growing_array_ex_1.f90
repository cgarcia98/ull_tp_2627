! Program to store standard input values to an allocatable array, print the values, calculate the mean and see how the appending
! method could be made more efficiently for larger files

! Add the linked list, better way to deal with the memory allocation (non copying of the array via use of pointers linked structure)

program growing_array
    use iso_fortran_env, only: iostat_end ! helps with distinguishing end of file condition in the read statement compared to a reading error
    implicit none
    integer :: read_status
    real :: temp_value, mean
    real, allocatable :: a(:)

    allocate(a(0)) ! starting with allocating an empty array

    write (*, *) "Enter now the values you want to add to the array (press Ctrl+D on a new line to end stdin input): "

    do 
        read (*, *, iostat=read_status) temp_value
        if (read_status==iostat_end) then
            print *, "End of file."
            exit 
        else if (read_status/=0) then
            print *, "Reading error."
            stop "Try again."
        else
            a = [a, temp_value]
        end if
    end do

    ! consider the case where not a single value was added to the array (empty array)
    if (size(a)==0) then
        stop "Array is empty. Give it some values." 
    end if

    print *
    write (*, *) "Values of the array: ", a ! printing of the values

    print *
    write (*, *) "Values of the array in reverse order", a(size(a):1:-1) ! printing in reverse order (remember a(inital_value:final_value:step)) 

    print *
    mean = sum(a)/size(a) ! mean of the values in the array
    write (*, "(a, f8.4)") "Mean value of the values in the array: ", mean

    ! deallocating the arrays
    deallocate(a)
    
end program growing_array