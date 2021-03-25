*&---------------------------------------------------------------------*
*& Report ZANK_P_REMOVE_ELEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_REMOVE_ELEMENT.

TYPES: BEGIN OF ty_array,
       value TYPE i,
      END OF ty_array.

TYPES: tt_array TYPE TABLE OF ty_array.

DATA: nums TYPE TABLE OF ty_array.

nums = VALUE #( ( value = 2 ) ( value = 3 ) ( value = 3 ) ( value = 2 ) ( value = 5 ) ).
DESCRIBE TABLE nums LINES DATA(length).
DATA(value) = 5.

PERFORM remove_element USING nums value CHANGING length.
WRITE: length.

FORM remove_element USING p_nums TYPE tt_array p_val TYPE i CHANGING p_len TYPE i.

*---------------------
* solution 1
*---------------------
  LOOP AT p_nums INTO DATA(num).
    IF num-value = p_val.
      DELETE nums INDEX sy-tabix.
    ENDIF.
  ENDLOOP.
  DESCRIBE TABLE p_nums LINES p_len.

*--------------------
* solution 2
*--------------------


ENDFORM.
