! This program is a linked list approach to exercise 1, as an answer to the suggestion of point 5 of the task
! Here we are going to practice with pointers, derived types and create our own linked list for better memory management

! What we add here is the use of pointers and a linked list, which we will work with to store the values, then assign them to the array, and then deallocate 
! the whole list to have a better and more efficient memory storage, finally we print the values of the array, forwards and backwards and its mean

module link_list

    type :: cell
        real :: value
        type(cell), pointer :: next => null()
    end type cell

end module link_list

program growing_array_link
    use iso_fortran_env, only: iostat_end
    use link_list, only: cell
    implicit none
    type(cell), pointer :: head => null()
    type(cell), pointer :: new_cell => null()
    type(cell), pointer :: current => null()
    type(cell), pointer :: temp_pter => null()
    integer :: read_stat, all_stat, i, counter=0
    real :: val, mean
    real, allocatable :: array(:)

    print *, "Enter now the values you want to add to the array (press Ctrl+D on a new line to end stdin input): "

    do
        read (*, *, iostat=read_stat) val

        if (read_stat==iostat_end) then
            print *, "End of file."
            exit
        else if (read_stat/=0) then
            print *, "Reading error."
            stop "Try again"
        else 
            allocate(new_cell) ! allocating space for new cell
            new_cell%value = val
            new_cell%next => null()

            if (.not. associated(head)) then 
            ! if statement for pointing as a first step head and current pointers to the newly created cell
                head => new_cell
                current => new_cell
            else 
            ! if the first association has been done, continue association with the other cells (if other cells apart from the first one have been created, more than one value is given)
                current%next => new_cell ! pointer next, of current, pointing to the next cell
                current => new_cell ! assign current pointer to the new_cell so in next iteration you point to the newly created cell
            end if

            counter = counter + 1 ! keep track of the amount of cells created for posterior allocation of array

        end if
    end do

    ! verify that the list is not empty
    if (counter==0) stop "Linked list is empty. Try again, but now adding values."

    ! allocating array
    allocate(array(counter), stat=all_stat)
    if (all_stat/=0) stop "Allocation was not successful."

    ! assigning the values to the allocatable array
    current => head ! start from the beginning
    do i=1, counter
        array(i) = current%value ! assign value
        current => current%next ! iterate to the next cell
    end do

    ! deallcoating the whole list (we have finished working with the list)
    ! deallcoating from the beginning of the list until the end
    do while (associated(head))
        temp_pter => head%next
        deallocate(head)
        head => temp_pter
    end do

    ! output
    print *, "Total number of elements: ", size(array)
    print *, "Values of the array: ", array
    print *, "Values of the array in reverse order: ", array(size(array):1:-1) ! array(initial_value:final_value:step)
    
    mean = sum(array)/size(array)
    print *, "Mean value of the values inside the array: ", mean

    ! deallocating the array
    deallocate(array)

end program growing_array_link