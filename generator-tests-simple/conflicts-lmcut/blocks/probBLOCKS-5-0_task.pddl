(define (problem blocks-5-0) (:domain blocks) (:objects b e a c d) (:init (on c  e) (clear c) (clear a) (not (clear b)) (not (clear d)) (not (clear e)) (not (handempty)) (holding a) (on b  d) (on d  b) (on e  b)) (:goal (and (on a e) (on e b) (on b d) (on d c))))