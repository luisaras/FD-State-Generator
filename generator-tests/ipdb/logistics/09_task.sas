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
Atom at(tru2, apt2)
Atom at(tru2, pos2)
end_variable
begin_variable
var1
-1
2
Atom at(tru1, apt1)
Atom at(tru1, pos1)
end_variable
begin_variable
var2
-1
2
Atom at(apn1, apt1)
Atom at(apn1, apt2)
end_variable
begin_variable
var3
-1
7
Atom at(obj23, apt1)
Atom at(obj23, apt2)
Atom at(obj23, pos1)
Atom at(obj23, pos2)
Atom in(obj23, apn1)
Atom in(obj23, tru1)
Atom in(obj23, tru2)
end_variable
begin_variable
var4
-1
7
Atom at(obj22, apt1)
Atom at(obj22, apt2)
Atom at(obj22, pos1)
Atom at(obj22, pos2)
Atom in(obj22, apn1)
Atom in(obj22, tru1)
Atom in(obj22, tru2)
end_variable
begin_variable
var5
-1
7
Atom at(obj21, apt1)
Atom at(obj21, apt2)
Atom at(obj21, pos1)
Atom at(obj21, pos2)
Atom in(obj21, apn1)
Atom in(obj21, tru1)
Atom in(obj21, tru2)
end_variable
begin_variable
var6
-1
7
Atom at(obj13, apt1)
Atom at(obj13, apt2)
Atom at(obj13, pos1)
Atom at(obj13, pos2)
Atom in(obj13, apn1)
Atom in(obj13, tru1)
Atom in(obj13, tru2)
end_variable
begin_variable
var7
-1
7
Atom at(obj12, apt1)
Atom at(obj12, apt2)
Atom at(obj12, pos1)
Atom at(obj12, pos2)
Atom in(obj12, apn1)
Atom in(obj12, tru1)
Atom in(obj12, tru2)
end_variable
begin_variable
var8
-1
7
Atom at(obj11, apt1)
Atom at(obj11, apt2)
Atom at(obj11, pos1)
Atom at(obj11, pos2)
Atom in(obj11, apn1)
Atom in(obj11, tru1)
Atom in(obj11, tru2)
end_variable
0
begin_state
0 0 1 3 3 2 3 2 2 
end_state
begin_goal
6
3 0
4 0
5 3
6 0
7 1
8 3
end_goal
78
begin_operator
drive-truck tru1 apt1 pos1 cit1
1
1 0
1
0
1 -1 1
1
end_operator
begin_operator
drive-truck tru1 pos1 apt1 cit1
1
1 1
1
0
1 -1 0
1
end_operator
begin_operator
drive-truck tru2 apt2 pos2 cit2
1
0 0
1
0
0 -1 1
1
end_operator
begin_operator
drive-truck tru2 pos2 apt2 cit2
1
0 1
1
0
0 -1 0
1
end_operator
begin_operator
fly-airplane apn1 apt1 apt2
1
2 0
1
0
2 -1 1
1
end_operator
begin_operator
fly-airplane apn1 apt2 apt1
1
2 1
1
0
2 -1 0
1
end_operator
begin_operator
load-airplane obj11 apn1 apt1
2
2 0
8 0
1
0
8 -1 4
1
end_operator
begin_operator
load-airplane obj11 apn1 apt2
2
2 1
8 1
1
0
8 -1 4
1
end_operator
begin_operator
load-airplane obj12 apn1 apt1
2
2 0
7 0
1
0
7 -1 4
1
end_operator
begin_operator
load-airplane obj12 apn1 apt2
2
2 1
7 1
1
0
7 -1 4
1
end_operator
begin_operator
load-airplane obj13 apn1 apt1
2
2 0
6 0
1
0
6 -1 4
1
end_operator
begin_operator
load-airplane obj13 apn1 apt2
2
2 1
6 1
1
0
6 -1 4
1
end_operator
begin_operator
load-airplane obj21 apn1 apt1
2
2 0
5 0
1
0
5 -1 4
1
end_operator
begin_operator
load-airplane obj21 apn1 apt2
2
2 1
5 1
1
0
5 -1 4
1
end_operator
begin_operator
load-airplane obj22 apn1 apt1
2
2 0
4 0
1
0
4 -1 4
1
end_operator
begin_operator
load-airplane obj22 apn1 apt2
2
2 1
4 1
1
0
4 -1 4
1
end_operator
begin_operator
load-airplane obj23 apn1 apt1
2
2 0
3 0
1
0
3 -1 4
1
end_operator
begin_operator
load-airplane obj23 apn1 apt2
2
2 1
3 1
1
0
3 -1 4
1
end_operator
begin_operator
load-truck obj11 tru1 apt1
2
1 0
8 0
1
0
8 -1 5
1
end_operator
begin_operator
load-truck obj11 tru1 pos1
2
1 1
8 2
1
0
8 -1 5
1
end_operator
begin_operator
load-truck obj11 tru2 apt2
2
0 0
8 1
1
0
8 -1 6
1
end_operator
begin_operator
load-truck obj11 tru2 pos2
2
0 1
8 3
1
0
8 -1 6
1
end_operator
begin_operator
load-truck obj12 tru1 apt1
2
1 0
7 0
1
0
7 -1 5
1
end_operator
begin_operator
load-truck obj12 tru1 pos1
2
1 1
7 2
1
0
7 -1 5
1
end_operator
begin_operator
load-truck obj12 tru2 apt2
2
0 0
7 1
1
0
7 -1 6
1
end_operator
begin_operator
load-truck obj12 tru2 pos2
2
0 1
7 3
1
0
7 -1 6
1
end_operator
begin_operator
load-truck obj13 tru1 apt1
2
1 0
6 0
1
0
6 -1 5
1
end_operator
begin_operator
load-truck obj13 tru1 pos1
2
1 1
6 2
1
0
6 -1 5
1
end_operator
begin_operator
load-truck obj13 tru2 apt2
2
0 0
6 1
1
0
6 -1 6
1
end_operator
begin_operator
load-truck obj13 tru2 pos2
2
0 1
6 3
1
0
6 -1 6
1
end_operator
begin_operator
load-truck obj21 tru1 apt1
2
1 0
5 0
1
0
5 -1 5
1
end_operator
begin_operator
load-truck obj21 tru1 pos1
2
1 1
5 2
1
0
5 -1 5
1
end_operator
begin_operator
load-truck obj21 tru2 apt2
2
0 0
5 1
1
0
5 -1 6
1
end_operator
begin_operator
load-truck obj21 tru2 pos2
2
0 1
5 3
1
0
5 -1 6
1
end_operator
begin_operator
load-truck obj22 tru1 apt1
2
1 0
4 0
1
0
4 -1 5
1
end_operator
begin_operator
load-truck obj22 tru1 pos1
2
1 1
4 2
1
0
4 -1 5
1
end_operator
begin_operator
load-truck obj22 tru2 apt2
2
0 0
4 1
1
0
4 -1 6
1
end_operator
begin_operator
load-truck obj22 tru2 pos2
2
0 1
4 3
1
0
4 -1 6
1
end_operator
begin_operator
load-truck obj23 tru1 apt1
2
1 0
3 0
1
0
3 -1 5
1
end_operator
begin_operator
load-truck obj23 tru1 pos1
2
1 1
3 2
1
0
3 -1 5
1
end_operator
begin_operator
load-truck obj23 tru2 apt2
2
0 0
3 1
1
0
3 -1 6
1
end_operator
begin_operator
load-truck obj23 tru2 pos2
2
0 1
3 3
1
0
3 -1 6
1
end_operator
begin_operator
unload-airplane obj11 apn1 apt1
2
2 0
8 4
1
0
8 -1 0
1
end_operator
begin_operator
unload-airplane obj11 apn1 apt2
2
2 1
8 4
1
0
8 -1 1
1
end_operator
begin_operator
unload-airplane obj12 apn1 apt1
2
2 0
7 4
1
0
7 -1 0
1
end_operator
begin_operator
unload-airplane obj12 apn1 apt2
2
2 1
7 4
1
0
7 -1 1
1
end_operator
begin_operator
unload-airplane obj13 apn1 apt1
2
2 0
6 4
1
0
6 -1 0
1
end_operator
begin_operator
unload-airplane obj13 apn1 apt2
2
2 1
6 4
1
0
6 -1 1
1
end_operator
begin_operator
unload-airplane obj21 apn1 apt1
2
2 0
5 4
1
0
5 -1 0
1
end_operator
begin_operator
unload-airplane obj21 apn1 apt2
2
2 1
5 4
1
0
5 -1 1
1
end_operator
begin_operator
unload-airplane obj22 apn1 apt1
2
2 0
4 4
1
0
4 -1 0
1
end_operator
begin_operator
unload-airplane obj22 apn1 apt2
2
2 1
4 4
1
0
4 -1 1
1
end_operator
begin_operator
unload-airplane obj23 apn1 apt1
2
2 0
3 4
1
0
3 -1 0
1
end_operator
begin_operator
unload-airplane obj23 apn1 apt2
2
2 1
3 4
1
0
3 -1 1
1
end_operator
begin_operator
unload-truck obj11 tru1 apt1
2
1 0
8 5
1
0
8 -1 0
1
end_operator
begin_operator
unload-truck obj11 tru1 pos1
2
1 1
8 5
1
0
8 -1 2
1
end_operator
begin_operator
unload-truck obj11 tru2 apt2
2
0 0
8 6
1
0
8 -1 1
1
end_operator
begin_operator
unload-truck obj11 tru2 pos2
2
0 1
8 6
1
0
8 -1 3
1
end_operator
begin_operator
unload-truck obj12 tru1 apt1
2
1 0
7 5
1
0
7 -1 0
1
end_operator
begin_operator
unload-truck obj12 tru1 pos1
2
1 1
7 5
1
0
7 -1 2
1
end_operator
begin_operator
unload-truck obj12 tru2 apt2
2
0 0
7 6
1
0
7 -1 1
1
end_operator
begin_operator
unload-truck obj12 tru2 pos2
2
0 1
7 6
1
0
7 -1 3
1
end_operator
begin_operator
unload-truck obj13 tru1 apt1
2
1 0
6 5
1
0
6 -1 0
1
end_operator
begin_operator
unload-truck obj13 tru1 pos1
2
1 1
6 5
1
0
6 -1 2
1
end_operator
begin_operator
unload-truck obj13 tru2 apt2
2
0 0
6 6
1
0
6 -1 1
1
end_operator
begin_operator
unload-truck obj13 tru2 pos2
2
0 1
6 6
1
0
6 -1 3
1
end_operator
begin_operator
unload-truck obj21 tru1 apt1
2
1 0
5 5
1
0
5 -1 0
1
end_operator
begin_operator
unload-truck obj21 tru1 pos1
2
1 1
5 5
1
0
5 -1 2
1
end_operator
begin_operator
unload-truck obj21 tru2 apt2
2
0 0
5 6
1
0
5 -1 1
1
end_operator
begin_operator
unload-truck obj21 tru2 pos2
2
0 1
5 6
1
0
5 -1 3
1
end_operator
begin_operator
unload-truck obj22 tru1 apt1
2
1 0
4 5
1
0
4 -1 0
1
end_operator
begin_operator
unload-truck obj22 tru1 pos1
2
1 1
4 5
1
0
4 -1 2
1
end_operator
begin_operator
unload-truck obj22 tru2 apt2
2
0 0
4 6
1
0
4 -1 1
1
end_operator
begin_operator
unload-truck obj22 tru2 pos2
2
0 1
4 6
1
0
4 -1 3
1
end_operator
begin_operator
unload-truck obj23 tru1 apt1
2
1 0
3 5
1
0
3 -1 0
1
end_operator
begin_operator
unload-truck obj23 tru1 pos1
2
1 1
3 5
1
0
3 -1 2
1
end_operator
begin_operator
unload-truck obj23 tru2 apt2
2
0 0
3 6
1
0
3 -1 1
1
end_operator
begin_operator
unload-truck obj23 tru2 pos2
2
0 1
3 6
1
0
3 -1 3
1
end_operator
0