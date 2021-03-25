*&---------------------------------------------------------------------*
*& Report ZANK_P_FIND_SQUARE_ROOT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_find_square_root.

*&------------------------------------------------------
*& Find squreroot of a given integer
*& the result should be the floor(result) i.e. integer
*&------------------------------------------------------

DATA(input) = 4.
DATA(low) = 2.
DATA: mid TYPE decfloat16.
DATA(sqrt) = 0.
DATA(high) = input.

PERFORM find_sqrt.
WRITE: sqrt.

FORM find_sqrt.
IF input EQ 0 OR input EQ 1.
  sqrt = 1.
ELSE.

 WHILE mid NE input.
 mid = ( low + high ) / 2 .
 mid = floor( mid ).
 IF ( mid * mid ) > input.
   high = mid.
 ELSEIF ( mid * mid ) < input.
   low = mid.
 ELSE.
   sqrt = mid.
   RETURN.
 ENDIF.
 ENDWHILE.

ENDIF.
ENDFORM.
