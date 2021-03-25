*&---------------------------------------------------------------------*
*& Report ZANK_P_NTH_ELEMENT_FIBONACCI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_NTH_ELEMENT_FIBONACCI.

*================================================
* Fibonacci series : 0 1 1 2 3 5 8 13 21 ....
* F[1] = 0
* F[2] = 1
* e.g F[4] = F[3] + F[2].
*================================================

PARAMETERS: input TYPE i.
DATA: result TYPE i.

PERFORM find_element USING input CHANGING result.

WRITE: result.
FORM find_element USING input CHANGING result.


  DATA : out_1 TYPE i.
  DATA : out_2 TYPE i.
  IF input > 2.
    DATA(inp_1) = input - 1.
    PERFORM find_element USING inp_1 CHANGING out_1.
    DATA(inp_2) = input - 2.
    PERFORM find_element USING inp_2 CHANGING out_2.

    result = out_1 + out_2.
  ELSE.
    result = input.
  ENDIF.

ENDFORM.
