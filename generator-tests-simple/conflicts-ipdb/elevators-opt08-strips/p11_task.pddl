(define (problem elevators-sequencedstrips-p12_3_7) (:domain elevators-sequencedstrips) (:objects n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 - count p0 p1 p2 - passenger fast0 - fast-elevator slow0-0 slow1-0 - slow-elevator) (:init (lift-at slow1-0  n10) (lift-at slow0-0  n6) (lift-at fast0  n12) (passengers slow0-0  n0) (passengers slow1-0  n0) (passengers fast0  n1) (boarded p0  fast0) (passenger-at p1  n0) (passenger-at p2  n8)) (:goal (and (passenger-at p0 n3) (passenger-at p1 n11) (passenger-at p2 n7))) (:metric minimize (total-cost)))