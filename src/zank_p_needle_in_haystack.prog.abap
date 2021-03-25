*&---------------------------------------------------------------------*
*& Report ZANK_P_NEEDLE_IN_HAYSTACK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_NEEDLE_IN_HAYSTACK.
*Return the index of the first occurrence of needle in haystack,
*or -1 if needle is not part of haystack.

* Index of the string starts from 0

DATA: haystack TYPE string,
      needle TYPE string.

haystack = 'ankush'.
needle = 'us'.
DATA(found_pos) = -1.

PERFORM find_needle USING haystack needle CHANGING found_pos.
WRITE: found_pos.

FORM find_needle USING p_hay TYPE string p_need TYPE string
                 CHANGING p_pos.

  DATA(need_len) = strlen( p_need ).
  DATA(hay_len) = strlen( p_hay ).
  DATA(pos) = 0.

  DO hay_len - need_len TIMES.
    IF p_hay+pos(need_len) = p_need.
      p_pos = COND #( WHEN pos EQ 0 THEN 1
                      ELSE pos ).
      RETURN.
     ELSE.
       pos = pos + 1.
    ENDIF.
  ENDDO.

ENDFORM.
