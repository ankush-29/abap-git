*&---------------------------------------------------------------------*
*& Report ZANK_P_DECORATOR_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_decorator_pattern.

*==========================================
* Component 'to be decorated'
*==========================================
CLASS base_pizza DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: cost ABSTRACT RETURNING VALUE(base_cost) TYPE i.
    METHODS: name ABSTRACT RETURNING VALUE(base_name) TYPE string.
ENDCLASS.


CLASS pizza DEFINITION INHERITING FROM base_pizza.
  PUBLIC SECTION.
*  METHODS: constructor.
  METHODS: cost REDEFINITION.
  METHODS: name REDEFINITION.

ENDCLASS.

CLASS pizza IMPLEMENTATION.
*  METHOD constructor.
*    super->constructor( ).
*  ENDMETHOD.

  METHOD cost.
    base_cost = 10.
  ENDMETHOD.

  METHOD name.
    base_name = |Marghreta Pizza|.
  ENDMETHOD.

ENDCLASS.



*=====================
* Decorator
*=====================
CLASS decorator DEFINITION INHERITING FROM base_pizza.
  PUBLIC SECTION.

  METHODS: cost REDEFINITION.
  METHODS: name REDEFINITION.
  METHODS: constructor IMPORTING pizza TYPE REF TO base_pizza.
  PRIVATE SECTION.
    DATA: base_pizza TYPE REF TO base_pizza.
ENDCLASS.

CLASS decorator IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    base_pizza = pizza.
  ENDMETHOD.

  METHOD cost.
   base_cost = base_pizza->cost( ).
  ENDMETHOD.

  METHOD name.
    base_name = base_pizza->name( ).
  ENDMETHOD.
ENDCLASS.
*==============================
* Concrete decorations
*==============================

*============
* Mushroom
*============
CLASS mushroom DEFINITION INHERITING FROM decorator.
  PUBLIC SECTION.

  METHODS: cost REDEFINITION .
  METHODS: name REDEFINITION.

ENDCLASS.

CLASS mushroom IMPLEMENTATION.

  METHOD cost.
    DATA(final_cost) = super->cost( ) + 3.
  ENDMETHOD.

  METHOD name.
  WRITE: | Mushroom topped { super->name( ) } |.
  ENDMETHOD.

ENDCLASS.


*============
* Olive
*============
CLASS olive DEFINITION INHERITING FROM decorator.
  PUBLIC SECTION.

  METHODS: cost REDEFINITION .
  METHODS: name REDEFINITION.

ENDCLASS.

CLASS olive IMPLEMENTATION.

  METHOD cost.
    DATA(final_cost) = super->cost( ) + 3.
  ENDMETHOD.

  METHOD name.
   WRITE: / | Olives topped { super->name( ) } |.
  ENDMETHOD.

ENDCLASS.


*============
* Tomato
*============

CLASS tomato DEFINITION INHERITING FROM decorator.
  PUBLIC SECTION.

  METHODS: cost REDEFINITION .
  METHODS: name REDEFINITION.

ENDCLASS.

CLASS tomato IMPLEMENTATION.

  METHOD cost.
    DATA(final_cost) = super->cost( ) + 3.
  ENDMETHOD.

  METHOD name.
   WRITE: / | Tomatos topped { super->name( ) } |.
  ENDMETHOD.

ENDCLASS.


*==================
* Driver Code
*==================

START-OF-SELECTION.

DATA(o_mushroom) = NEW mushroom( NEW tomato( NEW pizza( ) ) ).
o_mushroom->name( ).
