(define (problem transport-two-cities-sequential-4nodes-1000size-2degree-100mindistance-2trucks-3packages-2008seed) (:domain transport) (:objects city-1-loc-1 - location city-2-loc-1 - location city-1-loc-2 - location city-2-loc-2 - location city-1-loc-3 - location city-2-loc-3 - location city-1-loc-4 - location city-2-loc-4 - location truck-1 - vehicle truck-2 - vehicle package-1 - package package-2 - package package-3 - package capacity-0 - capacity-number capacity-1 - capacity-number capacity-2 - capacity-number capacity-3 - capacity-number capacity-4 - capacity-number) (:init (at truck-2  city-2-loc-4) (at truck-1  city-2-loc-4) (capacity truck-1  capacity-1) (capacity truck-2  capacity-1) (at package-1  city-2-loc-4) (at package-2  city-1-loc-2) (at package-3  city-1-loc-4)) (:goal (and (at package-1 city-2-loc-2) (at package-2 city-2-loc-3) (at package-3 city-2-loc-1))) (:metric minimize (total-cost)))