# ypr_populations works

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations creates an population with 2 elements

    tmax:  20
    k:     0.15
    Linf:  1, 2
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations creates populations with 1 element when parameters same if expand

    tmax:  20
    k:     0.15
    Linf:  1
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations creates populations with 2 elements even when parameters same if not expand

    tmax:  20
    k:     0.15
    Linf:  1
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations make unique names for duplicates when not expand

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    2.5, 4.6, 2.5
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations names when not expand preserves order

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    60, 50, 50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    2.5, 4.6, 2.5
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations names when expand reorders

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50, 50, 60, 60
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    2.5, 4.6, 2.5, 4.6
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations make unique names for duplicates even with multiple parameters when not expand

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    60, 50, 60
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    2.5, 4.6, 2.5
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations but works when different length parameters if expand

    tmax:  20
    k:     0.1, 0.2, 0.3
    Linf:  1
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations creates 2 populations when 2 parameters are provided

    tmax:  20
    k:     0.15
    Linf:  1, 2
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# ypr_populations creates 2 populations when 3 parameters are provided and not expand

    tmax:  20
    k:     0.15
    Linf:  1, 2
    t0:    0
    k2:    0.15, 0.25
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   2, 1

# ypr_populations creates 8 populations when 3 parameters are provided and expand

    tmax:  20
    k:     0.15
    Linf:  1, 2, 1, 2, 1, 2, 1, 2
    t0:    0
    k2:    0.15, 0.15, 0.25, 0.25, 0.15, 0.15, 0.25, 0.25
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1, 1, 1, 1, 2, 2, 2, 2

# as_ypr_populations works if sr values are not the same

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1, 2
    BH:    1, 0
    Rk:    10, 20
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   0
    Lup:   1000
    Nc:    0
    pi:    0.2
    rho:   0
    Hm:    0
    Rmax:  2, 3
    Wa:    0.01
    fa:    1
    q:     0.1
    RPR:   1

# as_ypr_populations works if fishery values are not the same

    tmax:  20
    k:     0.15
    Linf:  100
    t0:    0
    k2:    0.15
    Linf2: 100
    L2:    1000
    Wb:    3
    Ls:    50
    Sp:    100
    es:    1
    Sm:    0
    fb:    1
    tR:    1
    BH:    1
    Rk:    3
    n:     0.2
    nL:    0.2
    Ln:    1000
    Lv:    50
    Vp:    100
    Llo:   10, 100
    Lup:   10, 100
    Nc:    0, 1
    pi:    0.1, 0.2
    rho:   0, 1
    Hm:    0, 1
    Rmax:  1
    Wa:    0.01
    fa:    1
    q:     0, 1
    RPR:   1

