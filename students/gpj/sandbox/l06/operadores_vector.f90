! L06 exercise "vector operators": vector3d type with operators.
! Compile: gfortran -Wall -fcheck=all -o operadores_vector operadores_vector.f90
module vectors
  implicit none

  type :: vector3d
    real :: x, y, z
  end type vector3d

  interface operator(+)
    module procedure vec_add
  end interface

  interface operator(-)
    module procedure vec_sub
  end interface

  interface operator(*)
    module procedure scalar_times_vector
  end interface

  interface operator(.dot.)
    module procedure vec_dot
  end interface

  interface operator(.cross.)
    module procedure vec_cross
  end interface

contains

  elemental function vec_add(a, b) result(c)
    type(vector3d), intent(in) :: a, b
    type(vector3d) :: c
    c = vector3d(a%x + b%x, a%y + b%y, a%z + b%z)
  end function vec_add

  elemental function vec_sub(a, b) result(c)
    type(vector3d), intent(in) :: a, b
    type(vector3d) :: c
    c = vector3d(a%x - b%x, a%y - b%y, a%z - b%z)
  end function vec_sub

  elemental function scalar_times_vector(k, a) result(c)
    real, intent(in) :: k
    type(vector3d), intent(in) :: a
    type(vector3d) :: c
    c = vector3d(k * a%x, k * a%y, k * a%z)
  end function scalar_times_vector

  elemental function vec_dot(a, b) result(d)
    type(vector3d), intent(in) :: a, b
    real :: d
    d = a%x * b%x + a%y * b%y + a%z * b%z
  end function vec_dot

  elemental function vec_cross(a, b) result(c)
    type(vector3d), intent(in) :: a, b
    type(vector3d) :: c
    c = vector3d(a%y * b%z - a%z * b%y, &
                 a%z * b%x - a%x * b%z, &
                 a%x * b%y - a%y * b%x)
  end function vec_cross

end module vectors


program vector_operators
  use vectors
  implicit none
  type(vector3d) :: a, b, c
  type(vector3d) :: vec_list(3)

  a = vector3d(1.0, 2.0, 3.0)
  b = vector3d(4.0, 5.0, 6.0)

  print *, 'a + b     =', a + b
  print *, 'a - b     =', a - b
  print *, '2 * a     =', 2.0 * a

  c = a .cross. b
  print *, 'a x b     =', c
  print *, 'c . a     =', c .dot. a     ! should be 0
  print *, 'c . b     =', c .dot. b     ! should be 0

  ! User-defined binary operators (.dot.) have the LOWEST precedence:
  !   2.0 * a .dot. b  ->  (2.0*a) .dot. b   = 2 (a.b)
  !   1.0 + a .dot. b  ->  (1.0 + a) .dot. b -> error: no real + vector3d exists
  print *, '2*a . b   =', 2.0 * a .dot. b
  print *, '1 + a.b   =', 1.0 + (a .dot. b)   ! works with parentheses

  ! Since the functions are elemental, they work on arrays of vectors
  vec_list = [a, b, c]
  print *, 'list . a  =', vec_list .dot. a
end program vector_operators