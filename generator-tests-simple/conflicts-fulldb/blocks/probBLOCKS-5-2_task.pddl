(define (problem blocks-5-2) (:domain blocks) (:objects a c e b d) (:init (on a  c) (clear a) (not (clear b)) (not (clear c)) (clear d) (not (clear e)) (not (handempty)) (on b  e) (on c  b) (holding d) (on e  b)) (:goal (and (on d c) (on c b) (on b e) (on e a))))