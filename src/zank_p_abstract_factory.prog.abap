*&---------------------------------------------------------------------*
*& Report ZANK_P_ABSTRACT_FACTORY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_abstract_factory.

*&=======================================
* build an application to which allows-
* - users to change the User Interface-
* - from either a dark or a light theme
*&========================================
INTERFACE if_button.
  METHODS: button_text RETURNING VALUE(button_text) TYPE string.
  METHODS: button_size RETURNING VALUE(button_size) TYPE string.
ENDINTERFACE.

INTERFACE if_label.
  METHODS: label_color RETURNING VALUE(label_color) TYPE string.
  METHODS: label_size RETURNING VALUE(label_size) TYPE string.
ENDINTERFACE.

CLASS cl_dark_button DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_button.
ENDCLASS.

CLASS cl_light_button DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_button.
ENDCLASS.

CLASS cl_dark_label DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_label.
ENDCLASS.

CLASS cl_light_label DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_label.
ENDCLASS.

CLASS cl_dark_button IMPLEMENTATION.

  METHOD if_button~button_text.
    button_text = | Dark theme button|.
  ENDMETHOD.
  METHOD if_button~button_size.
    button_size = |Large|.
  ENDMETHOD.

ENDCLASS.

CLASS cl_dark_label IMPLEMENTATION.

  METHOD if_label~label_color.
    label_color = | White|.
  ENDMETHOD.
  METHOD if_label~label_size.
    label_size = |Large|.
  ENDMETHOD.

ENDCLASS.

CLASS cl_light_button IMPLEMENTATION.

  METHOD if_button~button_text.
    button_text = | Light theme button|.
  ENDMETHOD.
  METHOD if_button~button_size.
    button_size = |Small|.
  ENDMETHOD.

ENDCLASS.

CLASS cl_light_label IMPLEMENTATION.

  METHOD if_label~label_color.
    label_color = | Black|.
  ENDMETHOD.
  METHOD if_label~label_size.
    label_size = |Small|.
  ENDMETHOD.

ENDCLASS.

INTERFACE if_theme_factory.
  METHODS: button RETURNING VALUE(o_button) TYPE REF TO if_button.
  METHODS: label RETURNING VALUE(o_label) TYPE REF TO if_label.
ENDINTERFACE.



CLASS cl_dark_theme DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_theme_factory.
ENDCLASS.

CLASS cl_light_theme DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_theme_factory.
ENDCLASS.


CLASS cl_dark_theme IMPLEMENTATION.

  METHOD if_theme_factory~button.
   o_button = NEW cl_dark_button( ).
  ENDMETHOD.

  METHOD if_theme_factory~label.
    o_label = NEW cl_dark_label( ).
  ENDMETHOD.

ENDCLASS.

CLASS cl_light_theme IMPLEMENTATION.


  METHOD if_theme_factory~button.
   o_button = NEW cl_light_button( ).
  ENDMETHOD.

  METHOD if_theme_factory~label.
    o_label = NEW cl_light_label( ).
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

DATA(o_button) = NEW cl_light_theme( )->if_theme_factory~button( ).
WRITE: o_button->button_text( ).
