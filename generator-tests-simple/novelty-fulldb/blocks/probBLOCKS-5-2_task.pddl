(define (problem blocks-5-2) (:domain blocks) (:objects a c e b d) (:init (on a  b) (not (clear a)) (not (clear b)) (not (clear c)) (not (clear d)) (clear e) (handempty) (on b  c) (on c  a) (on d  b) (on e  d)) (:goal (and (on d c) (on c b) (on b e) (on e a))))