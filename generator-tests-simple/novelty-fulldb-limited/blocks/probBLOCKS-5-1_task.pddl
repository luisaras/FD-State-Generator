(define (problem blocks-5-1) (:domain blocks) (:objects a d c e b) (:init (on e  d) (not (clear e)) (clear a) (clear b) (clear c) (not (clear d)) (handempty) (on a  e) (holding b) (on c  a) (on d  a)) (:goal (and (on d c) (on c b) (on b a) (on a e))))