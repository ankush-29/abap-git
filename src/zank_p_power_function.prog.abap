*&---------------------------------------------------------------------*
*& Report ZANK_P_POWER_FUNCTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_POWER_FUNCTION.

* result = num^power
CLASS cl_calculate DEFINITION.
  PUBLIC SECTION.
    METHODS: power IMPORTING num type i pow TYPE i
                   RETURNING VALUE(result) TYPE i.

    METHODS: factorial IMPORTING number TYPE i
                       RETURNING VALUE(result) TYPE i.
ENDCLASS.

CLASS cl_calculate IMPLEMENTATION.

  METHOD power.
    IF pow EQ 0.
      result = 1.
      RETURN.
    ENDIF.
    result = num * power( num = num pow = pow - 1 ).
  ENDMETHOD.

  METHOD factorial.

    IF number EQ 0.
      result = 1.
      RETURN.
    ENDIF.
    result = number * factorial( number - 1 ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
DATA(lo_calculate) = NEW cl_calculate( ).
* Calculate factorial

WRITE: lo_calculate->factorial( 0 ).
