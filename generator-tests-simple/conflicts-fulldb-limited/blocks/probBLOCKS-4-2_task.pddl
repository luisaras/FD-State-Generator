(define (problem blocks-4-2) (:domain blocks) (:objects b d c a) (:init (on d  a) (not (clear d)) (not (clear a)) (clear b) (clear c) (not (handempty)) (on a  c) (holding b) (on c  d)) (:goal (and (on a b) (on b c) (on c d))))