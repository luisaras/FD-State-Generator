(define (problem blocks-7-2) (:domain blocks) (:objects e g c d f a b) (:init (on g  e) (clear g) (clear a) (clear b) (clear c) (clear d) (not (clear e)) (clear f) (handempty) (holding a) (holding b) (holding c) (holding d) (on e  a) (on f  b)) (:goal (and (on e b) (on b f) (on f d) (on d a) (on a c) (on c g))))