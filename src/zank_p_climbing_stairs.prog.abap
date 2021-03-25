*&---------------------------------------------------------------------*
*& Report ZANK_P_CLIMBING_STAIRS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_CLIMBING_STAIRS.

*&---------------------------------------------------------
*& You are climbing a stair case.
*& It takes n steps to reach to the top.
*& Each time you can either climb 1 or 2 steps.
*& In how many distinct ways can you climb to the top?
*&---------------------------------------------------------

DATA(number_of_stairs) = 2.
DATA(current) = 0.
DATA(previous) = 0.
DATA(next) = 0.

DO number_of_stairs TIMES.
  CASE sy-index.

    WHEN 1 OR 2 OR 3.
      current = sy-index.
      previous = sy-index  - 1.
    WHEN OTHERS.
      next = current + previous .
      previous = current.
      current = next.

  ENDCASE.
ENDDO.

WRITE: |Number of distinct ways to climb up { number_of_stairs } number of stairs are : { current } |.
