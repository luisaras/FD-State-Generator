(define (problem blocks-7-1) (:domain blocks) (:objects e b d f g c a) (:init (holding d) (not (clear d)) (clear a) (clear b) (clear c) (clear e) (not (clear f)) (clear g) (handempty) (holding a) (on b  f) (holding c) (on e  b) (on f  b) (on g  c)) (:goal (and (on a e) (on e b) (on b f) (on f g) (on g c) (on c d))))