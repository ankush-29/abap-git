*&---------------------------------------------------------------------*
*& Report ZANK_P_REMOVE_DUPL_FROM_ARRAY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_remove_dupl_from_array.

*----------------------------------------------------------------------------
*Given a sorted array nums,
*remove the duplicates in-place such that each element appear only once and
*return the new length.
*You must do this by modifying the input array in-place
*----------------------------------------------------------------------------
TYPES:BEGIN OF ty_array,
      value TYPE i,
      END OF ty_array.
TYPES: tty_array TYPE TABLE OF ty_array.
DATA: nums TYPE TABLE OF ty_array.

nums = VALUE #( ( value = 0 ) ( value = 0 ) ( value = 0 )
                ( value = 1 ) ( value = 1 )
                ( value = 2 ) ( value = 2 ) ( value = 2 )
                ( value = 3 ) ( value = 3 ) ( value = 3 ) ).
DATA(new_length) = 0.
PERFORM new_length USING nums CHANGING new_length.
WRITE: new_length.

FORM new_length USING p_nums TYPE tty_array CHANGING p_length TYPE i.
  DESCRIBE TABLE p_nums LINES DATA(array_len).

  IF array_len = 1 .
    p_length = array_len.
    RETURN.
  ENDIF.


 LOOP AT p_nums ASSIGNING FIELD-SYMBOL(<num>).
   IF sy-tabix <> 1.
     IF p_nums[ sy-tabix - 1 ]-value = <num>-value.
       DELETE p_nums INDEX sy-tabix.
       ELSE.
       p_length = p_length + 1.
     ENDIF.
    ELSE.
      p_length = 1.
   ENDIF.

 ENDLOOP.
ENDFORM.
