(define (problem transport-l4-t1-p3---int100n150-m25---int100c150---s1---e0) (:domain transport-strips) (:objects l0 l1 l2 l3 - location t0 - truck p0 p1 p2 - package level0 level1 level2 level3 level4 level5 level6 level7 level8 level9 level10 level11 level12 level13 level14 level15 level16 level17 level18 level19 level20 level21 level22 level23 level24 level25 level26 level27 level28 level29 level30 level31 level32 level33 level34 level35 level36 - fuellevel) (:init (at t0  l2) (fuel t0  level25) (at p2  l3) (at p1  l1) (at p0  l0)) (:goal (and (at p0 l1) (at p1 l0) (at p2 l0))) (:metric minimize (total-cost)))