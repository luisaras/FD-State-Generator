(define (problem blocks-6-1) (:domain blocks) (:objects f d c e b a) (:init (holding d) (not (clear d)) (clear a) (clear b) (clear c) (clear e) (clear f) (handempty) (on a  f) (on b  c) (ontable c) (on e  b) (on f  a)) (:goal (and (on e f) (on f c) (on c b) (on b a) (on a d))))