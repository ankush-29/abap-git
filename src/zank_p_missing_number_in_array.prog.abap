*&---------------------------------------------------------------------*
*& Report ZANK_P_MISSING_NUMBER_IN_ARRAY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_MISSING_NUMBER_IN_ARRAY.

*Given an array of size N-1 such that it can only contain distinct integers in the range of 1 to N.
*Find the missing element.

DATA: input_array TYPE int4_table,
      missing_number TYPE i.

input_array = VALUE #( ( 3 ) ( 6 ) ( 5 ) ( 2 ) ( 1 ) ).

SORT input_array ASCENDING.

LOOP AT input_array INTO DATA(array_value).
  IF sy-tabix NE array_value.
    missing_number = sy-tabix.
    EXIT.
  ENDIF.
ENDLOOP.

WRITE: |Missing number is: { missing_number } |.
