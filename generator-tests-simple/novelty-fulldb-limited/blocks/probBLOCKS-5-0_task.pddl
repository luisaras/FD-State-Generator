(define (problem blocks-5-0) (:domain blocks) (:objects b e a c d) (:init (on a  b) (not (clear a)) (not (clear b)) (not (clear c)) (clear d) (handempty) (on b  c) (on c  a) (on d  b)) (:goal (and (on a e) (on e b) (on b d) (on d c))))