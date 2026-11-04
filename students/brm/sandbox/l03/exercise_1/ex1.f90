program matrix_multiplication
    real :: A(3,4), B(4,3), C(3,3)

    A = reshape([3,2,1,2,4,2,4,2,3,1,2,7],[3,4])
    B = reshape([3,2,1,0,2,4,2,2,4,2,3,1],[4,3])
    C = matmul(A,B)

    print *, "Matrix C:"
    
    do i = 1, size(C, 1)
        print *, C(i, :) 
    end do

end program