! Program to calculate iteratively and recursively the factorial of a given number and the nth number of Fibonacci's series

module recursive_functions
    implicit none

contains

    recursive function factorial(n) result(f)
    !! recursive function that calculates the factorial 
    !! of a given number

        !! arguments
        integer, intent(in) :: n
        !! (in) number to calculate the factorial for
        integer :: f
        !! (res) result of the recursive factorial function

        if (n==0 .or. n==1) then
            f = 1
        else if (n < 0) then
            print *, "Negative numbers not allowed."
            f = -1
        else 
            f = n*factorial(n-1)
        end if

    end function factorial

    recursive function fibonacci(n) result(f)
    !! recusive function to output the nth number in the Fibonacci series

        !! arguments
        integer, intent(in) :: n
        !! (in) nth placed number in the fibonacci series to be retrieved 
        integer :: f
        !! (res) number located in the nth place of the fibonacci series

        if (n==0) then
            f = 0
        else if (n==1) then
            f = 1
        else if (n < 0) then
            print *, "Negative numbers not allowed."
            f = -1
        else 
            f = fibonacci(n-1) + fibonacci(n-2)
        end if

    end function fibonacci 

end module recursive_functions

program factorial_fibonacci
    use recursive_functions, only: factorial, fibonacci
    implicit none

    real :: start_time_iter, end_time_iter, start_time_rec, end_time_rec
    real :: start_time_iter_fib, end_time_iter_fib, start_time_rec_fib, end_time_rec_fib
    integer :: i, factorial_number, fib_number, product, factorial_result, fib_result, curr_num, prev_num, next_num, counter

!! ------------------------------------------------------------------------------------------------------------------------------------------ !!
!! Factorial part of the code !!
!! ------------------------------------------------------------------------------------------------------------------------------------------ !!

    write (*, *) "Enter the number you want to calculate the factorial for: "
    read (*, *) factorial_number
    if (factorial_number<0) stop "Negative numbers not allowed."

    print *
    print *, "Recursion based factorial result: "

    call cpu_time(start_time_rec)

    factorial_result = factorial(factorial_number)
    write (*, "(a, i5, a, i5)") "Factorial of", factorial_number, " is: ", factorial_result

    call cpu_time(end_time_rec)

    print *, "Compilation time (recursion based): ", end_time_rec - start_time_rec

    print *

    print *, "Iteration based factorial result: "

    call cpu_time(start_time_iter) ! start time of factorial iteration loop 

    ! do loop to calculate factorial of a number
    product=1
    do i=1, factorial_number
        product = product*(i)
    end do

    write (*, "(a, i5, a, i5)") "Factorial of : ", factorial_number, " is: ", product

    call cpu_time(end_time_iter) ! end time of factorial interation loop

    print *, "Compilation time (iteration based): ", end_time_iter - start_time_iter

!! ------------------------------------------------------------------------------------------------------------------------------------------!!
!! Fibonacci part of the code !!
!! ------------------------------------------------------------------------------------------------------------------------------------------!!

    print *
    write (*, *) "Enter the position of the number you want to retireve in the fibonacci series: "
    read (*, *) fib_number
    if (fib_number<0) stop "Negative numbers not allowed."

    print *
    print *, "Recursion based fibonacci result: "

    call cpu_time(start_time_rec_fib)

    fib_result = fibonacci(fib_number)
    write (*, "(a, i5, a, i5)") "At position: ", fib_number, " the corresponding value in the fibonacci series is: ", fib_result

    call cpu_time(end_time_rec_fib)

    print *, "Compilation time (recursion based): ", end_time_rec_fib - start_time_rec_fib

    print *

    print *, "Iteration based fibonacci result: "

    call cpu_time(start_time_iter_fib) ! start time of factorial iteration loop 

    ! do loop to calculate fibonacci nth number value
    ! iterative implementation
    prev_num = 0
    curr_num = 1
    if (fib_number==0) then
        curr_num = 0
        write (*, "(a, i3, a, i3)") "Number position: ", fib_number, "; Fibonacci number: ", curr_num

    else if (fib_number==1) then
        curr_num = 1
        write (*, "(a, i3, a, i3)") "Number position: ", fib_number, "; Fibonacci number: ", curr_num

    else 
        do counter=2, fib_number
            next_num = curr_num + prev_num
            prev_num = curr_num
            curr_num = next_num
        end do 
        write (*, "(a, i3, a, i3)") "Number position: ", fib_number, "; Fibonacci number: ", curr_num
    end if

    !write (*, "(a, i5, a, i5)") "At position: ", fib_number, " the corresponding value in the fibonacci series is: ", curr_num

    call cpu_time(end_time_iter_fib) ! end time of factorial interation loop

    print *, "Compilation time (iteration based): ", end_time_iter_fib - start_time_iter_fib

end program factorial_fibonacci