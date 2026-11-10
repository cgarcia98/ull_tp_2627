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

    ! Multiplying a vector by a real gives a vector, in either order
    interface operator(*)
        module procedure mulrv, mulvr
    end interface

    ! Dividing a vector by a real gives a vector
    interface operator(/)
        module procedure divvr
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

    ! Returns the vector a - b, which goes from point b to point a
    elemental type(vector3d) function subpp(a, b)
        type(point3d), intent(in) :: a, b
        subpp = vector3d(a%x - b%x, a%y - b%y, a%z - b%z)
    end function subpp

    ! Returns the vector r * v
    elemental type(vector3d) function mulrv(r, v)
        real(dp), intent(in) :: r
        type(vector3d), intent(in) :: v
        mulrv = vector3d(r * v%x, r * v%y, r * v%z)
    end function mulrv

    ! Returns the vector v * r, same as r * v
    elemental type(vector3d) function mulvr(v, r)
        type(vector3d), intent(in) :: v
        real(dp), intent(in) :: r
        mulvr = mulrv(r, v)
    end function mulvr

    ! Returns the vector v / r
    elemental type(vector3d) function divvr(v, r)
        type(vector3d), intent(in) :: v
        real(dp), intent(in) :: r
        divvr = vector3d(v%x / r, v%y / r, v%z / r)
    end function divvr
end module geometry
