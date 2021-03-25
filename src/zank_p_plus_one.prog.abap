*&---------------------------------------------------------------------*
*& Report ZANK_P_PLUS_ONE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_plus_one.

*&----------------------------------------------------------------------------------------
*Given a non-empty array of digits representing a non-negative integer,
*increment one to the integer.
*The digits are stored such that the most significant digit is at the head of the list,
*and each element in the array contains a single digit.
*
*You may assume the integer does not contain any leading zero, except the number 0 itself.
*&----------------------------------------------------------------------------------------
TYPES: BEGIN OF ty_array,
       value TYPE i,
       END OF ty_array.
DATA: array TYPE TABLE OF ty_array.
DATA: inc_array TYPE TABLE OF ty_array.

array = VALUE #( ( value = 9 ) ( value = 9 ) ( value = 9 ) ( value = 9 ) ).
WRITE:|Input array --> |.
NEW-LINE.
WRITE:| { array[ 1 ]-value } , { array[ 2 ]-value } , { array[ 3 ]-value } , { array[ 4 ]-value } |.
NEW-LINE.
NEW-LINE.
WRITE:|Incremented array --> |.
NEW-LINE.
DESCRIBE TABLE array LINES DATA(length).

DATA(is_done) = abap_false.

WHILE length NE 0 AND is_done = abap_false.
  IF array[ length ]-value NE 9.
    array[ length ]-value = array[ length ]-value + 1.
    is_done = abap_true..
  ELSEIF array[ length ]-value EQ 9.
  IF length NE 1.
    array[ length ]-value = 0.
    length = length - 1.
  ELSE.
    is_done = abap_true.
    WRITE: |Out of bounds|.
    NEW-LINE.
   ENDIF.
  ENDIF.

ENDWHILE.

WRITE:| { array[ 1 ]-value } , { array[ 2 ]-value } , { array[ 3 ]-value } , { array[ 4 ]-value } |.
