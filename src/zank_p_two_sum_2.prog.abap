*&---------------------------------------------------------------------*
*& Report ZANK_P_TWO_SUM_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_TWO_SUM_2.

TYPES: BEGIN OF ty_array,
       value TYPE i,
       END OF ty_array.

DATA: array TYPE TABLE OF ty_array.

array = VALUE #( ( value = 2 ) ( value = 3 ) ( value = 7 ) ( value = 11 ) ( value = 15 ) ).
DATA(target) = 10.
" index_1 = 2
" index_2 = 3

DATA(pointer_1) = 1.
DATA(pointer_2) = lines( array ).

WHILE pointer_2 GT pointer_1.

  IF ( array[ pointer_1 ]-value ) + ( array[ pointer_2 ]-value ) GT target.
    pointer_2 = pointer_2 - 1.
  ELSEIF ( array[ pointer_1 ]-value ) + ( array[ pointer_2 ]-value ) LT target.
    pointer_1 = pointer_1 + 1.
  ELSEIF ( array[ pointer_1 ]-value ) + ( array[ pointer_2 ]-value ) EQ target.
    WRITE: | Index 1: { pointer_1 } |.
    WRITE: | Index 2: { pointer_2 } |.
    RETURN.
  ENDIF.

ENDWHILE.
