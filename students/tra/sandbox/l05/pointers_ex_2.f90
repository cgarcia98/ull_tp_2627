! Program to play a bit with two arrays and two pointers

program arrays_and_pointers

    implicit none
    integer :: all_stat
    real, target :: a(2) = [1.0, 2.0], b(2) = [3.0, 4.0]
    real, dimension(:), pointer :: p => null(), q => null()

    ! pointing the pointer p at a and q at b
    p => a
    q => b
    print *, "Array a: ", a

    ! changing one element of array a through p and printing a
    p(1) = 3.0
    print *, "By changing pointer p, which is associated with array a, array a is updated: "
    print *, "Array a: ", a ! a is updated!
    print *

    ! swapping pointers
    p => b
    q => a

    print *, "Are p and b and also q and a associated?"
    if (associated(p, b) .eqv. .true.) then 
        print *, "p and b are associated" 
    else 
        print *, "p and b are not associated"
    end if

    if (associated(q, a) .eqv. .true.) then 
        print *, "q and a are associated" 
    else 
        print *, "q and a are not associated"
    end if

    ! allocating a new array to the pointer p
    allocate(p(2), stat=all_stat)
    if (all_stat/=0) stop "Pointer could not be allocated. Try again."
    p = [5.0, 6.0] ! new memory allocation
    print *
    print *, "p now points to new allocated memory."
    print *
    
    print *, "Are p and b now associated?"
    if (associated(p, b) .eqv. .true.) then 
        print *, "p and b are associated" 
    else 
        print *, "p and b are not associated"
    end if

    ! Possible pitfall of memory leak of the new allocation memory if p is reassigned again, we avoid that by deallocating the pointer
    deallocate(p)

end program arrays_and_pointers