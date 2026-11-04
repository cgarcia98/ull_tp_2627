! Program to work with window and image pointers (CHANGE FOR THE BETTER)

program window_image

    implicit none
    integer :: nx, ny, read_stat, all_stat
    real, dimension(:,:), allocatable, target :: image 
    real, dimension(:,:), pointer :: window => null()
    real, dimension(:), pointer :: ptoi => null() ! pointer to image

    ! writing and reading the input integers nx, ny, which will be the size of ou rimage array
    write (*, *) "Enter the values of nx and ny: "
    read (*, *, iostat=read_stat) nx, ny
    if (nx<= 0 .or. ny<=0) stop "nx and ny must greater than zero integers."

    ! allocation of the array
    allocate(image(nx,ny), stat=all_stat)
    if (all_stat/=0) stop "Image array could not be allocated."
    image=0 ! setting to zero

    ! pointing two-dimensional pointer window into the center of the image array
    window => image(nx/4+1:3*nx/4, ny/4+1:3*ny/4)
    print *, "Window size: ", size(window)
    print *, "Window lower bound: ", lbound(window) ! prints two lower bounds (one for each dimension)

    ! setting to 1.0 all elements of window and printing its whole sum
    window = 1.0
    print *, "Sum with all elements set to one: ", sum(window)

    ! pointing a pointer to every second element of the first column of the image array
    ! in general, an array has this slicing structure array(first-expression : last-expression : stride-expression)
    ptoi => image(1:nx:2, 1)
    ptoi = 5.0
    print *, "Image array first column: ", image(:, 1)

    ! deallocating the image and seeing the association after deallocation
    deallocate(image)

    if (associated(window) .eqv. .true.) then
        print *, "Image and window are still associated."
    else 
        print *, "Image and window no longer associated."
    end if

    ! image and window seem to be still associated, but image is deallocated

end program window_image