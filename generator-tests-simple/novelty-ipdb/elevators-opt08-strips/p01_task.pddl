(define (problem elevators-sequencedstrips-p8_3_1) (:domain elevators-sequencedstrips) (:objects n0 n1 n2 n3 n4 n5 n6 n7 n8 - count p0 p1 p2 - passenger fast0 - fast-elevator slow0-0 slow1-0 - slow-elevator) (:init (lift-at slow1-0  n5) (lift-at slow0-0  n3) (lift-at fast0  n2) (passengers slow0-0  n0) (passengers slow1-0  n0) (passengers fast0  n0) (passenger-at p0  n8) (passenger-at p1  n0) (passenger-at p2  n6)) (:goal (and (passenger-at p0 n4) (passenger-at p1 n6) (passenger-at p2 n1))) (:metric minimize (total-cost)))