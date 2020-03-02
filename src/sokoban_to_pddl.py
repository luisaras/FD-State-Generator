#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
try:
    # Python 3.x
    from builtins import open as file_open
except ImportError:
    # Python 2.x
    from codecs import open as file_open

class Stage:

    def __init__(self, name):
        self.name = name
        self.pos = {}
        self.move_dir = []
        self.player_pos = ""
        self.stone_pos = []
        self.lines = []

    def add_pos(self, x, y, t):
        name = "pos-%s-%s" % (x, y)
        top = "pos-%s-%s" % (x, y-1)
        left = "pos-%s-%s" % (x-1, y)
        if top in self.pos and self.pos[top] > 0: # is floor
            self.move_dir.append(name + " " + top + " dir-up")
            self.move_dir.append(top + " " + name + " dir-down")
        if left in self.pos and self.pos[left] > 0: # is floor
            self.move_dir.append(name + " " + left + " dir-left")
            self.move_dir.append(left + " " + name + " dir-right")
            # MOVE-DIR pos-6-1 pos-7-1 dir-right
        self.pos[name] = t

    def add_player(self, x, y, goal):
        if goal:
            self.add_pos(x, y, 4)
        else:
            self.add_pos(x, y, 3)
        self.player_pos = "pos-%s-%s" % (x, y)

    def add_stone(self, x, y, goal):
        if goal:
            self.add_pos(x, y, 4)
        else:
            self.add_pos(x, y, 3)
        self.stone_pos.append("pos-%s-%s" % (x, y))


class ParseError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return self.value

def read_stage(in_file, name):
    y = 1
    line = in_file.readline()
    stage = Stage(name)
    while line:
        stage.lines.append(line)
        x = 1
        for c in line:
            if c == '#':
                stage.add_pos(x, y, 0)
            elif c == ' ':
                stage.add_pos(x, y, 1)
            elif c == '.':
                stage.add_pos(x, y, 2)
            elif c == '@':
                stage.add_player(x, y, False)
            elif c == '$':
                stage.add_stone(x, y, False)
            elif c == '*':
                stage.add_stone(x, y, True)
            elif c == '\n':
                pass
            else:
                raise ParseError("Invalid tile: %s" % c)
            x += 1
        y += 1
        line = in_file.readline()
    in_file.close()
    return stage

def write_pddl(out_file, stage):
    # Map
    for line in stage.lines:
        out_file.write(";; " + line)
    out_file.write("\n")

    # Stage
    out_file.write("(define (problem %s)" % stage.name + " \n")
    out_file.write("  (:domain sokoban-sequential)\n")
    out_file.write("  (:objects\n")
    out_file.write("    dir-down - direction\n")
    out_file.write("    dir-left - direction\n")
    out_file.write("    dir-right - direction\n")
    out_file.write("    dir-up - direction\n")
    out_file.write("    player-01 - player\n")
    for (pos, t) in stage.pos.items():
        out_file.write("    %s - location\n" % pos)
    for i in range(len(stage.stone_pos)):
        out_file.write("    stone-%s - stone\n" % i)
    out_file.write("  )\n")

    # Floor state
    # 0 = wall
    # 1 = clear nongoal
    # 2 = clear goal
    # 3 = nonclear nongoal
    # 4 = nonclear goal
    out_file.write("  (:init\n")
    for (pos, t) in stage.pos.items():
        if t == 2 or t == 4:
            out_file.write("    (IS-GOAL %s)\n" % pos)
        else:
            out_file.write("    (IS-NONGOAL %s)\n" % pos)
        if t == 1 or t == 2:
            out_file.write("    (clear %s)\n" % pos)
    for move in stage.move_dir:
        out_file.write("    MOVE-DIR %s)\n" % move)

    # Object state
    out_file.write("    (at player-01 %s)\n" % stage.player_pos)
    for i in range(len(stage.stone_pos)):
        out_file.write("    (at stone-%s %s)\n" % (i, stage.stone_pos[i]))
    out_file.write("    (= (total-cost) 0)\n")
    out_file.write("  )\n")
    
    # Goal
    out_file.write("  (:goal (and\n")
    for i in range(len(stage.stone_pos)):
        out_file.write("    (at-goal stone-%s)\n" % i)
    out_file.write("  )\n")
    out_file.write("  (:metric minimize (total-cost))\n")
    out_file.write(")\n")

if __name__ == "__main__":
    in_file = sys.argv[1]
    out_file = sys.argv[2]
    name = sys.argv[3]

    with file_open(in_file, 'r') as file:
        stage = read_stage(file, name)

    with file_open(out_file, 'w') as file:
        write_pddl(file, stage)

    print("Stage %s written succesfully to %s" % (name, out_file))

