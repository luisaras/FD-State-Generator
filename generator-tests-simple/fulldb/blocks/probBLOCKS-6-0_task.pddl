(define (problem blocks-6-0) (:domain blocks) (:objects e a b c f d) (:init (on d  b) (not (clear d)) (not (clear a)) (not (clear b)) (not (clear c)) (clear e) (not (clear f)) (handempty) (on a  f) (on b  c) (on c  a) (on e  d) (on f  a)) (:goal (and (on c b) (on b a) (on a e) (on e f) (on f d))))