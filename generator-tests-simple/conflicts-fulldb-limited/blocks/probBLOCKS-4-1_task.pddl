(define (problem blocks-4-1) (:domain blocks) (:objects a c d b) (:init (on b  a) (not (clear b)) (clear a) (not (clear c)) (clear d) (not (handempty)) (holding a) (on c  b) (on d  c)) (:goal (and (on d c) (on c a) (on a b))))