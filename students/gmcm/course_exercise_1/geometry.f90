! Points and vectors in three dimensions.

module geometry
    use iso_fortran_env, only: real64
    implicit none

    ! Kind of all the real variables in the project (64-bit).
    integer, parameter :: dp = real64

    ! A displacement in space.
    type :: vector3d
        real(dp) :: x, y, z
    end type vector3d

    ! A location in space.
    type :: point3d
        real(dp) :: x, y, z
    end type point3d

    ! Adding a vector to a point gives a point
    interface operator(+)
        module procedure sumvp, sumpv
    end interface

    ! Point - vector gives a point, and point - point gives a vector
    interface operator(-)
        module procedure subpv, subpp
    end interface

contains

    ! Returns the point v + p, same as p + v
    elemental type(point3d) function sumvp(v, p)
        type(vector3d), intent(in) :: v
        type(point3d), intent(in) :: p
        sumvp = sumpv(p, v)
    end function sumvp

    ! Returns the point p + v (the point p moved by the displacement v)
    elemental type(point3d) function sumpv(p, v)
        type(point3d), intent(in) :: p
        type(vector3d), intent(in) :: v
        sumpv = point3d(p%x + v%x, p%y + v%y, p%z + v%z)
    end function sumpv

    ! Returns the point p - v (the point p moved by the opposite of v)
    elemental type(point3d) function subpv(p, v)
        type(point3d), intent(in) :: p
        type(vector3d), intent(in) :: v
        subpv = point3d(p%x - v%x, p%y - v%y, p%z - v%z)
    end function subpv

    ! Returns the vector a - b, which goes from the point b to the point a
    elemental type(vector3d) function subpp(a, b)
        type(point3d), intent(in) :: a, b
        subpp = vector3d(a%x - b%x, a%y - b%y, a%z - b%z)
    end function subpp
end module geometry
