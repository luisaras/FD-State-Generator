(define (problem blocks-7-2) (:domain blocks) (:objects e g c d f a b) (:init (on g  d) (not (clear g)) (clear a) (not (clear b)) (not (clear c)) (not (clear d)) (clear e) (clear f) (handempty) (holding a) (on b  c) (on c  g) (on d  g) (on e  b) (on f  a)) (:goal (and (on e b) (on b f) (on f d) (on d a) (on a c) (on c g))))