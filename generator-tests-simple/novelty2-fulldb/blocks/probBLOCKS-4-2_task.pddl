(define (problem blocks-4-2) (:domain blocks) (:objects b d c a) (:init (on d  a) (not (clear d)) (not (clear a)) (not (clear b)) (clear c) (handempty) (on a  d) (on b  d) (on c  b)) (:goal (and (on a b) (on b c) (on c d))))