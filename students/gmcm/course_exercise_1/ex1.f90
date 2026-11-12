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
    integer :: u_in, ios, i, n
    real(dp) :: dt, dt_out, t_end
    type(particle3d), allocatable :: particles(:)

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
end program ex1
