program wiens_law_table
    implicit none
    integer :: T
    real :: lambda_max
    real,    parameter :: b     = 2.897772e6   ! nm K (real)
    integer, parameter :: b_int = 2897772      ! nm K (entero)

    ! ---- Tabla 1: de mas frio a mas caliente (paso positivo) ----
    print *, 'Tabla 1: paso positivo'
    print *, 'T (K)    lambda_max (nm)'
    do T = 3000, 30000, 3000
        lambda_max = b / T          ! real / integer -> T se convierte a real
        print '(i6, f12.1)', T, lambda_max
    end do
    print *, 'T tras el bucle:', T
    ! El do suma el paso tras cada iteracion y despues comprueba el limite:
    ! 30000 + 3000 = 33000 > 30000 -> sale del bucle con T = 33000
    print *, 'Explicacion: tras T = 30000 se suma el paso (+3000) y'
    print *, 'T = 33000 supera el limite, asi que el bucle termina.'

    ! ---- Tabla 2: de mas caliente a mas frio (paso negativo) ----
    print *
    print *, 'Tabla 2: paso negativo'
    print *, 'T (K)    lambda_max (nm)'
    do T = 30000, 3000, -3000
        lambda_max = b / T
        print '(i6, f12.1)', T, lambda_max
    end do
    print *, 'T tras el bucle:', T
    ! 3000 - 3000 = 0 < 3000 -> sale del bucle con T = 0
    print *, 'Explicacion: tras T = 3000 se suma el paso (-3000) y'
    print *, 'T = 0 queda por debajo del limite, asi que el bucle termina.'

    ! ---- Tabla 3: b como constante entera ----
    print *
    print *, 'Tabla 3: b entera (2897772)'
    print *, 'T (K)    lambda_max (nm)'
    do T = 3000, 30000, 3000
        lambda_max = b_int / T      ! integer / integer -> division entera
        print '(i6, f12.1)', T, lambda_max
    end do
    ! La division se hace entre enteros y trunca los decimales ANTES de
    ! asignar el resultado a lambda_max (real): 966.0 -> 965, 96.6 -> 96
    print *, 'Explicacion: integer / integer es division entera y trunca'
    print *, 'los decimales (966 -> 965, 483 -> 482, 96.6 -> 96).'
    print *, 'Que lambda_max sea real no lo evita: la conversion ocurre'
    print *, 'despues de dividir.'
end program wiens_law_table