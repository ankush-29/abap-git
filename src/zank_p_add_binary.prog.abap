*&---------------------------------------------------------------------*
*& Report ZANK_P_ADD_BINARY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_add_binary.
DATA: str_1 TYPE string,
      str_2 TYPE string,
      result TYPE string,
      val_1 TYPE string,
      val_2 TYPE string.

str_1 = '1010'.
str_2 = '011'.

DATA(str_1_len) = strlen( str_1 ).
DATA(str_2_len) = strlen( str_2 ).

WHILE str_1_len NE str_2_len.
 IF str_1_len < str_2_len .
  CONCATENATE '0' str_1 INTO str_1.
  str_1_len = strlen( str_1 ).
 ELSE.
  CONCATENATE '0' str_2 INTO str_2.
  str_2_len = strlen( str_2 ).
 ENDIF.
ENDWHILE.

DATA: sum TYPE n.
DATA: carry TYPE n.
DO str_1_len TIMES.

  val_1 = str_1+str_2_len(0).
  val_2 = str_2+str_2_len(0).

  sum = val_1 + val_2 + carry.
  carry = COND #( WHEN sum MOD 2 EQ 0 THEN 0
                  ELSE 1 ).
  CONCATENATE sum result INTO result.
   str_2_len = str_2_len - 1.

ENDDO.

IF carry EQ 1.
  CONCATENATE carry result INTO result.
ENDIF.
*DATA: no_of_zeroes TYPE i.
*no_of_zeroes = COND #( WHEN str_1_len GT str_2_len THEN ( str_1_len - str_2_len )
*                       WHEN str_2_len GT str_1_len THEN ( str_2_len - str_1_len )
*                       ELSE 0 ).
