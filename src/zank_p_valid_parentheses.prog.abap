*&---------------------------------------------------------------------*
*& Report ZANK_P_VALID_PARENTHESES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_valid_parentheses.
*----------------------------------------------------------------------------------
*Given a string containing just the characters '(', ')', '{', '}', '[' and ']',
*determine if the input string is valid.
*
*An input string is valid if:
*
*Open brackets must be closed by the same type of brackets.
*Open brackets must be closed in the correct order.
*Note that an empty string is also considered valid.
*-----------------------------------------------------------------------------------


DATA: input_string  TYPE string.
input_string = '{[]})'.
DATA(is_valid) = abap_false.

PERFORM is_string_valid USING input_string
                        CHANGING is_valid.

WRITE: COND #( WHEN is_valid EQ abap_true THEN |Valid string|
              ELSE |Invalid string| ).


FORM is_string_valid USING p_input TYPE string
                     CHANGING p_is_valid TYPE abap_bool.
DATA(str_len) = strlen( p_input ).
DATA(even) = str_len MOD 2.
IF p_input EQ ''.
  p_is_valid = abap_true.
  RETURN.
 ELSEIF even <> 0.
   p_is_valid = abap_false.
   RETURN.
 ELSE.
   DATA:char_table TYPE TABLE OF string.
   CALL FUNCTION 'SOTR_SERV_STRING_TO_TABLE'
   EXPORTING
     text = p_input
     line_length = 1
     TABLES
       text_tab = char_table.
   DESCRIBE TABLE char_table LINES DATA(length).
   DATA(counter) = 1.
   WHILE counter < length .
     DATA(open) = char_table[ counter ].
     DATA(close) = char_table[ length ].
     CASE open.
       WHEN '('.
         IF close EQ ')'.
           p_is_valid = abap_true.
         ELSE.
           p_is_valid = abap_false.
           RETURN.
         ENDIF.
       WHEN '{'.
         IF close EQ '}'.
           p_is_valid = abap_true.
         ELSE.
           p_is_valid = abap_false.
           RETURN.
         ENDIF.
       WHEN '['.
         IF close EQ ']'.
           p_is_valid = abap_true.
         ELSE.
           p_is_valid = abap_false.
           RETURN.
         ENDIF.
     ENDCASE.

     counter = counter + 1.
     length = length - 1.
   ENDWHILE.
ENDIF.



ENDFORM.
