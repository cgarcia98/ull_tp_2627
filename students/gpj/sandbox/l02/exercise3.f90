module habitable_zone_module
    implicit none
contains
    function hz_edges(L) result(zone)
        real, intent(in) :: L       ! Luminosidad (L_sol)
        real :: zone(2)             ! (r_in, r_out) en UA
        zone(1) = sqrt(L / 1.1)
        zone(2) = sqrt(L / 0.53)
    end function hz_edges

    function apsides(a, e) result(r)
        real, intent(in) :: a, e    ! a en UA
        real :: r(2)                ! (periapsis, apoapsis) en UA
        r(1) = a * (1.0 - e)
        r(2) = a * (1.0 + e)
    end function apsides
end module habitable_zone_module

program hz_check
    use habitable_zone_module
    implicit none
    real :: L, a, e
    real :: zone(2), r(2)
    logical :: peri_in, apo_in

    print *, 'L (L_sol), a (UA), e:'
    read *, L, a, e

    if (e < 0.0 .or. e >= 1.0) then
        print *, 'Error: 0 <= e < 1'
        stop
    end if

    zone = hz_edges(L)
    r    = apsides(a, e)

    peri_in = (r(1) >= zone(1)) .and. (r(1) <= zone(2))
    apo_in  = (r(2) >= zone(1)) .and. (r(2) <= zone(2))

    if (peri_in .and. apo_in) then
        print *, 'always'
    else if (peri_in .neqv. apo_in) then
        print *, 'partly'
    else if (r(2) < zone(1)) then
        print *, 'never (too hot)'
    else if (r(1) > zone(2)) then
        print *, 'never (too cold)'
    else
        print *, 'partly'   ! la orbita cruza toda la zona
    end if
end program hz_check