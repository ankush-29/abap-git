*&---------------------------------------------------------------------*
*& Report ZANK_P_BINARY_REP_OF_A_NUM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_BINARY_REP_OF_A_NUM.
PARAMETERS: number TYPE i.

START-OF-SELECTION.
DATA: stack TYPE int4_table,
      row  TYPE int4.
DATA: remainder TYPE f.
remainder = number.

WHILE remainder GE 1.
  row = remainder.
  APPEND row to stack.
  clear row.
  remainder = floor( remainder / 2 ).
ENDWHILE.

SORT stack ascending.

LOOP AT stack INTO row.
  DATA(bit) = row MOD 2.
 WRITE: bit.
ENDLOOP.
