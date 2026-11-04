! Program to solve quadratic eqs. and compare the results using 32-bits and 64-bits kinds of numbers

! Going to take advantage of this exercise to apply a new concept I learned in Metcalf's Modern FORTRAN explained book.
! The concept of interface blocks, where i can define two different dummy procedures and contain them under the same name, the compiler 
! when calling, by inspecting the arguments of the functions or subroutines inside the block uses one or the other, quite useful for applying 
! different cases of the same procedure (also interface blocks (abstract ones) are useful to use procedures as arguments for other procedures)

module quadratic_module
    use iso_fortran_env, only: real32, real64
    implicit none
    integer, parameter :: sp = real32
    integer, parameter :: dp = real64

    ! interface block
    interface solve_quadratic
        module procedure solve_quadratic_sp, solve_quadratic_dp
    end interface

contains

    subroutine solve_quadratic_sp(a, b, c, x1, x2, x2_hint)
    !! subroutine to solve the quadratic eq. for sp input

        !! arguments
        real(kind=sp), intent(in) :: a, b, c
        !! (in) coeffs. of the quadratic eq.
        real(kind=sp), intent(out) :: x1, x2, x2_hint
        !! (out) roots of the quadratic eq., where hint makes possible
        !! to yield a precise result of the second root bypassing the 
        !! limitations of sp precision
        real(kind=sp) :: discriminant
        !! discriminant of the quadratic eq.

        ! setting both roots of the quadratic equation
        discriminant = b*b - 4.0_sp*a*c
        x1 = (-b + sqrt(discriminant))/(2.0_sp*a)
        x2 = (-b - sqrt(discriminant))/(2.0_sp*a)
        x2_hint = (c/(a*x1))

    end subroutine

    subroutine solve_quadratic_dp(a, b, c, x1, x2, x2_hint)
    !! subroutine to solve the quadratic eq. for dp input

        !! arguments
        real(kind=dp), intent(in) :: a, b, c
        !! (in) coeffs. of the quadratic eq.
        real(kind=dp), intent(out) :: x1, x2, x2_hint
        !! (out) roots of the quadratic eq., where hint makes possible
        !! to yield a precise result of the second root bypassing the 
        !! limitations of sp precision
        real(kind=dp) :: discriminant
        !! discriminant of the quadratic eq.

        ! setting both roots of the quadratic equation
        discriminant = b*b - 4.0_dp*a*c
        x1 = (-b + sqrt(discriminant))/(2.0_dp*a)
        x2 = (-b - sqrt(discriminant))/(2.0_dp*a)
        x2_hint = (c/(a*x1))

    end subroutine

end module

program quadratic_eq
    use quadratic_module
    implicit none
    
    real(kind=sp) :: a_sp, b_sp, c_sp
    real(kind=sp) :: x1_sp, x2_sp, x2_sp_hint
    real(kind=dp) :: a_dp, b_dp, c_dp
    real(kind=dp) :: x1_dp, x2_dp, x2_dp_hint
    
    write (*, *) "Enter the values of the real numbers a, b and c of your quadratic equation: "
    read (*, *) a_sp, b_sp, c_sp

    ! conversion to dp kinds
    a_dp = real(a_sp, kind=dp)
    b_dp = real(b_sp, kind=dp)
    c_dp = real(c_sp, kind=dp)

    ! calling the subroutines by calling the main interface umbrella name
    call solve_quadratic(a_sp, b_sp, c_sp, x1_sp, x2_sp, x2_sp_hint)
    call solve_quadratic(a_dp, b_dp, c_dp, x1_dp, x2_dp, x2_dp_hint)

    ! printing output
    ! smaller root gets rounded off to zero due to the gap of 10^8 with the next real number, which is bigger than the number that we are
    ! subtracting inside the discriminant, which is 4, so 10^8 - 4 ~ 10^8 and the second root yields zero in single precision case
    print *
    print *, "Single precision outputs:"
    print *, "Root 1: ", x1_sp
    print *, "Root 2: ", x2_sp 
    print *, "Root 2 (with the hint): ", x2_sp_hint 

    ! printing the dp case
    print *
    print *, "Double precision outputs:"
    print *, "Root 1: ", x1_dp
    print *, "Root 2: ", x2_dp 
    print *, "Root 2 (with the hint): ", x2_dp_hint

end program quadratic_eq