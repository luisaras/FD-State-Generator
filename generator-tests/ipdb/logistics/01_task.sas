begin_version
3
end_version
begin_metric
0
end_metric
7
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
Atom at(obj21, apt1)
Atom at(obj21, apt2)
Atom at(obj21, pos1)
Atom at(obj21, pos2)
Atom in(obj21, apn1)
Atom in(obj21, tru1)
Atom in(obj21, tru2)
end_variable
begin_variable
var5
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
var6
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
0 1 0 3 3 3 3 
end_state
begin_goal
4
3 2
4 2
5 0
6 0
end_goal
54
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
6 0
1
0
6 -1 4
1
end_operator
begin_operator
load-airplane obj11 apn1 apt2
2
2 1
6 1
1
0
6 -1 4
1
end_operator
begin_operator
load-airplane obj13 apn1 apt1
2
2 0
5 0
1
0
5 -1 4
1
end_operator
begin_operator
load-airplane obj13 apn1 apt2
2
2 1
5 1
1
0
5 -1 4
1
end_operator
begin_operator
load-airplane obj21 apn1 apt1
2
2 0
4 0
1
0
4 -1 4
1
end_operator
begin_operator
load-airplane obj21 apn1 apt2
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
6 0
1
0
6 -1 5
1
end_operator
begin_operator
load-truck obj11 tru1 pos1
2
1 1
6 2
1
0
6 -1 5
1
end_operator
begin_operator
load-truck obj11 tru2 apt2
2
0 0
6 1
1
0
6 -1 6
1
end_operator
begin_operator
load-truck obj11 tru2 pos2
2
0 1
6 3
1
0
6 -1 6
1
end_operator
begin_operator
load-truck obj13 tru1 apt1
2
1 0
5 0
1
0
5 -1 5
1
end_operator
begin_operator
load-truck obj13 tru1 pos1
2
1 1
5 2
1
0
5 -1 5
1
end_operator
begin_operator
load-truck obj13 tru2 apt2
2
0 0
5 1
1
0
5 -1 6
1
end_operator
begin_operator
load-truck obj13 tru2 pos2
2
0 1
5 3
1
0
5 -1 6
1
end_operator
begin_operator
load-truck obj21 tru1 apt1
2
1 0
4 0
1
0
4 -1 5
1
end_operator
begin_operator
load-truck obj21 tru1 pos1
2
1 1
4 2
1
0
4 -1 5
1
end_operator
begin_operator
load-truck obj21 tru2 apt2
2
0 0
4 1
1
0
4 -1 6
1
end_operator
begin_operator
load-truck obj21 tru2 pos2
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
6 4
1
0
6 -1 0
1
end_operator
begin_operator
unload-airplane obj11 apn1 apt2
2
2 1
6 4
1
0
6 -1 1
1
end_operator
begin_operator
unload-airplane obj13 apn1 apt1
2
2 0
5 4
1
0
5 -1 0
1
end_operator
begin_operator
unload-airplane obj13 apn1 apt2
2
2 1
5 4
1
0
5 -1 1
1
end_operator
begin_operator
unload-airplane obj21 apn1 apt1
2
2 0
4 4
1
0
4 -1 0
1
end_operator
begin_operator
unload-airplane obj21 apn1 apt2
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
6 5
1
0
6 -1 0
1
end_operator
begin_operator
unload-truck obj11 tru1 pos1
2
1 1
6 5
1
0
6 -1 2
1
end_operator
begin_operator
unload-truck obj11 tru2 apt2
2
0 0
6 6
1
0
6 -1 1
1
end_operator
begin_operator
unload-truck obj11 tru2 pos2
2
0 1
6 6
1
0
6 -1 3
1
end_operator
begin_operator
unload-truck obj13 tru1 apt1
2
1 0
5 5
1
0
5 -1 0
1
end_operator
begin_operator
unload-truck obj13 tru1 pos1
2
1 1
5 5
1
0
5 -1 2
1
end_operator
begin_operator
unload-truck obj13 tru2 apt2
2
0 0
5 6
1
0
5 -1 1
1
end_operator
begin_operator
unload-truck obj13 tru2 pos2
2
0 1
5 6
1
0
5 -1 3
1
end_operator
begin_operator
unload-truck obj21 tru1 apt1
2
1 0
4 5
1
0
4 -1 0
1
end_operator
begin_operator
unload-truck obj21 tru1 pos1
2
1 1
4 5
1
0
4 -1 2
1
end_operator
begin_operator
unload-truck obj21 tru2 apt2
2
0 0
4 6
1
0
4 -1 1
1
end_operator
begin_operator
unload-truck obj21 tru2 pos2
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
