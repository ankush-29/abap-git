*&---------------------------------------------------------------------*
*& Report ZANK_P_FIND_MAX_RECURSION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_FIND_MAX_RECURSION.

DATA(array) = VALUE int4_table( ( 3 ) ( 5 ) ( 66 ) ( 8 ) ( 2 ) ( 50 ) ).
DATA(max) = -1.
PERFORM find_max USING array CHANGING max.

WRITE: max.

FORM find_max USING i_array TYPE int4_table
              CHANGING max TYPE int4.
DATA: new_array TYPE int4_table.
DATA(lines) = lines( array ).
 WHILE lines( i_array ) > 1.
  INSERT LINES OF i_array FROM 2 TO lines INTO new_array.
 max = COND #( WHEN i_array[ 1 ] GT max THEN i_array[ 1 ] ).
 PERFORM find_max USING new_array CHANGING max.
 ENDWHILE.
 max = COND #( WHEN array[ 1 ] GT max THEN array[ 1 ] ).
ENDFORM.
