(define (problem blocks-6-0) (:domain blocks) (:objects e a b c f d) (:init (on d  b) (not (clear d)) (clear a) (not (clear b)) (clear c) (clear e) (clear f) (handempty) (holding a) (on b  d) (holding c) (on e  d) (on f  a)) (:goal (and (on c b) (on b a) (on a e) (on e f) (on f d))))