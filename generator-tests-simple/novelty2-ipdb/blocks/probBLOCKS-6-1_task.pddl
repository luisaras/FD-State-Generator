(define (problem blocks-6-1) (:domain blocks) (:objects f d c e b a) (:init (holding d) (clear d) (clear a) (clear b) (clear c) (clear e) (clear f) (handempty) (on a  f) (on b  c) (on c  d) (ontable e) (on f  a)) (:goal (and (on e f) (on f c) (on c b) (on b a) (on a d))))