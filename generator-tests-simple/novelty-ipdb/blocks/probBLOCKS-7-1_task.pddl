(define (problem blocks-7-1) (:domain blocks) (:objects e b d f g c a) (:init (holding d) (clear d) (clear a) (clear b) (clear c) (clear e) (clear f) (clear g) (handempty) (on a  f) (ontable b) (on c  b) (on e  d) (on f  a) (on g  b)) (:goal (and (on a e) (on e b) (on b f) (on f g) (on g c) (on c d))))