(define (problem blocks-6-0) (:domain blocks) (:objects e a b c f d - block) (:init (holding d) (not (clear d)) (clear a) (clear b) (clear c) (clear e) (clear f) (handempty) (on a  c) (ontable b) (holding c) (on e  a) (on f  a)) (:goal (and (on c b) (on b a) (on a e) (on e f) (on f d))))