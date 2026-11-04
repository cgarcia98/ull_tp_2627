! Program to practice a bit with custom operators

module vec_op_module
    implicit none

    type :: vector3d
        real :: x, y, z
    end type

    interface operator(+)
        module procedure sumvv
    end interface

    interface operator(-)
        module procedure subvv
    end interface

    interface operator(*)
        module procedure mulrv
    end interface

    interface operator(.dot.)
        module procedure dotvv
    end interface

    interface operator(.cross.)
        module procedure crossvv
    end interface

contains

    elemental type(vector3d) function sumvv(a, b)
        type(vector3d), intent(in) :: a, b
        sumvv = vector3d(a%x + b%x, a%y + b%y, a%z + b%z)
    end function sumvv

    elemental type(vector3d) function subvv(a, b)
        type(vector3d), intent(in) :: a, b
        subvv = vector3d(a%x - b%x, a%y - b%y, a%z - b%z)
    end function subvv

    elemental type(vector3d) function mulrv(r, a)
        real, intent(in) :: r
        type(vector3d), intent(in) :: a
        mulrv = vector3d(r*a%x, r*a%y, r*a%z)
    end function mulrv

    elemental real function dotvv(a, b)
        type(vector3d), intent(in) :: a, b
        type(vector3d) :: c 
        c = vector3d(a%x*b%x, a%y*b%y, a%z*b%z)
        dotvv = c%x + c%y + c%z
    end function dotvv

    elemental type(vector3d) function crossvv(a, b)
        type(vector3d), intent(in) :: a, b 
        crossvv = vector3d(a%y*b%z - a%z*b%y, a%z*b%x - a%x*b%z, a%x*b%y - a%y*b%x)
    end function crossvv

end module vec_op_module

program vec_operations
    use vec_op_module
    implicit none

    type(vector3d) :: a, b, c
    type(vector3d), dimension(2) :: array, scaled_array
    
    write (*, *) "Enter the values of the 3d vector a:"
    read (*, *) a

    write (*, *) "Enter the values of the 3d vector b:"
    read (*, *) b

    c = a .cross. b

    print *, "Cross product of vectors a and b: ", a .cross. b
    write (*, "(a, f5.3, a, f5.3)") "Checking that dot product of c with a is zero: ", c .dot. a, &
                                    " / And also of c with b: ", c .dot. b 

    ! due to higher precedence of unitary operators compared to binary, operators * and + have priority of execution in the operation
    print *, "Expression 2.0 * a .dot. b: ", 2.0 * a .dot. b
    print *, "Expression 1.0 + a .dot. b: ", 1.0 + (a .dot. b)
    print *

    ! finding out and showing an example of what we can do now that operator functions are elemental (with an array of 3d vectors)
    array(1) = vector3d(1.0, 2.0, 3.0) ! first element of array
    array(2) = vector3d(4.0, 5.0, 6.0) ! second element of array

    scaled_array = 2.0*array ! example applying (*) operator for scaling an array of vectors 

    ! with elemental, now the aplication of the (*) operator is done element by element (to each element of the array)
    ! we can now scale all the components of all the vectors in the array at once
    print *, "Scaling x position of all vectors in array: ", scaled_array%x
    print *, "Scaling y positions of all vectors in array: ", scaled_array%y 
    print *, "Scaling z positions of all vectors in array: ", scaled_array%z

end program vec_operations