(define (problem blocks-7-2) (:domain blocks) (:objects e g c d f a b) (:init (on g  d) (clear g) (clear a) (clear b) (clear c) (not (clear d)) (clear e) (clear f) (handempty) (holding a) (holding b) (holding c) (on d  b) (on e  a) (holding f)) (:goal (and (on e b) (on b f) (on f d) (on d a) (on a c) (on c g))))