(define (problem blocks-5-1) (:domain blocks) (:objects a d c e b) (:init (on e  c) (not (clear e)) (not (clear a)) (clear b) (not (clear c)) (clear d) (not (handempty)) (on a  e) (on b  a) (on c  a) (holding d)) (:goal (and (on d c) (on c b) (on b a) (on a e))))