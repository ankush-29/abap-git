*&---------------------------------------------------------------------*
*& Report ZANK_P_NUM_OF_TRAILING_ZEROS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_num_of_trailing_zeros.

*For an integer N find the number of trailing zeroes in N!.
* Test for 100!
PARAMETERS: input_n TYPE i.
DATA(trailing_zeroes) = 0.
DATA: remainder TYPE decfloat16.

IF input_n GE 5.
  PERFORM find_trailing USING input_n CHANGING trailing_zeroes.
  WRITE: |Trailing zeros: { trailing_zeroes } |.
ENDIF.

FORM find_trailing USING input_n CHANGING trailing_zeroes.
  remainder = floor( input_n / 5 ).
  trailing_zeroes = trailing_zeroes + remainder.
  IF remainder GE 5.
    PERFORM find_trailing USING remainder CHANGING trailing_zeroes.
  ENDIF.
ENDFORM.
