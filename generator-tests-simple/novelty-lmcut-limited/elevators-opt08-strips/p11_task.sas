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
7
Atom lift-at(slow1-0, n10)
Atom lift-at(slow1-0, n11)
Atom lift-at(slow1-0, n12)
Atom lift-at(slow1-0, n6)
Atom lift-at(slow1-0, n7)
Atom lift-at(slow1-0, n8)
Atom lift-at(slow1-0, n9)
end_variable
begin_variable
var1
-1
7
Atom lift-at(slow0-0, n0)
Atom lift-at(slow0-0, n1)
Atom lift-at(slow0-0, n2)
Atom lift-at(slow0-0, n3)
Atom lift-at(slow0-0, n4)
Atom lift-at(slow0-0, n5)
Atom lift-at(slow0-0, n6)
end_variable
begin_variable
var2
-1
5
Atom lift-at(fast0, n0)
Atom lift-at(fast0, n12)
Atom lift-at(fast0, n3)
Atom lift-at(fast0, n6)
Atom lift-at(fast0, n9)
end_variable
begin_variable
var3
-1
3
Atom passengers(slow0-0, n0)
Atom passengers(slow0-0, n1)
Atom passengers(slow0-0, n2)
end_variable
begin_variable
var4
-1
3
Atom passengers(slow1-0, n0)
Atom passengers(slow1-0, n1)
Atom passengers(slow1-0, n2)
end_variable
begin_variable
var5
-1
4
Atom passengers(fast0, n0)
Atom passengers(fast0, n1)
Atom passengers(fast0, n2)
Atom passengers(fast0, n3)
end_variable
begin_variable
var6
-1
16
Atom boarded(p0, fast0)
Atom boarded(p0, slow0-0)
Atom boarded(p0, slow1-0)
Atom passenger-at(p0, n0)
Atom passenger-at(p0, n1)
Atom passenger-at(p0, n10)
Atom passenger-at(p0, n11)
Atom passenger-at(p0, n12)
Atom passenger-at(p0, n2)
Atom passenger-at(p0, n3)
Atom passenger-at(p0, n4)
Atom passenger-at(p0, n5)
Atom passenger-at(p0, n6)
Atom passenger-at(p0, n7)
Atom passenger-at(p0, n8)
Atom passenger-at(p0, n9)
end_variable
begin_variable
var7
-1
16
Atom boarded(p1, fast0)
Atom boarded(p1, slow0-0)
Atom boarded(p1, slow1-0)
Atom passenger-at(p1, n0)
Atom passenger-at(p1, n1)
Atom passenger-at(p1, n10)
Atom passenger-at(p1, n11)
Atom passenger-at(p1, n12)
Atom passenger-at(p1, n2)
Atom passenger-at(p1, n3)
Atom passenger-at(p1, n4)
Atom passenger-at(p1, n5)
Atom passenger-at(p1, n6)
Atom passenger-at(p1, n7)
Atom passenger-at(p1, n8)
Atom passenger-at(p1, n9)
end_variable
begin_variable
var8
-1
16
Atom boarded(p2, fast0)
Atom boarded(p2, slow0-0)
Atom boarded(p2, slow1-0)
Atom passenger-at(p2, n0)
Atom passenger-at(p2, n1)
Atom passenger-at(p2, n10)
Atom passenger-at(p2, n11)
Atom passenger-at(p2, n12)
Atom passenger-at(p2, n2)
Atom passenger-at(p2, n3)
Atom passenger-at(p2, n4)
Atom passenger-at(p2, n5)
Atom passenger-at(p2, n6)
Atom passenger-at(p2, n7)
Atom passenger-at(p2, n8)
Atom passenger-at(p2, n9)
end_variable
0
begin_state
2 0 1 0 0 0 5 14 8 
end_state
begin_goal
3
6 9
7 6
8 13
end_goal
362
begin_operator
board p0 fast0 n0 n0 n1
3
2 0
5 0
6 3
2
0
5 -1 1
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n0 n1 n2
3
2 0
5 1
6 3
2
0
5 -1 2
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n0 n2 n3
3
2 0
5 2
6 3
2
0
5 -1 3
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n12 n0 n1
3
2 1
5 0
6 7
2
0
5 -1 1
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n12 n1 n2
3
2 1
5 1
6 7
2
0
5 -1 2
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n12 n2 n3
3
2 1
5 2
6 7
2
0
5 -1 3
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n3 n0 n1
3
2 2
5 0
6 9
2
0
5 -1 1
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n3 n1 n2
3
2 2
5 1
6 9
2
0
5 -1 2
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n3 n2 n3
3
2 2
5 2
6 9
2
0
5 -1 3
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n6 n0 n1
3
2 3
5 0
6 12
2
0
5 -1 1
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n6 n1 n2
3
2 3
5 1
6 12
2
0
5 -1 2
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n6 n2 n3
3
2 3
5 2
6 12
2
0
5 -1 3
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n9 n0 n1
3
2 4
5 0
6 15
2
0
5 -1 1
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n9 n1 n2
3
2 4
5 1
6 15
2
0
5 -1 2
0
6 -1 0
0
end_operator
begin_operator
board p0 fast0 n9 n2 n3
3
2 4
5 2
6 15
2
0
5 -1 3
0
6 -1 0
0
end_operator
begin_operator
board p0 slow0-0 n0 n0 n1
3
1 0
3 0
6 3
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n0 n1 n2
3
1 0
3 1
6 3
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n1 n0 n1
3
1 1
3 0
6 4
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n1 n1 n2
3
1 1
3 1
6 4
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n2 n0 n1
3
1 2
3 0
6 8
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n2 n1 n2
3
1 2
3 1
6 8
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n3 n0 n1
3
1 3
3 0
6 9
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n3 n1 n2
3
1 3
3 1
6 9
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n4 n0 n1
3
1 4
3 0
6 10
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n4 n1 n2
3
1 4
3 1
6 10
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n5 n0 n1
3
1 5
3 0
6 11
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n5 n1 n2
3
1 5
3 1
6 11
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n6 n0 n1
3
1 6
3 0
6 12
2
0
3 -1 1
0
6 -1 1
0
end_operator
begin_operator
board p0 slow0-0 n6 n1 n2
3
1 6
3 1
6 12
2
0
3 -1 2
0
6 -1 1
0
end_operator
begin_operator
board p0 slow1-0 n10 n0 n1
3
0 0
4 0
6 5
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n10 n1 n2
3
0 0
4 1
6 5
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n11 n0 n1
3
0 1
4 0
6 6
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n11 n1 n2
3
0 1
4 1
6 6
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n12 n0 n1
3
0 2
4 0
6 7
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n12 n1 n2
3
0 2
4 1
6 7
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n6 n0 n1
3
0 3
4 0
6 12
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n6 n1 n2
3
0 3
4 1
6 12
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n7 n0 n1
3
0 4
4 0
6 13
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n7 n1 n2
3
0 4
4 1
6 13
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n8 n0 n1
3
0 5
4 0
6 14
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n8 n1 n2
3
0 5
4 1
6 14
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n9 n0 n1
3
0 6
4 0
6 15
2
0
4 -1 1
0
6 -1 2
0
end_operator
begin_operator
board p0 slow1-0 n9 n1 n2
3
0 6
4 1
6 15
2
0
4 -1 2
0
6 -1 2
0
end_operator
begin_operator
board p1 fast0 n0 n0 n1
3
2 0
5 0
7 3
2
0
5 -1 1
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n0 n1 n2
3
2 0
5 1
7 3
2
0
5 -1 2
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n0 n2 n3
3
2 0
5 2
7 3
2
0
5 -1 3
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n12 n0 n1
3
2 1
5 0
7 7
2
0
5 -1 1
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n12 n1 n2
3
2 1
5 1
7 7
2
0
5 -1 2
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n12 n2 n3
3
2 1
5 2
7 7
2
0
5 -1 3
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n3 n0 n1
3
2 2
5 0
7 9
2
0
5 -1 1
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n3 n1 n2
3
2 2
5 1
7 9
2
0
5 -1 2
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n3 n2 n3
3
2 2
5 2
7 9
2
0
5 -1 3
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n6 n0 n1
3
2 3
5 0
7 12
2
0
5 -1 1
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n6 n1 n2
3
2 3
5 1
7 12
2
0
5 -1 2
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n6 n2 n3
3
2 3
5 2
7 12
2
0
5 -1 3
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n9 n0 n1
3
2 4
5 0
7 15
2
0
5 -1 1
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n9 n1 n2
3
2 4
5 1
7 15
2
0
5 -1 2
0
7 -1 0
0
end_operator
begin_operator
board p1 fast0 n9 n2 n3
3
2 4
5 2
7 15
2
0
5 -1 3
0
7 -1 0
0
end_operator
begin_operator
board p1 slow0-0 n0 n0 n1
3
1 0
3 0
7 3
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n0 n1 n2
3
1 0
3 1
7 3
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n1 n0 n1
3
1 1
3 0
7 4
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n1 n1 n2
3
1 1
3 1
7 4
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n2 n0 n1
3
1 2
3 0
7 8
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n2 n1 n2
3
1 2
3 1
7 8
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n3 n0 n1
3
1 3
3 0
7 9
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n3 n1 n2
3
1 3
3 1
7 9
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n4 n0 n1
3
1 4
3 0
7 10
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n4 n1 n2
3
1 4
3 1
7 10
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n5 n0 n1
3
1 5
3 0
7 11
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n5 n1 n2
3
1 5
3 1
7 11
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n6 n0 n1
3
1 6
3 0
7 12
2
0
3 -1 1
0
7 -1 1
0
end_operator
begin_operator
board p1 slow0-0 n6 n1 n2
3
1 6
3 1
7 12
2
0
3 -1 2
0
7 -1 1
0
end_operator
begin_operator
board p1 slow1-0 n10 n0 n1
3
0 0
4 0
7 5
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n10 n1 n2
3
0 0
4 1
7 5
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n11 n0 n1
3
0 1
4 0
7 6
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n11 n1 n2
3
0 1
4 1
7 6
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n12 n0 n1
3
0 2
4 0
7 7
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n12 n1 n2
3
0 2
4 1
7 7
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n6 n0 n1
3
0 3
4 0
7 12
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n6 n1 n2
3
0 3
4 1
7 12
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n7 n0 n1
3
0 4
4 0
7 13
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n7 n1 n2
3
0 4
4 1
7 13
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n8 n0 n1
3
0 5
4 0
7 14
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n8 n1 n2
3
0 5
4 1
7 14
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n9 n0 n1
3
0 6
4 0
7 15
2
0
4 -1 1
0
7 -1 2
0
end_operator
begin_operator
board p1 slow1-0 n9 n1 n2
3
0 6
4 1
7 15
2
0
4 -1 2
0
7 -1 2
0
end_operator
begin_operator
board p2 fast0 n0 n0 n1
3
2 0
5 0
8 3
2
0
5 -1 1
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n0 n1 n2
3
2 0
5 1
8 3
2
0
5 -1 2
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n0 n2 n3
3
2 0
5 2
8 3
2
0
5 -1 3
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n12 n0 n1
3
2 1
5 0
8 7
2
0
5 -1 1
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n12 n1 n2
3
2 1
5 1
8 7
2
0
5 -1 2
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n12 n2 n3
3
2 1
5 2
8 7
2
0
5 -1 3
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n3 n0 n1
3
2 2
5 0
8 9
2
0
5 -1 1
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n3 n1 n2
3
2 2
5 1
8 9
2
0
5 -1 2
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n3 n2 n3
3
2 2
5 2
8 9
2
0
5 -1 3
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n6 n0 n1
3
2 3
5 0
8 12
2
0
5 -1 1
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n6 n1 n2
3
2 3
5 1
8 12
2
0
5 -1 2
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n6 n2 n3
3
2 3
5 2
8 12
2
0
5 -1 3
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n9 n0 n1
3
2 4
5 0
8 15
2
0
5 -1 1
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n9 n1 n2
3
2 4
5 1
8 15
2
0
5 -1 2
0
8 -1 0
0
end_operator
begin_operator
board p2 fast0 n9 n2 n3
3
2 4
5 2
8 15
2
0
5 -1 3
0
8 -1 0
0
end_operator
begin_operator
board p2 slow0-0 n0 n0 n1
3
1 0
3 0
8 3
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n0 n1 n2
3
1 0
3 1
8 3
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n1 n0 n1
3
1 1
3 0
8 4
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n1 n1 n2
3
1 1
3 1
8 4
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n2 n0 n1
3
1 2
3 0
8 8
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n2 n1 n2
3
1 2
3 1
8 8
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n3 n0 n1
3
1 3
3 0
8 9
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n3 n1 n2
3
1 3
3 1
8 9
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n4 n0 n1
3
1 4
3 0
8 10
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n4 n1 n2
3
1 4
3 1
8 10
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n5 n0 n1
3
1 5
3 0
8 11
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n5 n1 n2
3
1 5
3 1
8 11
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n6 n0 n1
3
1 6
3 0
8 12
2
0
3 -1 1
0
8 -1 1
0
end_operator
begin_operator
board p2 slow0-0 n6 n1 n2
3
1 6
3 1
8 12
2
0
3 -1 2
0
8 -1 1
0
end_operator
begin_operator
board p2 slow1-0 n10 n0 n1
3
0 0
4 0
8 5
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n10 n1 n2
3
0 0
4 1
8 5
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n11 n0 n1
3
0 1
4 0
8 6
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n11 n1 n2
3
0 1
4 1
8 6
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n12 n0 n1
3
0 2
4 0
8 7
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n12 n1 n2
3
0 2
4 1
8 7
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n6 n0 n1
3
0 3
4 0
8 12
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n6 n1 n2
3
0 3
4 1
8 12
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n7 n0 n1
3
0 4
4 0
8 13
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n7 n1 n2
3
0 4
4 1
8 13
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n8 n0 n1
3
0 5
4 0
8 14
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n8 n1 n2
3
0 5
4 1
8 14
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n9 n0 n1
3
0 6
4 0
8 15
2
0
4 -1 1
0
8 -1 2
0
end_operator
begin_operator
board p2 slow1-0 n9 n1 n2
3
0 6
4 1
8 15
2
0
4 -1 2
0
8 -1 2
0
end_operator
begin_operator
leave p0 fast0 n0 n1 n0
3
2 0
5 1
6 0
2
0
5 -1 0
0
6 -1 3
0
end_operator
begin_operator
leave p0 fast0 n0 n2 n1
3
2 0
5 2
6 0
2
0
5 -1 1
0
6 -1 3
0
end_operator
begin_operator
leave p0 fast0 n0 n3 n2
3
2 0
5 3
6 0
2
0
5 -1 2
0
6 -1 3
0
end_operator
begin_operator
leave p0 fast0 n12 n1 n0
3
2 1
5 1
6 0
2
0
5 -1 0
0
6 -1 7
0
end_operator
begin_operator
leave p0 fast0 n12 n2 n1
3
2 1
5 2
6 0
2
0
5 -1 1
0
6 -1 7
0
end_operator
begin_operator
leave p0 fast0 n12 n3 n2
3
2 1
5 3
6 0
2
0
5 -1 2
0
6 -1 7
0
end_operator
begin_operator
leave p0 fast0 n3 n1 n0
3
2 2
5 1
6 0
2
0
5 -1 0
0
6 -1 9
0
end_operator
begin_operator
leave p0 fast0 n3 n2 n1
3
2 2
5 2
6 0
2
0
5 -1 1
0
6 -1 9
0
end_operator
begin_operator
leave p0 fast0 n3 n3 n2
3
2 2
5 3
6 0
2
0
5 -1 2
0
6 -1 9
0
end_operator
begin_operator
leave p0 fast0 n6 n1 n0
3
2 3
5 1
6 0
2
0
5 -1 0
0
6 -1 12
0
end_operator
begin_operator
leave p0 fast0 n6 n2 n1
3
2 3
5 2
6 0
2
0
5 -1 1
0
6 -1 12
0
end_operator
begin_operator
leave p0 fast0 n6 n3 n2
3
2 3
5 3
6 0
2
0
5 -1 2
0
6 -1 12
0
end_operator
begin_operator
leave p0 fast0 n9 n1 n0
3
2 4
5 1
6 0
2
0
5 -1 0
0
6 -1 15
0
end_operator
begin_operator
leave p0 fast0 n9 n2 n1
3
2 4
5 2
6 0
2
0
5 -1 1
0
6 -1 15
0
end_operator
begin_operator
leave p0 fast0 n9 n3 n2
3
2 4
5 3
6 0
2
0
5 -1 2
0
6 -1 15
0
end_operator
begin_operator
leave p0 slow0-0 n0 n1 n0
3
1 0
3 1
6 1
2
0
3 -1 0
0
6 -1 3
0
end_operator
begin_operator
leave p0 slow0-0 n0 n2 n1
3
1 0
3 2
6 1
2
0
3 -1 1
0
6 -1 3
0
end_operator
begin_operator
leave p0 slow0-0 n1 n1 n0
3
1 1
3 1
6 1
2
0
3 -1 0
0
6 -1 4
0
end_operator
begin_operator
leave p0 slow0-0 n1 n2 n1
3
1 1
3 2
6 1
2
0
3 -1 1
0
6 -1 4
0
end_operator
begin_operator
leave p0 slow0-0 n2 n1 n0
3
1 2
3 1
6 1
2
0
3 -1 0
0
6 -1 8
0
end_operator
begin_operator
leave p0 slow0-0 n2 n2 n1
3
1 2
3 2
6 1
2
0
3 -1 1
0
6 -1 8
0
end_operator
begin_operator
leave p0 slow0-0 n3 n1 n0
3
1 3
3 1
6 1
2
0
3 -1 0
0
6 -1 9
0
end_operator
begin_operator
leave p0 slow0-0 n3 n2 n1
3
1 3
3 2
6 1
2
0
3 -1 1
0
6 -1 9
0
end_operator
begin_operator
leave p0 slow0-0 n4 n1 n0
3
1 4
3 1
6 1
2
0
3 -1 0
0
6 -1 10
0
end_operator
begin_operator
leave p0 slow0-0 n4 n2 n1
3
1 4
3 2
6 1
2
0
3 -1 1
0
6 -1 10
0
end_operator
begin_operator
leave p0 slow0-0 n5 n1 n0
3
1 5
3 1
6 1
2
0
3 -1 0
0
6 -1 11
0
end_operator
begin_operator
leave p0 slow0-0 n5 n2 n1
3
1 5
3 2
6 1
2
0
3 -1 1
0
6 -1 11
0
end_operator
begin_operator
leave p0 slow0-0 n6 n1 n0
3
1 6
3 1
6 1
2
0
3 -1 0
0
6 -1 12
0
end_operator
begin_operator
leave p0 slow0-0 n6 n2 n1
3
1 6
3 2
6 1
2
0
3 -1 1
0
6 -1 12
0
end_operator
begin_operator
leave p0 slow1-0 n10 n1 n0
3
0 0
4 1
6 2
2
0
4 -1 0
0
6 -1 5
0
end_operator
begin_operator
leave p0 slow1-0 n10 n2 n1
3
0 0
4 2
6 2
2
0
4 -1 1
0
6 -1 5
0
end_operator
begin_operator
leave p0 slow1-0 n11 n1 n0
3
0 1
4 1
6 2
2
0
4 -1 0
0
6 -1 6
0
end_operator
begin_operator
leave p0 slow1-0 n11 n2 n1
3
0 1
4 2
6 2
2
0
4 -1 1
0
6 -1 6
0
end_operator
begin_operator
leave p0 slow1-0 n12 n1 n0
3
0 2
4 1
6 2
2
0
4 -1 0
0
6 -1 7
0
end_operator
begin_operator
leave p0 slow1-0 n12 n2 n1
3
0 2
4 2
6 2
2
0
4 -1 1
0
6 -1 7
0
end_operator
begin_operator
leave p0 slow1-0 n6 n1 n0
3
0 3
4 1
6 2
2
0
4 -1 0
0
6 -1 12
0
end_operator
begin_operator
leave p0 slow1-0 n6 n2 n1
3
0 3
4 2
6 2
2
0
4 -1 1
0
6 -1 12
0
end_operator
begin_operator
leave p0 slow1-0 n7 n1 n0
3
0 4
4 1
6 2
2
0
4 -1 0
0
6 -1 13
0
end_operator
begin_operator
leave p0 slow1-0 n7 n2 n1
3
0 4
4 2
6 2
2
0
4 -1 1
0
6 -1 13
0
end_operator
begin_operator
leave p0 slow1-0 n8 n1 n0
3
0 5
4 1
6 2
2
0
4 -1 0
0
6 -1 14
0
end_operator
begin_operator
leave p0 slow1-0 n8 n2 n1
3
0 5
4 2
6 2
2
0
4 -1 1
0
6 -1 14
0
end_operator
begin_operator
leave p0 slow1-0 n9 n1 n0
3
0 6
4 1
6 2
2
0
4 -1 0
0
6 -1 15
0
end_operator
begin_operator
leave p0 slow1-0 n9 n2 n1
3
0 6
4 2
6 2
2
0
4 -1 1
0
6 -1 15
0
end_operator
begin_operator
leave p1 fast0 n0 n1 n0
3
2 0
5 1
7 0
2
0
5 -1 0
0
7 -1 3
0
end_operator
begin_operator
leave p1 fast0 n0 n2 n1
3
2 0
5 2
7 0
2
0
5 -1 1
0
7 -1 3
0
end_operator
begin_operator
leave p1 fast0 n0 n3 n2
3
2 0
5 3
7 0
2
0
5 -1 2
0
7 -1 3
0
end_operator
begin_operator
leave p1 fast0 n12 n1 n0
3
2 1
5 1
7 0
2
0
5 -1 0
0
7 -1 7
0
end_operator
begin_operator
leave p1 fast0 n12 n2 n1
3
2 1
5 2
7 0
2
0
5 -1 1
0
7 -1 7
0
end_operator
begin_operator
leave p1 fast0 n12 n3 n2
3
2 1
5 3
7 0
2
0
5 -1 2
0
7 -1 7
0
end_operator
begin_operator
leave p1 fast0 n3 n1 n0
3
2 2
5 1
7 0
2
0
5 -1 0
0
7 -1 9
0
end_operator
begin_operator
leave p1 fast0 n3 n2 n1
3
2 2
5 2
7 0
2
0
5 -1 1
0
7 -1 9
0
end_operator
begin_operator
leave p1 fast0 n3 n3 n2
3
2 2
5 3
7 0
2
0
5 -1 2
0
7 -1 9
0
end_operator
begin_operator
leave p1 fast0 n6 n1 n0
3
2 3
5 1
7 0
2
0
5 -1 0
0
7 -1 12
0
end_operator
begin_operator
leave p1 fast0 n6 n2 n1
3
2 3
5 2
7 0
2
0
5 -1 1
0
7 -1 12
0
end_operator
begin_operator
leave p1 fast0 n6 n3 n2
3
2 3
5 3
7 0
2
0
5 -1 2
0
7 -1 12
0
end_operator
begin_operator
leave p1 fast0 n9 n1 n0
3
2 4
5 1
7 0
2
0
5 -1 0
0
7 -1 15
0
end_operator
begin_operator
leave p1 fast0 n9 n2 n1
3
2 4
5 2
7 0
2
0
5 -1 1
0
7 -1 15
0
end_operator
begin_operator
leave p1 fast0 n9 n3 n2
3
2 4
5 3
7 0
2
0
5 -1 2
0
7 -1 15
0
end_operator
begin_operator
leave p1 slow0-0 n0 n1 n0
3
1 0
3 1
7 1
2
0
3 -1 0
0
7 -1 3
0
end_operator
begin_operator
leave p1 slow0-0 n0 n2 n1
3
1 0
3 2
7 1
2
0
3 -1 1
0
7 -1 3
0
end_operator
begin_operator
leave p1 slow0-0 n1 n1 n0
3
1 1
3 1
7 1
2
0
3 -1 0
0
7 -1 4
0
end_operator
begin_operator
leave p1 slow0-0 n1 n2 n1
3
1 1
3 2
7 1
2
0
3 -1 1
0
7 -1 4
0
end_operator
begin_operator
leave p1 slow0-0 n2 n1 n0
3
1 2
3 1
7 1
2
0
3 -1 0
0
7 -1 8
0
end_operator
begin_operator
leave p1 slow0-0 n2 n2 n1
3
1 2
3 2
7 1
2
0
3 -1 1
0
7 -1 8
0
end_operator
begin_operator
leave p1 slow0-0 n3 n1 n0
3
1 3
3 1
7 1
2
0
3 -1 0
0
7 -1 9
0
end_operator
begin_operator
leave p1 slow0-0 n3 n2 n1
3
1 3
3 2
7 1
2
0
3 -1 1
0
7 -1 9
0
end_operator
begin_operator
leave p1 slow0-0 n4 n1 n0
3
1 4
3 1
7 1
2
0
3 -1 0
0
7 -1 10
0
end_operator
begin_operator
leave p1 slow0-0 n4 n2 n1
3
1 4
3 2
7 1
2
0
3 -1 1
0
7 -1 10
0
end_operator
begin_operator
leave p1 slow0-0 n5 n1 n0
3
1 5
3 1
7 1
2
0
3 -1 0
0
7 -1 11
0
end_operator
begin_operator
leave p1 slow0-0 n5 n2 n1
3
1 5
3 2
7 1
2
0
3 -1 1
0
7 -1 11
0
end_operator
begin_operator
leave p1 slow0-0 n6 n1 n0
3
1 6
3 1
7 1
2
0
3 -1 0
0
7 -1 12
0
end_operator
begin_operator
leave p1 slow0-0 n6 n2 n1
3
1 6
3 2
7 1
2
0
3 -1 1
0
7 -1 12
0
end_operator
begin_operator
leave p1 slow1-0 n10 n1 n0
3
0 0
4 1
7 2
2
0
4 -1 0
0
7 -1 5
0
end_operator
begin_operator
leave p1 slow1-0 n10 n2 n1
3
0 0
4 2
7 2
2
0
4 -1 1
0
7 -1 5
0
end_operator
begin_operator
leave p1 slow1-0 n11 n1 n0
3
0 1
4 1
7 2
2
0
4 -1 0
0
7 -1 6
0
end_operator
begin_operator
leave p1 slow1-0 n11 n2 n1
3
0 1
4 2
7 2
2
0
4 -1 1
0
7 -1 6
0
end_operator
begin_operator
leave p1 slow1-0 n12 n1 n0
3
0 2
4 1
7 2
2
0
4 -1 0
0
7 -1 7
0
end_operator
begin_operator
leave p1 slow1-0 n12 n2 n1
3
0 2
4 2
7 2
2
0
4 -1 1
0
7 -1 7
0
end_operator
begin_operator
leave p1 slow1-0 n6 n1 n0
3
0 3
4 1
7 2
2
0
4 -1 0
0
7 -1 12
0
end_operator
begin_operator
leave p1 slow1-0 n6 n2 n1
3
0 3
4 2
7 2
2
0
4 -1 1
0
7 -1 12
0
end_operator
begin_operator
leave p1 slow1-0 n7 n1 n0
3
0 4
4 1
7 2
2
0
4 -1 0
0
7 -1 13
0
end_operator
begin_operator
leave p1 slow1-0 n7 n2 n1
3
0 4
4 2
7 2
2
0
4 -1 1
0
7 -1 13
0
end_operator
begin_operator
leave p1 slow1-0 n8 n1 n0
3
0 5
4 1
7 2
2
0
4 -1 0
0
7 -1 14
0
end_operator
begin_operator
leave p1 slow1-0 n8 n2 n1
3
0 5
4 2
7 2
2
0
4 -1 1
0
7 -1 14
0
end_operator
begin_operator
leave p1 slow1-0 n9 n1 n0
3
0 6
4 1
7 2
2
0
4 -1 0
0
7 -1 15
0
end_operator
begin_operator
leave p1 slow1-0 n9 n2 n1
3
0 6
4 2
7 2
2
0
4 -1 1
0
7 -1 15
0
end_operator
begin_operator
leave p2 fast0 n0 n1 n0
3
2 0
5 1
8 0
2
0
5 -1 0
0
8 -1 3
0
end_operator
begin_operator
leave p2 fast0 n0 n2 n1
3
2 0
5 2
8 0
2
0
5 -1 1
0
8 -1 3
0
end_operator
begin_operator
leave p2 fast0 n0 n3 n2
3
2 0
5 3
8 0
2
0
5 -1 2
0
8 -1 3
0
end_operator
begin_operator
leave p2 fast0 n12 n1 n0
3
2 1
5 1
8 0
2
0
5 -1 0
0
8 -1 7
0
end_operator
begin_operator
leave p2 fast0 n12 n2 n1
3
2 1
5 2
8 0
2
0
5 -1 1
0
8 -1 7
0
end_operator
begin_operator
leave p2 fast0 n12 n3 n2
3
2 1
5 3
8 0
2
0
5 -1 2
0
8 -1 7
0
end_operator
begin_operator
leave p2 fast0 n3 n1 n0
3
2 2
5 1
8 0
2
0
5 -1 0
0
8 -1 9
0
end_operator
begin_operator
leave p2 fast0 n3 n2 n1
3
2 2
5 2
8 0
2
0
5 -1 1
0
8 -1 9
0
end_operator
begin_operator
leave p2 fast0 n3 n3 n2
3
2 2
5 3
8 0
2
0
5 -1 2
0
8 -1 9
0
end_operator
begin_operator
leave p2 fast0 n6 n1 n0
3
2 3
5 1
8 0
2
0
5 -1 0
0
8 -1 12
0
end_operator
begin_operator
leave p2 fast0 n6 n2 n1
3
2 3
5 2
8 0
2
0
5 -1 1
0
8 -1 12
0
end_operator
begin_operator
leave p2 fast0 n6 n3 n2
3
2 3
5 3
8 0
2
0
5 -1 2
0
8 -1 12
0
end_operator
begin_operator
leave p2 fast0 n9 n1 n0
3
2 4
5 1
8 0
2
0
5 -1 0
0
8 -1 15
0
end_operator
begin_operator
leave p2 fast0 n9 n2 n1
3
2 4
5 2
8 0
2
0
5 -1 1
0
8 -1 15
0
end_operator
begin_operator
leave p2 fast0 n9 n3 n2
3
2 4
5 3
8 0
2
0
5 -1 2
0
8 -1 15
0
end_operator
begin_operator
leave p2 slow0-0 n0 n1 n0
3
1 0
3 1
8 1
2
0
3 -1 0
0
8 -1 3
0
end_operator
begin_operator
leave p2 slow0-0 n0 n2 n1
3
1 0
3 2
8 1
2
0
3 -1 1
0
8 -1 3
0
end_operator
begin_operator
leave p2 slow0-0 n1 n1 n0
3
1 1
3 1
8 1
2
0
3 -1 0
0
8 -1 4
0
end_operator
begin_operator
leave p2 slow0-0 n1 n2 n1
3
1 1
3 2
8 1
2
0
3 -1 1
0
8 -1 4
0
end_operator
begin_operator
leave p2 slow0-0 n2 n1 n0
3
1 2
3 1
8 1
2
0
3 -1 0
0
8 -1 8
0
end_operator
begin_operator
leave p2 slow0-0 n2 n2 n1
3
1 2
3 2
8 1
2
0
3 -1 1
0
8 -1 8
0
end_operator
begin_operator
leave p2 slow0-0 n3 n1 n0
3
1 3
3 1
8 1
2
0
3 -1 0
0
8 -1 9
0
end_operator
begin_operator
leave p2 slow0-0 n3 n2 n1
3
1 3
3 2
8 1
2
0
3 -1 1
0
8 -1 9
0
end_operator
begin_operator
leave p2 slow0-0 n4 n1 n0
3
1 4
3 1
8 1
2
0
3 -1 0
0
8 -1 10
0
end_operator
begin_operator
leave p2 slow0-0 n4 n2 n1
3
1 4
3 2
8 1
2
0
3 -1 1
0
8 -1 10
0
end_operator
begin_operator
leave p2 slow0-0 n5 n1 n0
3
1 5
3 1
8 1
2
0
3 -1 0
0
8 -1 11
0
end_operator
begin_operator
leave p2 slow0-0 n5 n2 n1
3
1 5
3 2
8 1
2
0
3 -1 1
0
8 -1 11
0
end_operator
begin_operator
leave p2 slow0-0 n6 n1 n0
3
1 6
3 1
8 1
2
0
3 -1 0
0
8 -1 12
0
end_operator
begin_operator
leave p2 slow0-0 n6 n2 n1
3
1 6
3 2
8 1
2
0
3 -1 1
0
8 -1 12
0
end_operator
begin_operator
leave p2 slow1-0 n10 n1 n0
3
0 0
4 1
8 2
2
0
4 -1 0
0
8 -1 5
0
end_operator
begin_operator
leave p2 slow1-0 n10 n2 n1
3
0 0
4 2
8 2
2
0
4 -1 1
0
8 -1 5
0
end_operator
begin_operator
leave p2 slow1-0 n11 n1 n0
3
0 1
4 1
8 2
2
0
4 -1 0
0
8 -1 6
0
end_operator
begin_operator
leave p2 slow1-0 n11 n2 n1
3
0 1
4 2
8 2
2
0
4 -1 1
0
8 -1 6
0
end_operator
begin_operator
leave p2 slow1-0 n12 n1 n0
3
0 2
4 1
8 2
2
0
4 -1 0
0
8 -1 7
0
end_operator
begin_operator
leave p2 slow1-0 n12 n2 n1
3
0 2
4 2
8 2
2
0
4 -1 1
0
8 -1 7
0
end_operator
begin_operator
leave p2 slow1-0 n6 n1 n0
3
0 3
4 1
8 2
2
0
4 -1 0
0
8 -1 12
0
end_operator
begin_operator
leave p2 slow1-0 n6 n2 n1
3
0 3
4 2
8 2
2
0
4 -1 1
0
8 -1 12
0
end_operator
begin_operator
leave p2 slow1-0 n7 n1 n0
3
0 4
4 1
8 2
2
0
4 -1 0
0
8 -1 13
0
end_operator
begin_operator
leave p2 slow1-0 n7 n2 n1
3
0 4
4 2
8 2
2
0
4 -1 1
0
8 -1 13
0
end_operator
begin_operator
leave p2 slow1-0 n8 n1 n0
3
0 5
4 1
8 2
2
0
4 -1 0
0
8 -1 14
0
end_operator
begin_operator
leave p2 slow1-0 n8 n2 n1
3
0 5
4 2
8 2
2
0
4 -1 1
0
8 -1 14
0
end_operator
begin_operator
leave p2 slow1-0 n9 n1 n0
3
0 6
4 1
8 2
2
0
4 -1 0
0
8 -1 15
0
end_operator
begin_operator
leave p2 slow1-0 n9 n2 n1
3
0 6
4 2
8 2
2
0
4 -1 1
0
8 -1 15
0
end_operator
begin_operator
move-down-fast fast0 n12 n0
1
2 1
1
0
2 -1 0
37
end_operator
begin_operator
move-down-fast fast0 n12 n3
1
2 1
1
0
2 -1 2
28
end_operator
begin_operator
move-down-fast fast0 n12 n6
1
2 1
1
0
2 -1 3
19
end_operator
begin_operator
move-down-fast fast0 n12 n9
1
2 1
1
0
2 -1 4
10
end_operator
begin_operator
move-down-fast fast0 n3 n0
1
2 2
1
0
2 -1 0
10
end_operator
begin_operator
move-down-fast fast0 n6 n0
1
2 3
1
0
2 -1 0
19
end_operator
begin_operator
move-down-fast fast0 n6 n3
1
2 3
1
0
2 -1 2
10
end_operator
begin_operator
move-down-fast fast0 n9 n0
1
2 4
1
0
2 -1 0
28
end_operator
begin_operator
move-down-fast fast0 n9 n3
1
2 4
1
0
2 -1 2
19
end_operator
begin_operator
move-down-fast fast0 n9 n6
1
2 4
1
0
2 -1 3
10
end_operator
begin_operator
move-down-slow slow0-0 n1 n0
1
1 1
1
0
1 -1 0
6
end_operator
begin_operator
move-down-slow slow0-0 n2 n0
1
1 2
1
0
1 -1 0
7
end_operator
begin_operator
move-down-slow slow0-0 n2 n1
1
1 2
1
0
1 -1 1
6
end_operator
begin_operator
move-down-slow slow0-0 n3 n0
1
1 3
1
0
1 -1 0
8
end_operator
begin_operator
move-down-slow slow0-0 n3 n1
1
1 3
1
0
1 -1 1
7
end_operator
begin_operator
move-down-slow slow0-0 n3 n2
1
1 3
1
0
1 -1 2
6
end_operator
begin_operator
move-down-slow slow0-0 n4 n0
1
1 4
1
0
1 -1 0
9
end_operator
begin_operator
move-down-slow slow0-0 n4 n1
1
1 4
1
0
1 -1 1
8
end_operator
begin_operator
move-down-slow slow0-0 n4 n2
1
1 4
1
0
1 -1 2
7
end_operator
begin_operator
move-down-slow slow0-0 n4 n3
1
1 4
1
0
1 -1 3
6
end_operator
begin_operator
move-down-slow slow0-0 n5 n0
1
1 5
1
0
1 -1 0
10
end_operator
begin_operator
move-down-slow slow0-0 n5 n1
1
1 5
1
0
1 -1 1
9
end_operator
begin_operator
move-down-slow slow0-0 n5 n2
1
1 5
1
0
1 -1 2
8
end_operator
begin_operator
move-down-slow slow0-0 n5 n3
1
1 5
1
0
1 -1 3
7
end_operator
begin_operator
move-down-slow slow0-0 n5 n4
1
1 5
1
0
1 -1 4
6
end_operator
begin_operator
move-down-slow slow0-0 n6 n0
1
1 6
1
0
1 -1 0
11
end_operator
begin_operator
move-down-slow slow0-0 n6 n1
1
1 6
1
0
1 -1 1
10
end_operator
begin_operator
move-down-slow slow0-0 n6 n2
1
1 6
1
0
1 -1 2
9
end_operator
begin_operator
move-down-slow slow0-0 n6 n3
1
1 6
1
0
1 -1 3
8
end_operator
begin_operator
move-down-slow slow0-0 n6 n4
1
1 6
1
0
1 -1 4
7
end_operator
begin_operator
move-down-slow slow0-0 n6 n5
1
1 6
1
0
1 -1 5
6
end_operator
begin_operator
move-down-slow slow1-0 n10 n6
1
0 0
1
0
0 -1 3
9
end_operator
begin_operator
move-down-slow slow1-0 n10 n7
1
0 0
1
0
0 -1 4
8
end_operator
begin_operator
move-down-slow slow1-0 n10 n8
1
0 0
1
0
0 -1 5
7
end_operator
begin_operator
move-down-slow slow1-0 n10 n9
1
0 0
1
0
0 -1 6
6
end_operator
begin_operator
move-down-slow slow1-0 n11 n10
1
0 1
1
0
0 -1 0
6
end_operator
begin_operator
move-down-slow slow1-0 n11 n6
1
0 1
1
0
0 -1 3
10
end_operator
begin_operator
move-down-slow slow1-0 n11 n7
1
0 1
1
0
0 -1 4
9
end_operator
begin_operator
move-down-slow slow1-0 n11 n8
1
0 1
1
0
0 -1 5
8
end_operator
begin_operator
move-down-slow slow1-0 n11 n9
1
0 1
1
0
0 -1 6
7
end_operator
begin_operator
move-down-slow slow1-0 n12 n10
1
0 2
1
0
0 -1 0
7
end_operator
begin_operator
move-down-slow slow1-0 n12 n11
1
0 2
1
0
0 -1 1
6
end_operator
begin_operator
move-down-slow slow1-0 n12 n6
1
0 2
1
0
0 -1 3
11
end_operator
begin_operator
move-down-slow slow1-0 n12 n7
1
0 2
1
0
0 -1 4
10
end_operator
begin_operator
move-down-slow slow1-0 n12 n8
1
0 2
1
0
0 -1 5
9
end_operator
begin_operator
move-down-slow slow1-0 n12 n9
1
0 2
1
0
0 -1 6
8
end_operator
begin_operator
move-down-slow slow1-0 n7 n6
1
0 4
1
0
0 -1 3
6
end_operator
begin_operator
move-down-slow slow1-0 n8 n6
1
0 5
1
0
0 -1 3
7
end_operator
begin_operator
move-down-slow slow1-0 n8 n7
1
0 5
1
0
0 -1 4
6
end_operator
begin_operator
move-down-slow slow1-0 n9 n6
1
0 6
1
0
0 -1 3
8
end_operator
begin_operator
move-down-slow slow1-0 n9 n7
1
0 6
1
0
0 -1 4
7
end_operator
begin_operator
move-down-slow slow1-0 n9 n8
1
0 6
1
0
0 -1 5
6
end_operator
begin_operator
move-up-fast fast0 n0 n12
1
2 0
1
0
2 -1 1
37
end_operator
begin_operator
move-up-fast fast0 n0 n3
1
2 0
1
0
2 -1 2
10
end_operator
begin_operator
move-up-fast fast0 n0 n6
1
2 0
1
0
2 -1 3
19
end_operator
begin_operator
move-up-fast fast0 n0 n9
1
2 0
1
0
2 -1 4
28
end_operator
begin_operator
move-up-fast fast0 n3 n12
1
2 2
1
0
2 -1 1
28
end_operator
begin_operator
move-up-fast fast0 n3 n6
1
2 2
1
0
2 -1 3
10
end_operator
begin_operator
move-up-fast fast0 n3 n9
1
2 2
1
0
2 -1 4
19
end_operator
begin_operator
move-up-fast fast0 n6 n12
1
2 3
1
0
2 -1 1
19
end_operator
begin_operator
move-up-fast fast0 n6 n9
1
2 3
1
0
2 -1 4
10
end_operator
begin_operator
move-up-fast fast0 n9 n12
1
2 4
1
0
2 -1 1
10
end_operator
begin_operator
move-up-slow slow0-0 n0 n1
1
1 0
1
0
1 -1 1
6
end_operator
begin_operator
move-up-slow slow0-0 n0 n2
1
1 0
1
0
1 -1 2
7
end_operator
begin_operator
move-up-slow slow0-0 n0 n3
1
1 0
1
0
1 -1 3
8
end_operator
begin_operator
move-up-slow slow0-0 n0 n4
1
1 0
1
0
1 -1 4
9
end_operator
begin_operator
move-up-slow slow0-0 n0 n5
1
1 0
1
0
1 -1 5
10
end_operator
begin_operator
move-up-slow slow0-0 n0 n6
1
1 0
1
0
1 -1 6
11
end_operator
begin_operator
move-up-slow slow0-0 n1 n2
1
1 1
1
0
1 -1 2
6
end_operator
begin_operator
move-up-slow slow0-0 n1 n3
1
1 1
1
0
1 -1 3
7
end_operator
begin_operator
move-up-slow slow0-0 n1 n4
1
1 1
1
0
1 -1 4
8
end_operator
begin_operator
move-up-slow slow0-0 n1 n5
1
1 1
1
0
1 -1 5
9
end_operator
begin_operator
move-up-slow slow0-0 n1 n6
1
1 1
1
0
1 -1 6
10
end_operator
begin_operator
move-up-slow slow0-0 n2 n3
1
1 2
1
0
1 -1 3
6
end_operator
begin_operator
move-up-slow slow0-0 n2 n4
1
1 2
1
0
1 -1 4
7
end_operator
begin_operator
move-up-slow slow0-0 n2 n5
1
1 2
1
0
1 -1 5
8
end_operator
begin_operator
move-up-slow slow0-0 n2 n6
1
1 2
1
0
1 -1 6
9
end_operator
begin_operator
move-up-slow slow0-0 n3 n4
1
1 3
1
0
1 -1 4
6
end_operator
begin_operator
move-up-slow slow0-0 n3 n5
1
1 3
1
0
1 -1 5
7
end_operator
begin_operator
move-up-slow slow0-0 n3 n6
1
1 3
1
0
1 -1 6
8
end_operator
begin_operator
move-up-slow slow0-0 n4 n5
1
1 4
1
0
1 -1 5
6
end_operator
begin_operator
move-up-slow slow0-0 n4 n6
1
1 4
1
0
1 -1 6
7
end_operator
begin_operator
move-up-slow slow0-0 n5 n6
1
1 5
1
0
1 -1 6
6
end_operator
begin_operator
move-up-slow slow1-0 n10 n11
1
0 0
1
0
0 -1 1
6
end_operator
begin_operator
move-up-slow slow1-0 n10 n12
1
0 0
1
0
0 -1 2
7
end_operator
begin_operator
move-up-slow slow1-0 n11 n12
1
0 1
1
0
0 -1 2
6
end_operator
begin_operator
move-up-slow slow1-0 n6 n10
1
0 3
1
0
0 -1 0
9
end_operator
begin_operator
move-up-slow slow1-0 n6 n11
1
0 3
1
0
0 -1 1
10
end_operator
begin_operator
move-up-slow slow1-0 n6 n12
1
0 3
1
0
0 -1 2
11
end_operator
begin_operator
move-up-slow slow1-0 n6 n7
1
0 3
1
0
0 -1 4
6
end_operator
begin_operator
move-up-slow slow1-0 n6 n8
1
0 3
1
0
0 -1 5
7
end_operator
begin_operator
move-up-slow slow1-0 n6 n9
1
0 3
1
0
0 -1 6
8
end_operator
begin_operator
move-up-slow slow1-0 n7 n10
1
0 4
1
0
0 -1 0
8
end_operator
begin_operator
move-up-slow slow1-0 n7 n11
1
0 4
1
0
0 -1 1
9
end_operator
begin_operator
move-up-slow slow1-0 n7 n12
1
0 4
1
0
0 -1 2
10
end_operator
begin_operator
move-up-slow slow1-0 n7 n8
1
0 4
1
0
0 -1 5
6
end_operator
begin_operator
move-up-slow slow1-0 n7 n9
1
0 4
1
0
0 -1 6
7
end_operator
begin_operator
move-up-slow slow1-0 n8 n10
1
0 5
1
0
0 -1 0
7
end_operator
begin_operator
move-up-slow slow1-0 n8 n11
1
0 5
1
0
0 -1 1
8
end_operator
begin_operator
move-up-slow slow1-0 n8 n12
1
0 5
1
0
0 -1 2
9
end_operator
begin_operator
move-up-slow slow1-0 n8 n9
1
0 5
1
0
0 -1 6
6
end_operator
begin_operator
move-up-slow slow1-0 n9 n10
1
0 6
1
0
0 -1 0
6
end_operator
begin_operator
move-up-slow slow1-0 n9 n11
1
0 6
1
0
0 -1 1
7
end_operator
begin_operator
move-up-slow slow1-0 n9 n12
1
0 6
1
0
0 -1 2
8
end_operator
0
