begin_version
3
end_version
begin_metric
0
end_metric
21
begin_variable
var0
-1
2
Atom uninitialized()
NegatedAtom uninitialized()
end_variable
begin_variable
var1
-1
2
Atom available(up-rsrc)
NegatedAtom available(up-rsrc)
end_variable
begin_variable
var2
-1
2
Atom available(htmovercolor-rsrc)
NegatedAtom available(htmovercolor-rsrc)
end_variable
begin_variable
var3
-1
2
Atom available(htmoverblack-rsrc)
NegatedAtom available(htmoverblack-rsrc)
end_variable
begin_variable
var4
-1
2
Atom available(finisher2-rsrc)
NegatedAtom available(finisher2-rsrc)
end_variable
begin_variable
var5
-1
2
Atom available(finisher1-rsrc)
NegatedAtom available(finisher1-rsrc)
end_variable
begin_variable
var6
-1
2
Atom available(endcap-rsrc)
NegatedAtom available(endcap-rsrc)
end_variable
begin_variable
var7
-1
2
Atom available(down-rsrc)
NegatedAtom available(down-rsrc)
end_variable
begin_variable
var8
-1
2
Atom available(colorprinter-rsrc)
NegatedAtom available(colorprinter-rsrc)
end_variable
begin_variable
var9
-1
2
Atom available(colorfeeder-rsrc)
NegatedAtom available(colorfeeder-rsrc)
end_variable
begin_variable
var10
-1
2
Atom available(colorcontainer-rsrc)
NegatedAtom available(colorcontainer-rsrc)
end_variable
begin_variable
var11
-1
2
Atom available(blackprinter-rsrc)
NegatedAtom available(blackprinter-rsrc)
end_variable
begin_variable
var12
-1
2
Atom available(blackfeeder-rsrc)
NegatedAtom available(blackfeeder-rsrc)
end_variable
begin_variable
var13
-1
2
Atom available(blackcontainer-rsrc)
NegatedAtom available(blackcontainer-rsrc)
end_variable
begin_variable
var14
-1
2
Atom sideup(sheet1, back)
NegatedAtom sideup(sheet1, back)
end_variable
begin_variable
var15
-1
2
Atom notprintedwith(sheet1, front, black)
NegatedAtom notprintedwith(sheet1, front, black)
end_variable
begin_variable
var16
-1
18
Atom location(sheet1, blackcontainer_entry-blackfeeder_exit)
Atom location(sheet1, blackcontainer_exittoime-blackprinter_entry)
Atom location(sheet1, blackprinter_exit-blackcontainer_entryfromime)
Atom location(sheet1, colorcontainer_entry-down_bottomexit)
Atom location(sheet1, colorcontainer_exit-up_bottomentry)
Atom location(sheet1, colorcontainer_exittoime-colorprinter_entry)
Atom location(sheet1, colorprinter_exit-colorcontainer_entryfromime)
Atom location(sheet1, down_bottomentry-colorfeeder_exit)
Atom location(sheet1, down_topexit-htmovercolor_entry)
Atom location(sheet1, endcap_entry-blackcontainer_exit)
Atom location(sheet1, finisher1_entry-up_topexit)
Atom location(sheet1, finisher2_entry-finisher1_exit)
Atom location(sheet1, finisher2_exit)
Atom location(sheet1, htmoverblack_entry-endcap_exit)
Atom location(sheet1, htmoverblack_exit-down_topentry)
Atom location(sheet1, htmovercolor_exit-up_topentry)
Atom location(sheet1, some_feeder_tray)
Atom location(sheet1, some_finisher_tray)
end_variable
begin_variable
var17
-1
2
Atom notprintedwith(sheet1, back, black)
NegatedAtom notprintedwith(sheet1, back, black)
end_variable
begin_variable
var18
-1
2
Atom sideup(sheet1, front)
NegatedAtom sideup(sheet1, front)
end_variable
begin_variable
var19
-1
2
Atom stackedin(sheet1, finisher1_tray)
NegatedAtom stackedin(sheet1, finisher1_tray)
end_variable
begin_variable
var20
-1
2
Atom hasimage(sheet1, front, image-1)
NegatedAtom hasimage(sheet1, front, image-1)
end_variable
0
begin_state
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 0 0 1 0 
end_state
begin_goal
4
17 0
18 0
19 0
20 0
end_goal
25
begin_operator
blackcontainer-fromime-letter sheet1
2
13 0
16 2
1
0
16 -1 9
2000
end_operator
begin_operator
blackcontainer-toime-letter sheet1
2
13 0
16 0
1
0
16 -1 1
2000
end_operator
begin_operator
blackfeeder-feed-letter sheet1
2
12 0
16 16
2
0
16 -1 0
0
18 -1 0
8000
end_operator
begin_operator
blackprinter-simplex-letter sheet1 back image-1
4
11 0
14 0
16 1
17 0
2
0
16 -1 2
0
17 -1 1
113013
end_operator
begin_operator
blackprinter-simplex-letter sheet1 front image-1
4
11 0
15 0
16 1
18 0
3
0
15 -1 1
0
16 -1 2
0
20 -1 0
113013
end_operator
begin_operator
blackprinter-simplexandinvert-letter sheet1 back front image-1
4
11 0
14 0
16 1
17 0
4
0
14 -1 1
0
16 -1 2
0
17 -1 1
0
18 -1 0
123013
end_operator
begin_operator
blackprinter-simplexandinvert-letter sheet1 front back image-1
4
11 0
15 0
16 1
18 0
5
0
14 -1 0
0
15 -1 1
0
16 -1 2
0
18 -1 1
0
20 -1 0
123013
end_operator
begin_operator
colorcontainer-fromime-letter sheet1
2
10 0
16 6
1
0
16 -1 4
8000
end_operator
begin_operator
colorcontainer-toime-letter sheet1
2
10 0
16 3
1
0
16 -1 5
8000
end_operator
begin_operator
colorfeeder-feed-letter sheet1
2
9 0
16 16
2
0
16 -1 7
0
18 -1 0
8000
end_operator
begin_operator
colorprinter-simplexmono-letter sheet1 back image-1
4
8 0
14 0
16 5
17 0
2
0
16 -1 6
0
17 -1 1
224040
end_operator
begin_operator
colorprinter-simplexmono-letter sheet1 front image-1
4
8 0
15 0
16 5
18 0
3
0
15 -1 1
0
16 -1 6
0
20 -1 0
224040
end_operator
begin_operator
down-movebottom-letter sheet1
2
7 0
16 7
1
0
16 -1 3
2999
end_operator
begin_operator
down-movedown-letter sheet1
2
7 0
16 14
1
0
16 -1 3
9999
end_operator
begin_operator
down-movetop-letter sheet1
2
7 0
16 14
1
0
16 -1 8
2999
end_operator
begin_operator
endcap-move-letter sheet1
2
6 0
16 9
1
0
16 -1 13
2000
end_operator
begin_operator
finisher1-passthrough-letter sheet1
2
5 0
16 10
1
0
16 -1 11
8000
end_operator
begin_operator
finisher1-stack-letter sheet1 dummy-sheet
2
5 0
16 10
2
0
16 -1 17
0
19 -1 0
8000
end_operator
begin_operator
finisher2-passthrough-letter sheet1
2
4 0
16 11
1
0
16 -1 12
8000
end_operator
begin_operator
finisher2-stack-letter sheet1 dummy-sheet
2
4 0
16 11
1
0
16 -1 17
8000
end_operator
begin_operator
htmoverblack-move-letter sheet1
2
3 0
16 13
1
0
16 -1 14
17999
end_operator
begin_operator
htmovercolor-move-letter sheet1
2
2 0
16 8
1
0
16 -1 15
9999
end_operator
begin_operator
initialize 
1
0 0
14
0
0 -1 1
0
1 -1 0
0
2 -1 0
0
3 -1 0
0
4 -1 0
0
5 -1 0
0
6 -1 0
0
7 -1 0
0
8 -1 0
0
9 -1 0
0
10 -1 0
0
11 -1 0
0
12 -1 0
0
13 -1 0
0
end_operator
begin_operator
up-movetop-letter sheet1
2
1 0
16 15
1
0
16 -1 10
2999
end_operator
begin_operator
up-moveup-letter sheet1
2
1 0
16 4
1
0
16 -1 10
9999
end_operator
0
