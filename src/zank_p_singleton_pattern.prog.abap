*&---------------------------------------------------------------------*
*& Report ZANK_P_SINGLETON_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_SINGLETON_PATTERN.

CLASS cl_singleton DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS: get_instance RETURNING VALUE(instance) TYPE REF TO cl_singleton.
    CLASS-METHODS: get_string RETURNING VALUE(str) TYPE string.
    CLASS-DATA: demo_string TYPE string.
  PRIVATE SECTION.
*    METHODS: constructor.
     CLASS-DATA: g_instance TYPE REF TO cl_singleton.

ENDCLASS.

CLASS cl_singleton IMPLEMENTATION.

  METHOD get_instance.
    instance = COND #( WHEN g_instance IS NOT BOUND THEN NEW cl_singleton( )
                       ELSE g_instance ).
  ENDMETHOD.

  METHOD get_string.
   str = demo_string.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

DATA(ins) = cl_singleton=>get_instance( ).
ins->demo_string = |Set by Instance 1|.

DATA(ins_2) = cl_singleton=>get_instance( ).
ins->demo_string = |Set by Instance 2|.

WRITE: ins->get_string( ).
