(define (problem blocks-4-1) (:domain blocks) (:objects a c d b - block) (:init (on b  d) (clear b) (clear a) (clear c) (not (clear d)) (handempty) (ontable a) (ontable c) (on d  b)) (:goal (and (on d c) (on c a) (on a b))))