(define (problem blocks-7-2) (:domain blocks) (:objects e g c d f a b) (:init (holding g) (clear g) (clear a) (clear b) (clear c) (clear d) (clear e) (clear f) (handempty) (ontable a) (on b  a) (on c  d) (on d  g) (on e  d) (on f  a)) (:goal (and (on e b) (on b f) (on f d) (on d a) (on a c) (on c g))))