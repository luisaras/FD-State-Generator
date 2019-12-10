begin_version
3
end_version
begin_metric
0
end_metric
4
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
3
Atom carry(ball1, left)
Atom carry(ball2, left)
Atom free(left)
end_variable
begin_variable
var2
-1
3
Atom at(ball1, rooma)
Atom at(ball1, roomb)
<none of those>
end_variable
begin_variable
var3
-1
3
Atom at(ball2, rooma)
Atom at(ball2, roomb)
<none of those>
end_variable
8
begin_mutex_group
2
1 0
2 0
end_mutex_group
begin_mutex_group
2
1 0
2 1
end_mutex_group
begin_mutex_group
2
1 1
3 0
end_mutex_group
begin_mutex_group
2
1 1
3 1
end_mutex_group
begin_mutex_group
2
2 0
1 0
end_mutex_group
begin_mutex_group
2
2 1
1 0
end_mutex_group
begin_mutex_group
2
3 0
1 1
end_mutex_group
begin_mutex_group
2
3 1
1 1
end_mutex_group
begin_state
1 2 0 0 
end_state
begin_goal
2
2 1
3 1
end_goal
10
begin_operator
drop ball1 rooma left
2
0 0
1 0
2
0
1 -1 2
0
2 -1 0
1
end_operator
begin_operator
drop ball1 roomb left
2
0 1
1 0
2
0
1 -1 2
0
2 -1 1
1
end_operator
begin_operator
drop ball2 rooma left
2
0 0
1 1
2
0
1 -1 2
0
3 -1 0
1
end_operator
begin_operator
drop ball2 roomb left
2
0 1
1 1
2
0
1 -1 2
0
3 -1 1
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
1 2
2 0
2
0
1 -1 0
0
2 -1 2
1
end_operator
begin_operator
pick ball1 roomb left
3
0 1
1 2
2 1
2
0
1 -1 0
0
2 -1 2
1
end_operator
begin_operator
pick ball2 rooma left
3
0 0
1 2
3 0
2
0
1 -1 1
0
3 -1 2
1
end_operator
begin_operator
pick ball2 roomb left
3
0 1
1 2
3 1
2
0
1 -1 1
0
3 -1 2
1
end_operator
0
