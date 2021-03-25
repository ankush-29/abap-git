*&---------------------------------------------------------------------*
*& Report ZANK_P_KADANE_ALGORITHM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_KADANE_ALGORITHM.

*Given an array arr of N integers. Find the contiguous sub-array with maximum sum.

DATA: input_array TYPE int4_table.
input_array = VALUE #( ( -2 ) ( 1 ) ( -3 ) ( 4 ) ( -1 ) ( 2 ) ( 1 ) ( -5 ) ( 4 ) ).

DATA(max_so_far) = 0.
DATA(max_ending_here) = 0.

LOOP AT input_array INTO DATA(array_value).

max_ending_here = max_ending_here + array_value.

PERFORM max_of_two USING max_ending_here 0 CHANGING max_ending_here.
PERFORM max_of_two USING max_so_far max_ending_here CHANGING max_so_far.

ENDLOOP.

WRITE: max_so_far.

FORM max_of_two USING P1 TYPE i P2 TYPE i CHANGING P3 TYPE i.

  P3 = COND #( WHEN P2 GT P1 THEN P2
               ELSE P1 ).
ENDFORM.
