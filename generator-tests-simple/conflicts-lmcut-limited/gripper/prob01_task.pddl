(define (problem strips-gripper-x-1) (:domain gripper-strips) (:objects rooma roomb ball4 ball3 ball2 ball1 left right) (:init (at-robby roomb) (carry ball2  left) (at ball1  rooma) (at ball2  rooma)) (:goal (and (at ball2 roomb) (at ball1 roomb))))