! Particles for the N-body simulation.

module particle
    use geometry
    implicit none

    ! A particle: its position, its velocity, and its mass
    type :: particle3d
        type(point3d) :: p
        type(vector3d) :: v
        real(dp) :: m
    end type particle3d
end module particle
