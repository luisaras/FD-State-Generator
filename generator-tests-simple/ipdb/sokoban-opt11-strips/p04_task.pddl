(define (problem p006-microban-sequential) (:domain sokoban-sequential) (:objects dir-down - direction dir-left - direction dir-right - direction dir-up - direction player-01 - player pos-01-01 - location pos-01-02 - location pos-01-03 - location pos-01-04 - location pos-01-05 - location pos-01-06 - location pos-02-01 - location pos-02-02 - location pos-02-03 - location pos-02-04 - location pos-02-05 - location pos-02-06 - location pos-03-01 - location pos-03-02 - location pos-03-03 - location pos-03-04 - location pos-03-05 - location pos-03-06 - location pos-04-01 - location pos-04-02 - location pos-04-03 - location pos-04-04 - location pos-04-05 - location pos-04-06 - location pos-05-01 - location pos-05-02 - location pos-05-03 - location pos-05-04 - location pos-05-05 - location pos-05-06 - location pos-06-01 - location pos-06-02 - location pos-06-03 - location pos-06-04 - location pos-06-05 - location pos-06-06 - location pos-07-01 - location pos-07-02 - location pos-07-03 - location pos-07-04 - location pos-07-05 - location pos-07-06 - location pos-08-01 - location pos-08-02 - location pos-08-03 - location pos-08-04 - location pos-08-05 - location pos-08-06 - location pos-09-01 - location pos-09-02 - location pos-09-03 - location pos-09-04 - location pos-09-05 - location pos-09-06 - location pos-10-01 - location pos-10-02 - location pos-10-03 - location pos-10-04 - location pos-10-05 - location pos-10-06 - location pos-11-01 - location pos-11-02 - location pos-11-03 - location pos-11-04 - location pos-11-05 - location pos-11-06 - location pos-12-01 - location pos-12-02 - location pos-12-03 - location pos-12-04 - location pos-12-05 - location pos-12-06 - location stone-01 - stone stone-02 - stone stone-03 - stone) (:init (clear pos-10-02) (clear pos-11-02) (clear pos-11-03) (clear pos-09-02) (clear pos-11-04) (clear pos-10-04) (clear pos-05-02) (clear pos-06-04) (clear pos-09-03) (clear pos-07-04) (clear pos-08-03) (clear pos-03-05) (clear pos-03-04) (clear pos-08-04) (clear pos-03-02) (clear pos-07-03) (clear pos-06-03) (clear pos-05-03) (clear pos-03-03) (clear pos-02-05) (clear pos-04-05) (clear pos-02-02) (clear pos-02-03) (clear pos-02-04) (clear pos-04-02) (clear pos-04-04) (clear pos-09-04) (clear pos-04-03) (at stone-01  pos-07-04) (at stone-02  pos-08-04) (at stone-03  pos-03-04) (at player-01  pos-11-03) (not (at-goal stone-03)) (not (at-goal stone-02)) (not (at-goal stone-01))) (:goal (and (at-goal stone-01) (at-goal stone-02) (at-goal stone-03))) (:metric minimize (total-cost)))