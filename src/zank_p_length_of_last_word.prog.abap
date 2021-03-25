*&---------------------------------------------------------------------*
*& Report ZANK_P_LENGTH_OF_LAST_WORD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_LENGTH_OF_LAST_WORD.
*&---------------------------------------------------------------------------------------------------------
*Given a string s consists of upper/lower-case alphabets
*and empty space characters ' ',
*return the length of last word (last word means the last appearing word if we loop from left to right)
*in the string.
*
*If the last word does not exist, return 0.
*&---------------------------------------------------------------------------------------------------------
* string+offset(position)
DATA: s TYPE string.
s = |Hellos |.
DATA(length) =  strlen( s ).
DATA(offset) = length - 1.
DATA(position) = 0.
DATA(lw_len) = 0.
IF s+offset(position) EQ | |.
  WRITE: |No last Word|.

ELSE.
  WHILE s+offset(1) NE | |.
    offset = offset - 1.
    lw_len = lw_len + 1.
    IF offset = 0.
      lw_len = lw_len + 1.
      EXIT.
    ENDIF.
  ENDWHILE.
  WRITE: lw_len.
ENDIF.
