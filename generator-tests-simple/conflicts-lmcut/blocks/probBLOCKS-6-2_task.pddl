(define (problem blocks-6-2) (:domain blocks) (:objects e f b d c a) (:init (holding d) (not (clear d)) (not (clear a)) (not (clear b)) (clear c) (clear e) (not (clear f)) (not (handempty)) (on a  b) (on b  a) (holding c) (on e  f) (on f  a)) (:goal (and (on e f) (on f a) (on a b) (on b c) (on c d))))