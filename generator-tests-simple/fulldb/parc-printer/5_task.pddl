(define (problem printjob) (:domain etipp) (:objects dummy-sheet sheet1 sheet2 sheet3 - sheet_t image-1 image-2 image-3 - image_t) (:init (uninitialized) (available uime-rsrc) (available uc1-rsrc) (available sys-rsrc) (available lime-rsrc) (available lc1-rsrc) (available hw1-rsrc) (available fe1-rsrc) (notprintedwith sheet1  front  color) (sideup sheet1  back) (location sheet1  lc1_entry-hw1_bottomleftexit) (notprintedwith sheet1  back  black) (notprintedwith sheet1  back  color) (not (sideup sheet1  front)) (notprintedwith sheet1  front  black) (stackedin sheet1  sys_outputtray) (notprintedwith sheet2  front  black) (sideup sheet2  back) (location sheet2  lc1_entry-hw1_bottomleftexit) (notprintedwith sheet2  back  black) (notprintedwith sheet2  back  color) (not (sideup sheet2  front)) (notprintedwith sheet2  front  color) (stackedin sheet2  sys_outputtray) (notprintedwith sheet3  front  black) (sideup sheet3  back) (location sheet3  lc1_entry-hw1_bottomleftexit) (notprintedwith sheet3  back  black) (notprintedwith sheet3  back  color) (not (sideup sheet3  front)) (notprintedwith sheet3  front  color) (stackedin sheet3  sys_outputtray) (not (hasimage sheet3  front  image-3)) (not (hasimage sheet2  front  image-2)) (not (hasimage sheet1  front  image-1))) (:goal (and (hasimage sheet1 front image-1) (notprintedwith sheet1 front black) (notprintedwith sheet1 back black) (notprintedwith sheet1 back color) (hasimage sheet2 front image-2) (notprintedwith sheet2 front color) (notprintedwith sheet2 back black) (notprintedwith sheet2 back color) (hasimage sheet3 front image-3) (notprintedwith sheet3 front color) (notprintedwith sheet3 back black) (notprintedwith sheet3 back color) (sideup sheet1 front) (sideup sheet2 front) (sideup sheet3 front) (stackedin sheet1 sys_outputtray) (stackedin sheet2 sys_outputtray) (stackedin sheet3 sys_outputtray))) (:metric minimize (total-cost)))