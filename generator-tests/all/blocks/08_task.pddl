(define (problem blocks-6-1) (:domain blocks) (:objects f d c e b a - block) (:init (holding d) (not (clear d)) (clear a) (clear b) (clear c) (not (clear e)) (clear f) (handempty) (on a  c) (on b  e) (holding c) (on e  a) (on f  a)) (:goal (and (on e f) (on f c) (on c b) (on b a) (on a d))))