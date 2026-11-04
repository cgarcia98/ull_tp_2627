! Module mymath which contains a function circle_area(r) which for a given radius r calculates the area of a circle

module mymath
    use kinds, only: dp
    implicit none
    real, parameter :: pi = 3.14159

contains
    real(kind=dp) function circle_area(r)
        real(kind=dp), intent(in) :: r
        circle_area = 2*pi*r
    end function circle_area

end module mymath