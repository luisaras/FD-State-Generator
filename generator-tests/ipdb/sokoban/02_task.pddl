(define (problem p024-microban-sequential) (:domain sokoban-sequential) (:objects dir-down - direction dir-left - direction dir-right - direction dir-up - direction player-01 - player pos-1-1 - location pos-1-2 - location pos-1-3 - location pos-1-4 - location pos-1-5 - location pos-1-6 - location pos-1-7 - location pos-2-1 - location pos-2-2 - location pos-2-3 - location pos-2-4 - location pos-2-5 - location pos-2-6 - location pos-2-7 - location pos-3-1 - location pos-3-2 - location pos-3-3 - location pos-3-4 - location pos-3-5 - location pos-3-6 - location pos-3-7 - location pos-4-1 - location pos-4-2 - location pos-4-3 - location pos-4-4 - location pos-4-5 - location pos-4-6 - location pos-4-7 - location pos-5-1 - location pos-5-2 - location pos-5-3 - location pos-5-4 - location pos-5-5 - location pos-5-6 - location pos-5-7 - location pos-6-1 - location pos-6-2 - location pos-6-3 - location pos-6-4 - location pos-6-5 - location pos-6-6 - location pos-6-7 - location pos-7-1 - location pos-7-2 - location pos-7-3 - location pos-7-4 - location pos-7-5 - location pos-7-6 - location pos-7-7 - location stone-01 - stone stone-02 - stone) (:init (clear pos-6-2) (clear pos-5-2) (not (clear pos-5-3)) (clear pos-6-3) (clear pos-4-2) (clear pos-6-5) (clear pos-6-6) (clear pos-5-5) (not (clear pos-5-6)) (clear pos-2-5) (clear pos-3-4) (clear pos-3-5) (clear pos-4-3) (clear pos-2-4) (clear pos-2-6) (clear pos-3-6) (clear pos-4-4) (at stone-01  pos-5-6) (clear pos-4-6) (clear pos-4-5) (at player-01  pos-2-4) (at stone-02  pos-5-3) (not (at-goal stone-02)) (at-goal stone-01)) (:goal (and (at-goal stone-01) (at-goal stone-02))))