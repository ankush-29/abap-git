*&---------------------------------------------------------------------*
*& Report ZANK_P_VALID_PALINDROME
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_VALID_PALINDROME.

*====================================================================================================
* Problem statement:
* Given a string,
* determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
*
* Note: For the purpose of this problem, we define empty string as valid palindrome.
*====================================================================================================


PARAMETERS: input TYPE string.

REPLACE ALL OCCURRENCES OF REGEX '[[:punct:]]' IN input WITH ''.
CONDENSE input NO-GAPS.
TRANSLATE input TO LOWER CASE.


DATA(start_pos) = 0.
DATA(end_pos) = strlen( input ) - 1.
DATA(is_palindrome) = abap_false.
WHILE start_pos < end_pos.

  IF input+start_pos(1) NE input+end_pos(1).
    is_palindrome = abap_false.
    EXIT.
   ELSE.
     is_palindrome = abap_true.
     start_pos  = start_pos + 1.
     end_pos = end_pos - 1.
     CONTINUE.

  ENDIF.
ENDWHILE.

DATA(message) = COND #( WHEN is_palindrome EQ abap_true THEN |YES|
                        ELSE |NO| ).

WRITE: message.
