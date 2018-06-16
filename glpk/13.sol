Problem:    program
Rows:       78
Columns:    80 (80 integer, 80 binary)
Non-zeros:  550
Status:     INTEGER OPTIMAL
Objective:  numberOfWorkstations = 2 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 numberOfWorkstations
                                   2                             
     2 maxOne[E1]                  1             1             = 
     3 maxOne[E2]                  1             1             = 
     4 maxOne[E3]                  1             1             = 
     5 maxOne[E4]                  1             1             = 
     6 maxOne[E5]                  1             1             = 
     7 maxOne[E6]                  1             1             = 
     8 maxOne[E7]                  1             1             = 
     9 precedencia[E1,E2,1]
                                   0            -0               
    10 precedencia[E1,E2,2]
                                   1            -0               
    11 precedencia[E1,E2,3]
                                   1            -0               
    12 precedencia[E1,E2,4]
                                   1            -0               
    13 precedencia[E1,E2,5]
                                   1            -0               
    14 precedencia[E1,E2,6]
                                   1            -0               
    15 precedencia[E1,E2,7]
                                   1            -0               
    16 precedencia[E1,E2,8]
                                   1            -0               
    17 precedencia[E1,E2,9]
                                   1            -0               
    18 precedencia[E1,E2,10]
                                   1            -0               
    19 precedencia[E1,E4,1]
                                   0            -0               
    20 precedencia[E1,E4,2]
                                   1            -0               
    21 precedencia[E1,E4,3]
                                   1            -0               
    22 precedencia[E1,E4,4]
                                   1            -0               
    23 precedencia[E1,E4,5]
                                   1            -0               
    24 precedencia[E1,E4,6]
                                   1            -0               
    25 precedencia[E1,E4,7]
                                   1            -0               
    26 precedencia[E1,E4,8]
                                   1            -0               
    27 precedencia[E1,E4,9]
                                   1            -0               
    28 precedencia[E1,E4,10]
                                   1            -0               
    29 precedencia[E2,E3,1]
                                   1            -0               
    30 precedencia[E2,E3,2]
                                   1            -0               
    31 precedencia[E2,E3,3]
                                   1            -0               
    32 precedencia[E2,E3,4]
                                   1            -0               
    33 precedencia[E2,E3,5]
                                   1            -0               
    34 precedencia[E2,E3,6]
                                   1            -0               
    35 precedencia[E2,E3,7]
                                   1            -0               
    36 precedencia[E2,E3,8]
                                   1            -0               
    37 precedencia[E2,E3,9]
                                   1            -0               
    38 precedencia[E2,E3,10]
                                   0            -0               
    39 precedencia[E2,E5,1]
                                   1            -0               
    40 precedencia[E2,E5,2]
                                   1            -0               
    41 precedencia[E2,E5,3]
                                   1            -0               
    42 precedencia[E2,E5,4]
                                   1            -0               
    43 precedencia[E2,E5,5]
                                   1            -0               
    44 precedencia[E2,E5,6]
                                   1            -0               
    45 precedencia[E2,E5,7]
                                   1            -0               
    46 precedencia[E2,E5,8]
                                   1            -0               
    47 precedencia[E2,E5,9]
                                   1            -0               
    48 precedencia[E2,E5,10]
                                   0            -0               
    49 precedencia[E4,E7,1]
                                   0            -0               
    50 precedencia[E4,E7,2]
                                   1            -0               
    51 precedencia[E4,E7,3]
                                   1            -0               
    52 precedencia[E4,E7,4]
                                   1            -0               
    53 precedencia[E4,E7,5]
                                   1            -0               
    54 precedencia[E4,E7,6]
                                   1            -0               
    55 precedencia[E4,E7,7]
                                   1            -0               
    56 precedencia[E4,E7,8]
                                   1            -0               
    57 precedencia[E4,E7,9]
                                   1            -0               
    58 precedencia[E4,E7,10]
                                   1            -0               
    59 precedencia[E5,E6,1]
                                   0            -0               
    60 precedencia[E5,E6,2]
                                   0            -0               
    61 precedencia[E5,E6,3]
                                   0            -0               
    62 precedencia[E5,E6,4]
                                   0            -0               
    63 precedencia[E5,E6,5]
                                   0            -0               
    64 precedencia[E5,E6,6]
                                   0            -0               
    65 precedencia[E5,E6,7]
                                   0            -0               
    66 precedencia[E5,E6,8]
                                   0            -0               
    67 precedencia[E5,E6,9]
                                   0            -0               
    68 precedencia[E5,E6,10]
                                   0            -0               
    69 ciclo[1]                   -4                          -0 
    70 ciclo[2]                    0                          -0 
    71 ciclo[3]                    0                          -0 
    72 ciclo[4]                    0                          -0 
    73 ciclo[5]                    0                          -0 
    74 ciclo[6]                    0                          -0 
    75 ciclo[7]                    0                          -0 
    76 ciclo[8]                    0                          -0 
    77 ciclo[9]                    0                          -0 
    78 ciclo[10]                  -3                          -0 

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 x[1,E1]      *              1             0             1 
     2 x[2,E1]      *              0             0             1 
     3 x[3,E1]      *              0             0             1 
     4 x[4,E1]      *              0             0             1 
     5 x[5,E1]      *              0             0             1 
     6 x[6,E1]      *              0             0             1 
     7 x[7,E1]      *              0             0             1 
     8 x[8,E1]      *              0             0             1 
     9 x[9,E1]      *              0             0             1 
    10 x[10,E1]     *              0             0             1 
    11 x[1,E2]      *              1             0             1 
    12 x[2,E2]      *              0             0             1 
    13 x[3,E2]      *              0             0             1 
    14 x[4,E2]      *              0             0             1 
    15 x[5,E2]      *              0             0             1 
    16 x[6,E2]      *              0             0             1 
    17 x[7,E2]      *              0             0             1 
    18 x[8,E2]      *              0             0             1 
    19 x[9,E2]      *              0             0             1 
    20 x[10,E2]     *              0             0             1 
    21 x[1,E3]      *              0             0             1 
    22 x[2,E3]      *              0             0             1 
    23 x[3,E3]      *              0             0             1 
    24 x[4,E3]      *              0             0             1 
    25 x[5,E3]      *              0             0             1 
    26 x[6,E3]      *              0             0             1 
    27 x[7,E3]      *              0             0             1 
    28 x[8,E3]      *              0             0             1 
    29 x[9,E3]      *              0             0             1 
    30 x[10,E3]     *              1             0             1 
    31 x[1,E4]      *              1             0             1 
    32 x[2,E4]      *              0             0             1 
    33 x[3,E4]      *              0             0             1 
    34 x[4,E4]      *              0             0             1 
    35 x[5,E4]      *              0             0             1 
    36 x[6,E4]      *              0             0             1 
    37 x[7,E4]      *              0             0             1 
    38 x[8,E4]      *              0             0             1 
    39 x[9,E4]      *              0             0             1 
    40 x[10,E4]     *              0             0             1 
    41 x[1,E5]      *              0             0             1 
    42 x[2,E5]      *              0             0             1 
    43 x[3,E5]      *              0             0             1 
    44 x[4,E5]      *              0             0             1 
    45 x[5,E5]      *              0             0             1 
    46 x[6,E5]      *              0             0             1 
    47 x[7,E5]      *              0             0             1 
    48 x[8,E5]      *              0             0             1 
    49 x[9,E5]      *              0             0             1 
    50 x[10,E5]     *              1             0             1 
    51 x[1,E6]      *              0             0             1 
    52 x[2,E6]      *              0             0             1 
    53 x[3,E6]      *              0             0             1 
    54 x[4,E6]      *              0             0             1 
    55 x[5,E6]      *              0             0             1 
    56 x[6,E6]      *              0             0             1 
    57 x[7,E6]      *              0             0             1 
    58 x[8,E6]      *              0             0             1 
    59 x[9,E6]      *              0             0             1 
    60 x[10,E6]     *              1             0             1 
    61 x[1,E7]      *              1             0             1 
    62 x[2,E7]      *              0             0             1 
    63 x[3,E7]      *              0             0             1 
    64 x[4,E7]      *              0             0             1 
    65 x[5,E7]      *              0             0             1 
    66 x[6,E7]      *              0             0             1 
    67 x[7,E7]      *              0             0             1 
    68 x[8,E7]      *              0             0             1 
    69 x[9,E7]      *              0             0             1 
    70 x[10,E7]     *              0             0             1 
    71 y[1]         *              1             0             1 
    72 y[2]         *              0             0             1 
    73 y[3]         *              0             0             1 
    74 y[4]         *              0             0             1 
    75 y[5]         *              0             0             1 
    76 y[6]         *              0             0             1 
    77 y[7]         *              0             0             1 
    78 y[8]         *              0             0             1 
    79 y[9]         *              0             0             1 
    80 y[10]        *              1             0             1 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
