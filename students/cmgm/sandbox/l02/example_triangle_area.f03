module triangle_operations
    implicit none
contains
    function area(x, y, z)
        real :: area !function type
        real, intent(in) :: x, y, z
        real :: theta, height
        theta = acos((x**2 + y**2 - z**2) / (2.0 * x * y))
        height = y * sin(theta)
        area = 0.5 * x * height
    end function area
end module triangle_operations

program triangle_area
    use triangle_operations
    implicit none
    real :: a, b, c
    print *, 'Welcome, please enter the lenghts of the 3 sides.'
    read *, a, b, c
    print *, "Triangle's area:", area(a, b, c)
end program triangle_area