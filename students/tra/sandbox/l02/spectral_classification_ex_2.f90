! Program to print the spectral class of a given star given its temperature using a select case statement.

program spectral_class

    implicit none
    integer :: temperature
    character(len=1) :: class_letter
    logical :: in_sequence

    ! here we ask the user to input the value of temprature of the star he/she wants to classify
    write (*, "(a)") "Enter the value of temperature (K) of your star: "
    read (*, *) temperature

    write (*, "(a, i6, a)") "Temperature of your star: ", temperature, " (K)"

    ! select case statement to print to the user the spectral-type of its star
    in_sequence = .true.
    select case (temperature)
    case (30000:)
        class_letter = "O"
    case (10000:29999)
        class_letter = "B"
    case (7500:9999)
        class_letter = "A"
    case (6000:7499)
        class_letter = "F"
    case (5200:5999)
        class_letter = "G"
    case (3700:5199)
        class_letter = "K"
    case (2400:3699)
        class_letter = "M"
    case default 
        in_sequence = .false.
    end select

    ! printing different messages if the star is considered inside our sequence of classes or not
    if (in_sequence) then
        print *, class_letter // " spectral-type star."
    else
        print *, "The temperature of the star is out of the scope of this classifier."
    end if
        
end program spectral_class