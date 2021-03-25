*&---------------------------------------------------------------------*
*& Report ZANK_P_PASCALS_TRIANGLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_PASCALS_TRIANGLE.

*&---------------------------------------------------------
*& Given a non-negative integer no_of_rows,
*&generate the first no_of_rows of Pascal's triangle.
*&---------------------------------------------------------

TYPES: BEGIN OF ty_table,
       value TYPE i,
        END OF ty_table.

DATA: inner_wa TYPE ty_table.
data: inner_array TYPE TABLE OF ty_table.

TYPES: BEGIN OF ty_stack,
       row like inner_array,
       END OF ty_stack.

DATA: outer_wa TYPE ty_stack.
DATA: outer_array TYPE TABLE OF ty_stack.

DATA(no_of_rows) = 5.
DATA(sum) = 0.

DO no_of_rows TIMES.
  DATA(counter) = 2.
  CLEAR: inner_wa.
  REFRESH: inner_array[].
  CASE sy-index.

    WHEN 1.
      inner_wa-value = 1.
      APPEND inner_wa TO inner_array.
      APPEND INITIAL LINE TO outer_array.
      outer_array[ 1 ]-row = inner_array.

    WHEN OTHERS.
      DATA(curr_idx) = sy-index.
      DATA(prev_idx) = sy-index - 1.
      DATA(prev_values) = outer_array[ prev_idx ]-row.

      DO sy-index TIMES.
        APPEND INITIAL LINE TO inner_array.
      ENDDO.

      inner_array[ 1 ]-value = 1. " Always set the first and last values to 1
      inner_array[ sy-index ]-value = 1.
      DO ( sy-index - 2 ) TIMES.
        sum =  prev_values[ counter - 1 ]-value + prev_values[ counter ]-value.
        inner_array[ counter ]-value = sum.
        counter = counter  + 1.
      ENDDO.

      APPEND INITIAL LINE TO outer_array.
      outer_array[ curr_idx ]-row = inner_array.


  ENDCASE.
ENDDO.
BREAK-POINT.
