(define (problem blocks-5-1) (:domain blocks) (:objects a d c e b - block) (:init (holding e) (not (clear e)) (clear a) (clear b) (clear c) (clear d) (handempty) (on a  c) (ontable b) (on c  a) (on d  a)) (:goal (and (on d c) (on c b) (on b a) (on a e))))