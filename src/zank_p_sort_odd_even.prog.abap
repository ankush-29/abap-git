*&---------------------------------------------------------------------*
*& Report ZANK_P_SORT_ODD_EVEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_SORT_ODD_EVEN.


*Given an array of integers (both odd and even),
*sort them in such a way that the first part of the array contains odd numbers sorted in descending order,
*rest portion contains even numbers sorted in ascending order.

DATA: input_array TYPE int4_table.
input_array = VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 5 ) ( 4 ) ( 7 ) ( 10 ) ).
DATA: swap_position TYPE i.

LOOP AT input_array INTO DATA(array_value) FROM 2.
*  DATA(previous) = array_value[ sy-index - 1 ].
  IF array_value MOD 2 NE 0.
    "swap the numbers
    DATA(temp) = array_value.
    input_array[ sy-tabix ] = input_array[ swap_position ].
    input_array[ swap_position ] = temp.
  ELSE.
    "remember the position
    swap_position = sy-tabix.
  ENDIF.
ENDLOOP.

cl_demo_output=>display_data(
  EXPORTING
    value = input_array
*    name  =                  " Name
).
