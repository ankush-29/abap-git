*&---------------------------------------------------------------------*
*& Report ZANK_P_SEARCH_INSERT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_search_insert.

*----------------------------------------------------------------------------*
*Given a sorted array and a target value,
*return the index if the target is found.
*If not, return the index where it would be if it were inserted in order
** assume no duplicates in the array.
*----------------------------------------------------------------------------*
TYPES: BEGIN OF ty_array,
       value TYPE i,
       END OF ty_array.
TYPES: tty_array TYPE TABLE OF ty_array.
DATA: array TYPE TABLE OF ty_array.

array = VALUE #( ( value = 1 ) ( value = 3 ) ( value = 5 ) ( value = 6 ) ( value = 7 ) ).
DATA(target) = 3.
DATA(position) = -1.

PERFORM find_index USING array target CHANGING position.
WRITE: position.

FORM find_index USING p_array TYPE tty_array p_target TYPE i CHANGING p_pos TYPE i.

"Since the array is sorted, use binary search
DATA(low) = 1.
DESCRIBE TABLE p_array LINES DATA(high).
DATA(mid) = ( low + high ) / 2.

WHILE low < high AND low NE high - 1." <<-- This extra condition is required in case the element to be found is not in the array
 READ TABLE p_array INTO DATA(struc) INDEX mid.
 IF struc-value = p_target.
   p_pos = mid.
   EXIT.
  ELSEIF p_target > struc-value.
    low = mid.
    mid = ( low + high ) / 2.
  ELSEIF p_target < struc-value.
    high = mid.
    mid = ( low + high ) / 2.
 ENDIF.
ENDWHILE.
 IF p_pos EQ -1.
   p_pos = high.

 ENDIF.

ENDFORM.
