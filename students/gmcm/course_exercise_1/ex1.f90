! Direct N-body simulation with the leapfrog (kick-drift-kick) integrator.
!
! Usage: ./ex1 <input file>
!
! The input file contains:
!
!   dt                  time step
!   dt_out              time between outputs
!   t_end               end time of the simulation
!   n                   number of particles
!   m x y z vx vy vz    mass, position, and velocity (one line per particle)
!
! The units are chosen so that the gravitational constant G = 1.

program ex1
    use iso_fortran_env, only: error_unit
    use geometry
    use particle
    implicit none

    character(len=256) :: input_file, msg
    integer :: u_in, ios, i, n, step, n_steps
    real(dp) :: dt, dt_out, t_end
    type(particle3d), allocatable :: particles(:)
    type(vector3d), allocatable :: a(:)   ! acceleration of each particle

    ! The name of the input file is the only command-line argument
    if (command_argument_count() /= 1) then
        write(error_unit, '(a)') 'Usage: ./ex1 <input file>'
        stop 1
    end if
    call get_command_argument(1, input_file)

    ! Read the simulation setup, one value per line
    open(newunit=u_in, file=input_file, status='old', action='read', iostat=ios, iomsg=msg)
    call check_io(ios, msg, 'opening ' // trim(input_file))

    read(u_in, *, iostat=ios, iomsg=msg) dt
    call check_io(ios, msg, 'reading dt')
    read(u_in, *, iostat=ios, iomsg=msg) dt_out
    call check_io(ios, msg, 'reading dt_out')
    read(u_in, *, iostat=ios, iomsg=msg) t_end
    call check_io(ios, msg, 'reading t_end')
    read(u_in, *, iostat=ios, iomsg=msg) n
    call check_io(ios, msg, 'reading n')

    if (dt <= 0.0_dp .or. dt_out <= 0.0_dp .or. t_end <= 0.0_dp .or. n < 1) then
        write(error_unit, '(a)') 'Error: dt, dt_out, and t_end must be positive, and n at least 1'
        stop 1
    end if

    ! Read the particles. The file gives m x y z vx vy vz, but the type
    ! stores p, v, m, 
    allocate(particles(n))
    do i = 1, n
        read(u_in, *, iostat=ios, iomsg=msg) particles(i)%m, particles(i)%p, particles(i)%v
        if (ios /= 0) then
            write(error_unit, '(a, i0, 2a)') 'Error reading particle ', i, ': ', trim(msg)
            stop 1
        end if
    end do
    close(u_in)

    print '(3a, i0, a)', 'Read ', trim(input_file), ': ', n, ' particles'
    print '(3(a, es10.3))', 'dt =', dt, ', dt_out =', dt_out, ', t_end =', t_end

    ! Accelerations at t = 0
    allocate(a(n))
    call accelerations(particles, a)

    ! Leapfrog, kick-drift-kick. Each step starts with the accelerations
    ! of the previous one, so the forces are computed only once per step.
    ! dt/2 is written in parentheses because a vector can only be divided
    ! by a real(dp), and (a * dt) / 2 would divide it by the integer 2
    n_steps = nint(t_end / dt)
    do step = 1, n_steps
        particles%v = particles%v + a * (dt/2)          ! kick: half a step
        particles%p = particles%p + particles%v * dt    ! drift: a whole step
        call accelerations(particles, a)                ! force at the new positions
        particles%v = particles%v + a * (dt/2)          ! kick: half a step
    end do

contains

    ! error message if an I/O statement failed
    subroutine check_io(stat, message, what)
        integer, intent(in) :: stat
        character(len=*), intent(in) :: message, what
        if (stat /= 0) then
            write(error_unit, '(4a)') 'Error ', what, ': ', trim(message)
            stop 1
        end if
    end subroutine check_io

    ! Gravitational acceleration of each particle due to all the others:
    ! a_i = sum over j /= i of m_j (r_j - r_i) / |r_j - r_i|^3, with G = 1.
    ! Each a(i) is summed over all j, so every pair is computed twice (once
    ! for i and once for j), but a(i) is only written by iteration i
    subroutine accelerations(particles, a)
        type(particle3d), intent(in) :: particles(:)
        type(vector3d), intent(out) :: a(:)
        type(vector3d) :: d   ! from particle i to particle j
        real(dp) :: r         ! distance between particles i and j
        integer :: i, j

        do i = 1, size(particles)
            a(i) = vector3d(0.0_dp, 0.0_dp, 0.0_dp)
            do j = 1, size(particles)
                if (j == i) cycle
                d = particles(j)%p - particles(i)%p
                r = distance(particles(j)%p, particles(i)%p)
                a(i) = a(i) + (particles(j)%m / r**3) * d
            end do
        end do
    end subroutine accelerations
end program ex1
