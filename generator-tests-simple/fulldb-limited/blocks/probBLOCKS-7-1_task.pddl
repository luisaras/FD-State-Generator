(define (problem blocks-7-1) (:domain blocks) (:objects e b d f g c a) (:init (on d  g) (clear d) (clear a) (clear b) (clear c) (clear e) (not (clear f)) (not (clear g)) (not (handempty)) (holding a) (holding b) (holding c) (on e  c) (holding f) (on g  b)) (:goal (and (on a e) (on e b) (on b f) (on f g) (on g c) (on c d))))