! Program to play a bit with derived types in the context of creating a star catalogue

! here we create the module for the derived types "vector3d" and "star"
module star_module
    implicit none
    
    type :: vector3d
        real :: x, y, z
    end type vector3d

    type :: star
        character(len=:), allocatable :: name
        real :: mass
        type(vector3d) :: position
    end type star

    ! adding a center_of_mass function that calculates the center of mass of the system
contains 

    type (vector3d) function center_of_mass(array)
        !! calculates the center of mass of a system of stars

        !! arguments
        type(star), dimension(:), intent(in) :: array
        !! (in) array of type(star) variables from which to extract mass and positions of stars
        real :: x_com, y_com, z_com
        !! output of x, y and z positions of the CoM

        ! defining the components of the center of mass one by one
        x_com = sum(array%mass*array%position%x)/sum(array%mass)
        y_com = sum(array%mass*array%position%y)/sum(array%mass)
        z_com = sum(array%mass*array%position%z)/sum(array%mass)

        center_of_mass = vector3d(x_com, y_com, z_com)
        
    end function center_of_mass

end module star_module

! main program (array of 3 stars with constructors, print the names and total mass of the stars and the CoM)
program star_catalogue
    use star_module
    implicit none

    type(vector3d) :: pos
    type(star) :: s
    type(star), dimension(:), allocatable :: stars_array
    integer :: i, n_stars, all_stat_arr
    character(len=100) :: temp_name 
    real :: temp_mass

    ! asking the user the number of stars in the catalogue
    write (*, *) "Enter the number of stars in your catalogue: "
    read (*, *) n_stars

    ! allocating the array where the stars and their properties are going to be stored by construction assignment
    allocate(stars_array(n_stars), stat=all_stat_arr)
    if (all_stat_arr/=0) stop "Allocation was not successful."

    ! do loop to store the stars information inside the array
    do i=1, n_stars

        ! asking the user to enter the name of the star
        write (*, *) "Enter the name of the star: "
        read (*, *) temp_name 

        ! asking the user to enter the value of mass of the star
        write (*, *) "Enter the value of mass of the star: "
        read (*, *) temp_mass

        ! asking the user to input the values of position of the star
        write (*, *) "Enter the values of position of the star: "
        read (*, *) pos

        ! storing inside the array
        s = star(trim(temp_name), temp_mass, pos)
        stars_array(i) = s

        print *
        print *, "Name of the star: ", s%name
        print *, "Mass of the star: ", s%mass
        print *, "Position of the star (x, y, z): ", s%position%x, s%position%y, s%position%z
        print *

    end do

    ! printing the total mass of the stars in the catalogue (sum of their masses) using the array and CoM
    print *
    print *, "Total mass of the stars in the catalogue: ", sum(stars_array%mass)
    print *, "Center of mass of the system composed of the stars in the catalogue: ", center_of_mass(stars_array)

end program star_catalogue

