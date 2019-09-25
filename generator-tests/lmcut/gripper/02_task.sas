begin_version
3
end_version
begin_metric
0
end_metric
9
begin_variable
var0
-1
2
Atom at-robby(rooma)
Atom at-robby(roomb)
end_variable
begin_variable
var1
-1
7
Atom carry(ball1, left)
Atom carry(ball2, left)
Atom carry(ball3, left)
Atom carry(ball4, left)
Atom carry(ball5, left)
Atom carry(ball6, left)
Atom free(left)
end_variable
begin_variable
var2
-1
7
Atom carry(ball1, right)
Atom carry(ball2, right)
Atom carry(ball3, right)
Atom carry(ball4, right)
Atom carry(ball5, right)
Atom carry(ball6, right)
Atom free(right)
end_variable
begin_variable
var3
-1
3
Atom at(ball1, rooma)
Atom at(ball1, roomb)
<none of those>
end_variable
begin_variable
var4
-1
3
Atom at(ball2, rooma)
Atom at(ball2, roomb)
<none of those>
end_variable
begin_variable
var5
-1
3
Atom at(ball3, rooma)
Atom at(ball3, roomb)
<none of those>
end_variable
begin_variable
var6
-1
3
Atom at(ball4, rooma)
Atom at(ball4, roomb)
<none of those>
end_variable
begin_variable
var7
-1
3
Atom at(ball5, rooma)
Atom at(ball5, roomb)
<none of those>
end_variable
begin_variable
var8
-1
3
Atom at(ball6, rooma)
Atom at(ball6, roomb)
<none of those>
end_variable
60
begin_mutex_group
2
1 0
2 0
end_mutex_group
begin_mutex_group
2
1 0
3 0
end_mutex_group
begin_mutex_group
2
1 0
3 1
end_mutex_group
begin_mutex_group
2
1 1
2 1
end_mutex_group
begin_mutex_group
2
1 1
4 0
end_mutex_group
begin_mutex_group
2
1 1
4 1
end_mutex_group
begin_mutex_group
2
1 2
2 2
end_mutex_group
begin_mutex_group
2
1 2
5 0
end_mutex_group
begin_mutex_group
2
1 2
5 1
end_mutex_group
begin_mutex_group
2
1 3
2 3
end_mutex_group
begin_mutex_group
2
1 3
6 0
end_mutex_group
begin_mutex_group
2
1 3
6 1
end_mutex_group
begin_mutex_group
2
1 4
2 4
end_mutex_group
begin_mutex_group
2
1 4
7 0
end_mutex_group
begin_mutex_group
2
1 4
7 1
end_mutex_group
begin_mutex_group
2
1 5
2 5
end_mutex_group
begin_mutex_group
2
1 5
8 0
end_mutex_group
begin_mutex_group
2
1 5
8 1
end_mutex_group
begin_mutex_group
2
2 0
1 0
end_mutex_group
begin_mutex_group
2
2 0
3 0
end_mutex_group
begin_mutex_group
2
2 0
3 1
end_mutex_group
begin_mutex_group
2
2 1
1 1
end_mutex_group
begin_mutex_group
2
2 1
4 0
end_mutex_group
begin_mutex_group
2
2 1
4 1
end_mutex_group
begin_mutex_group
2
2 2
1 2
end_mutex_group
begin_mutex_group
2
2 2
5 0
end_mutex_group
begin_mutex_group
2
2 2
5 1
end_mutex_group
begin_mutex_group
2
2 3
1 3
end_mutex_group
begin_mutex_group
2
2 3
6 0
end_mutex_group
begin_mutex_group
2
2 3
6 1
end_mutex_group
begin_mutex_group
2
2 4
1 4
end_mutex_group
begin_mutex_group
2
2 4
7 0
end_mutex_group
begin_mutex_group
2
2 4
7 1
end_mutex_group
begin_mutex_group
2
2 5
1 5
end_mutex_group
begin_mutex_group
2
2 5
8 0
end_mutex_group
begin_mutex_group
2
2 5
8 1
end_mutex_group
begin_mutex_group
2
3 0
1 0
end_mutex_group
begin_mutex_group
2
3 0
2 0
end_mutex_group
begin_mutex_group
2
3 1
1 0
end_mutex_group
begin_mutex_group
2
3 1
2 0
end_mutex_group
begin_mutex_group
2
4 0
1 1
end_mutex_group
begin_mutex_group
2
4 0
2 1
end_mutex_group
begin_mutex_group
2
4 1
1 1
end_mutex_group
begin_mutex_group
2
4 1
2 1
end_mutex_group
begin_mutex_group
2
5 0
1 2
end_mutex_group
begin_mutex_group
2
5 0
2 2
end_mutex_group
begin_mutex_group
2
5 1
1 2
end_mutex_group
begin_mutex_group
2
5 1
2 2
end_mutex_group
begin_mutex_group
2
6 0
1 3
end_mutex_group
begin_mutex_group
2
6 0
2 3
end_mutex_group
begin_mutex_group
2
6 1
1 3
end_mutex_group
begin_mutex_group
2
6 1
2 3
end_mutex_group
begin_mutex_group
2
7 0
1 4
end_mutex_group
begin_mutex_group
2
7 0
2 4
end_mutex_group
begin_mutex_group
2
7 1
1 4
end_mutex_group
begin_mutex_group
2
7 1
2 4
end_mutex_group
begin_mutex_group
2
8 0
1 5
end_mutex_group
begin_mutex_group
2
8 0
2 5
end_mutex_group
begin_mutex_group
2
8 1
1 5
end_mutex_group
begin_mutex_group
2
8 1
2 5
end_mutex_group
begin_state
0 6 6 0 0 0 0 0 0 
end_state
begin_goal
6
3 1
4 1
5 1
6 1
7 1
8 1
end_goal
50
begin_operator
drop ball1 rooma left
2
0 0
1 0
2
0
1 -1 6
0
3 -1 0
1
end_operator
begin_operator
drop ball1 rooma right
2
0 0
2 0
2
0
2 -1 6
0
3 -1 0
1
end_operator
begin_operator
drop ball1 roomb left
2
0 1
1 0
2
0
1 -1 6
0
3 -1 1
1
end_operator
begin_operator
drop ball1 roomb right
2
0 1
2 0
2
0
2 -1 6
0
3 -1 1
1
end_operator
begin_operator
drop ball2 rooma left
2
0 0
1 1
2
0
1 -1 6
0
4 -1 0
1
end_operator
begin_operator
drop ball2 rooma right
2
0 0
2 1
2
0
2 -1 6
0
4 -1 0
1
end_operator
begin_operator
drop ball2 roomb left
2
0 1
1 1
2
0
1 -1 6
0
4 -1 1
1
end_operator
begin_operator
drop ball2 roomb right
2
0 1
2 1
2
0
2 -1 6
0
4 -1 1
1
end_operator
begin_operator
drop ball3 rooma left
2
0 0
1 2
2
0
1 -1 6
0
5 -1 0
1
end_operator
begin_operator
drop ball3 rooma right
2
0 0
2 2
2
0
2 -1 6
0
5 -1 0
1
end_operator
begin_operator
drop ball3 roomb left
2
0 1
1 2
2
0
1 -1 6
0
5 -1 1
1
end_operator
begin_operator
drop ball3 roomb right
2
0 1
2 2
2
0
2 -1 6
0
5 -1 1
1
end_operator
begin_operator
drop ball4 rooma left
2
0 0
1 3
2
0
1 -1 6
0
6 -1 0
1
end_operator
begin_operator
drop ball4 rooma right
2
0 0
2 3
2
0
2 -1 6
0
6 -1 0
1
end_operator
begin_operator
drop ball4 roomb left
2
0 1
1 3
2
0
1 -1 6
0
6 -1 1
1
end_operator
begin_operator
drop ball4 roomb right
2
0 1
2 3
2
0
2 -1 6
0
6 -1 1
1
end_operator
begin_operator
drop ball5 rooma left
2
0 0
1 4
2
0
1 -1 6
0
7 -1 0
1
end_operator
begin_operator
drop ball5 rooma right
2
0 0
2 4
2
0
2 -1 6
0
7 -1 0
1
end_operator
begin_operator
drop ball5 roomb left
2
0 1
1 4
2
0
1 -1 6
0
7 -1 1
1
end_operator
begin_operator
drop ball5 roomb right
2
0 1
2 4
2
0
2 -1 6
0
7 -1 1
1
end_operator
begin_operator
drop ball6 rooma left
2
0 0
1 5
2
0
1 -1 6
0
8 -1 0
1
end_operator
begin_operator
drop ball6 rooma right
2
0 0
2 5
2
0
2 -1 6
0
8 -1 0
1
end_operator
begin_operator
drop ball6 roomb left
2
0 1
1 5
2
0
1 -1 6
0
8 -1 1
1
end_operator
begin_operator
drop ball6 roomb right
2
0 1
2 5
2
0
2 -1 6
0
8 -1 1
1
end_operator
begin_operator
move rooma roomb
1
0 0
1
0
0 -1 1
1
end_operator
begin_operator
move roomb rooma
1
0 1
1
0
0 -1 0
1
end_operator
begin_operator
pick ball1 rooma left
3
0 0
1 6
3 0
2
0
1 -1 0
0
3 -1 2
1
end_operator
begin_operator
pick ball1 rooma right
3
0 0
2 6
3 0
2
0
2 -1 0
0
3 -1 2
1
end_operator
begin_operator
pick ball1 roomb left
3
0 1
1 6
3 1
2
0
1 -1 0
0
3 -1 2
1
end_operator
begin_operator
pick ball1 roomb right
3
0 1
2 6
3 1
2
0
2 -1 0
0
3 -1 2
1
end_operator
begin_operator
pick ball2 rooma left
3
0 0
1 6
4 0
2
0
1 -1 1
0
4 -1 2
1
end_operator
begin_operator
pick ball2 rooma right
3
0 0
2 6
4 0
2
0
2 -1 1
0
4 -1 2
1
end_operator
begin_operator
pick ball2 roomb left
3
0 1
1 6
4 1
2
0
1 -1 1
0
4 -1 2
1
end_operator
begin_operator
pick ball2 roomb right
3
0 1
2 6
4 1
2
0
2 -1 1
0
4 -1 2
1
end_operator
begin_operator
pick ball3 rooma left
3
0 0
1 6
5 0
2
0
1 -1 2
0
5 -1 2
1
end_operator
begin_operator
pick ball3 rooma right
3
0 0
2 6
5 0
2
0
2 -1 2
0
5 -1 2
1
end_operator
begin_operator
pick ball3 roomb left
3
0 1
1 6
5 1
2
0
1 -1 2
0
5 -1 2
1
end_operator
begin_operator
pick ball3 roomb right
3
0 1
2 6
5 1
2
0
2 -1 2
0
5 -1 2
1
end_operator
begin_operator
pick ball4 rooma left
3
0 0
1 6
6 0
2
0
1 -1 3
0
6 -1 2
1
end_operator
begin_operator
pick ball4 rooma right
3
0 0
2 6
6 0
2
0
2 -1 3
0
6 -1 2
1
end_operator
begin_operator
pick ball4 roomb left
3
0 1
1 6
6 1
2
0
1 -1 3
0
6 -1 2
1
end_operator
begin_operator
pick ball4 roomb right
3
0 1
2 6
6 1
2
0
2 -1 3
0
6 -1 2
1
end_operator
begin_operator
pick ball5 rooma left
3
0 0
1 6
7 0
2
0
1 -1 4
0
7 -1 2
1
end_operator
begin_operator
pick ball5 rooma right
3
0 0
2 6
7 0
2
0
2 -1 4
0
7 -1 2
1
end_operator
begin_operator
pick ball5 roomb left
3
0 1
1 6
7 1
2
0
1 -1 4
0
7 -1 2
1
end_operator
begin_operator
pick ball5 roomb right
3
0 1
2 6
7 1
2
0
2 -1 4
0
7 -1 2
1
end_operator
begin_operator
pick ball6 rooma left
3
0 0
1 6
8 0
2
0
1 -1 5
0
8 -1 2
1
end_operator
begin_operator
pick ball6 rooma right
3
0 0
2 6
8 0
2
0
2 -1 5
0
8 -1 2
1
end_operator
begin_operator
pick ball6 roomb left
3
0 1
1 6
8 1
2
0
1 -1 5
0
8 -1 2
1
end_operator
begin_operator
pick ball6 roomb right
3
0 1
2 6
8 1
2
0
2 -1 5
0
8 -1 2
1
end_operator
0
