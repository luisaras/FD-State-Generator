(define (problem blocks-7-0) (:domain blocks) (:objects c f a b g d e) (:init (on e  d) (not (clear e)) (clear a) (clear b) (clear c) (not (clear d)) (not (clear f)) (not (clear g)) (handempty) (holding a) (on b  f) (on c  b) (on d  e) (on f  g) (on g  e)) (:goal (and (on a g) (on g d) (on d b) (on b c) (on c f) (on f e))))