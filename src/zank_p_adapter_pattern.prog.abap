*&---------------------------------------------------------------------*
*& Report ZANK_P_ADAPTER_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_ADAPTER_PATTERN.

* Adpater to Adpat different types of TVs

INTERFACE if_tv_interface.
  METHODS: play.
  METHODS: pause.
ENDINTERFACE.

CLASS cl_sony_tv DEFINITION.
  PUBLIC SECTION.
  INTERFACES if_tv_interface.
ENDCLASS.

CLASS cl_sony_tv IMPLEMENTATION.

  METHOD if_tv_interface~play.
    NEW-LINE.
    WRITE: |Playing Sony TV|.
  ENDMETHOD.

  METHOD if_tv_interface~pause.
    NEW-LINE.
    WRITE: |Pause Sony TV|.
  ENDMETHOD.

ENDCLASS.

CLASS cl_lg_tv DEFINITION.
  PUBLIC SECTION.
  INTERFACES if_tv_interface.
ENDCLASS.

CLASS cl_lg_tv IMPLEMENTATION.

  METHOD if_tv_interface~play.
    NEW-LINE.
    WRITE: |Playing LG TV|.
  ENDMETHOD.

  METHOD if_tv_interface~pause.
    NEW-LINE.
    WRITE: |Pause LG TV|.
  ENDMETHOD.

ENDCLASS.

CLASS cl_tv_adapter DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_tv_interface.
    METHODS: constructor IMPORTING tv TYPE REF TO if_tv_interface.
  PRIVATE SECTION.
    DATA: tv TYPE REF TO if_tv_interface.
ENDCLASS.

CLASS cl_tv_adapter IMPLEMENTATION.

  METHOD constructor.
    me->tv = tv.
  ENDMETHOD.
  METHOD if_tv_interface~play.
    tv->play( ).
  ENDMETHOD.

  METHOD if_tv_interface~pause.
    tv->pause( ).
  ENDMETHOD.
ENDCLASS.

*==============
* Driver Code
*==============
START-OF-SELECTION.
DATA(tv_adapter) = NEW cl_tv_adapter( tv = NEW cl_sony_tv( ) ).
tv_adapter->if_tv_interface~play( ).
tv_adapter->if_tv_interface~pause( ).
