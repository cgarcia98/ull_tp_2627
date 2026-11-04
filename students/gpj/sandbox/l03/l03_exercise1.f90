program l03_exercise1
    implicit none
    real :: a(4,3), b(3,4), c(4,4)
    integer :: i
    a = reshape([3.0, 2.0, 4.0, 1.0, 2.0, 4.0, 2.0, 2.0, 1.0, 2.0, 3.0, 7.0], [4,3])
    b = reshape([3.0, 2.0, 4.0, 2.0, 4.0, 2.0, 1.0, 2.0, 3.0, 0.0, 2.0, 1.0], [3,4])
    print *, "Matrix A:"
    do i = 1, 4
        print *, a(i, :)
    end do
    print *, "Matrix B:"
    do i = 1, 3
        print *, b(i, :)
    end do
    c = matmul(a, b)
    print *, "Matrix C (A * B):"
    do i = 1, 4
        print *, c(i, :)
    end do
end program l03_exercise1