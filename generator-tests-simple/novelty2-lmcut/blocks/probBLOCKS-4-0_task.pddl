(define (problem blocks-4-0) (:domain blocks) (:objects d b a c) (:init (holding a) (not (clear a)) (clear b) (clear c) (clear d) (handempty) (ontable b) (ontable c) (on d  b)) (:goal (and (on d c) (on c b) (on b a))))