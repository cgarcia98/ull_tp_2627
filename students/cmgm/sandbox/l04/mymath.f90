module mymath
    use kinds, only: dp
    implicit none
    real(dp), parameter :: pi = 3.14159_dp
contains
    real(dp) function circle_area(r)
        real(dp), intent(in) :: r
        circle_area = pi * r**2
    end function circle_area
end module mymath
