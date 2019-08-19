TASK=../pyperplan/benchmarks/sokoban/
./fast-downward.py $(TASK)/domain.pddl $(TASK)/task01.pddl --search "astar(lmcut())"