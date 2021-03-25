*&---------------------------------------------------------------------*
*& Report ZANK_P_DECORATOR_PATTERN_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_DECORATOR_PATTERN_02.

*=====================
*& Component Class
*=====================

CLASS icecream DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: name ABSTRACT RETURNING VALUE(base_name) TYPE string.
    METHODS: cost ABSTRACT RETURNING VALUE(base_cost) TYPE string.
ENDCLASS.

*========================
*& Concrere Components
*========================
CLASS vanilla_icecream DEFINITION INHERITING FROM icecream.

  PUBLIC SECTION.
  METHODS name REDEFINITION.
  METHODS cost REDEFINITION.
ENDCLASS.

CLASS vanilla_icecream IMPLEMENTATION.

  METHOD cost.
    base_cost = 10.
  ENDMETHOD.

  METHOD name.
    base_name = |Vanilla|.
  ENDMETHOD.

ENDCLASS.

CLASS chocolate_icecream DEFINITION INHERITING FROM icecream.

  PUBLIC SECTION.
  METHODS name REDEFINITION.
  METHODS cost REDEFINITION.

ENDCLASS.

CLASS chocolate_icecream IMPLEMENTATION.

  METHOD cost.
    base_cost = 12.
  ENDMETHOD.

  METHOD name.
    base_name = |Chocolate|.
  ENDMETHOD.

ENDCLASS.

*==================
*& Decorator
*==================

CLASS topping DEFINITION INHERITING FROM icecream.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ice_type TYPE REF TO icecream.
    METHODS name REDEFINITION.
    METHODS cost REDEFINITION.

  PRIVATE SECTION.
    DATA: icecream_type TYPE REF TO icecream.

ENDCLASS.

CLASS topping IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    icecream_type = ice_type.
  ENDMETHOD.

  METHOD name.
    base_name = icecream_type->name( ).
  ENDMETHOD.

  METHOD cost.
    base_cost = icecream_type->cost( ).
  ENDMETHOD.
ENDCLASS.

*========================
*& Concrete Decorations
*========================

CLASS nuts DEFINITION INHERITING FROM topping.

  PUBLIC SECTION.
    METHODS name REDEFINITION.
    METHODS cost REDEFINITION.
*    METHODS topping_price.
ENDCLASS.

CLASS nuts IMPLEMENTATION.

  METHOD name.
    DATA(basic_name) = super->name( ).
    base_name = |Nuts topped { basic_name }|.
*    WRITE: base_name.
    NEW-LINE.
  ENDMETHOD.

  METHOD cost.
    DATA(basic_cost) = super->cost( ).
    base_cost = 2 + basic_cost.
    WRITE: base_cost.
  ENDMETHOD.
ENDCLASS.


CLASS syrups DEFINITION INHERITING FROM topping.

  PUBLIC SECTION.
    METHODS name REDEFINITION.
    METHODS cost REDEFINITION.

ENDCLASS.

CLASS syrups IMPLEMENTATION.

  METHOD name.
    DATA(basic_name) = super->name( ).
    base_name = |Syrup topped { basic_name }|.
*    WRITE: base_name.
*    NEW-LINE.
  ENDMETHOD.

  METHOD cost.
    DATA(basic_cost) = super->cost( ).
    base_cost = 2 + basic_cost.
    WRITE: base_cost.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
DATA(final_icecream) = NEW nuts( ice_type = NEW vanilla_icecream( ) ).

DATA(final_2) = NEW syrups( ice_type = NEW nuts( ice_type = new chocolate_icecream( ) ) ).

*final_icecream->cost( )..
*final_icecream->name( ).

*final_2->cost( ).
DATA(final_name) = final_2->name( ).
WRITE: final_name.
