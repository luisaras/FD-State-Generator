(define (problem blocks-7-1) (:domain blocks) (:objects e b d f g c a) (:init (holding d) (not (clear d)) (clear a) (clear b) (not (clear c)) (clear e) (not (clear f)) (not (clear g)) (handempty) (holding a) (on b  f) (on c  b) (on e  g) (on f  b) (on g  c)) (:goal (and (on a e) (on e b) (on b f) (on f g) (on g c) (on c d))))