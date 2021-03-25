*&---------------------------------------------------------------------*
*& Report ZANK_P_DECORATOR_PATTERN_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_decorator_pattern_04.

*&=======================================================
* Decorate Thin and Thick crust pizzas with toppins
* Return description and cost
* Base cost --> Thin crust = 20 , Thick crust = 15
*&=======================================================

CLASS cl_pizza DEFINITION ABSTRACT.
  PUBLIC SECTION.
  METHODS get_desc ABSTRACT RETURNING VALUE(desc) TYPE string .
  METHODS get_cost ABSTRACT RETURNING VALUE(cost) TYPE i.
ENDCLASS.

" Thin crust pizza
CLASS cl_thin_crust_pizza DEFINITION INHERITING FROM cl_pizza.
  PUBLIC SECTION.
    METHODS get_desc REDEFINITION.
    METHODS get_cost REDEFINITION.
ENDCLASS.

CLASS cl_thin_crust_pizza IMPLEMENTATION.
 METHOD get_desc.
   desc = |thin crust pizza|.
 ENDMETHOD.

 METHOD get_cost.
   cost = 20.
 ENDMETHOD.
ENDCLASS.

" Thick crust pizza
CLASS cl_thick_crust_pizza DEFINITION INHERITING FROM cl_pizza.
  PUBLIC SECTION.
    METHODS get_desc REDEFINITION.
    METHODS get_cost REDEFINITION.
ENDCLASS.

CLASS cl_thick_crust_pizza IMPLEMENTATION.
 METHOD get_desc.
   desc = |thick crust pizza|.
 ENDMETHOD.

 METHOD get_cost.
   cost = 15.
 ENDMETHOD.
ENDCLASS.

*&=======================
* Decorations / toppings
*&=======================
*INTERFACE if_toppings.
*  METHODS topping_desc RETURNING VALUE(top_desc) TYPE string.
*  METHODS topping_cost RETURNING VALUE(top_cost) TYPE string.
*ENDINTERFACE.

CLASS cl_cheese DEFINITION INHERITING FROM cl_pizza.
 PUBLIC SECTION.
  METHODS constructor IMPORTING o_pizza TYPE REF TO cl_pizza.
  METHODS get_desc REDEFINITION.
  METHODS get_cost REDEFINITION.
 PRIVATE SECTION.
  DATA: pizza TYPE REF TO cl_pizza.

ENDCLASS.

" Cheese topping
CLASS cl_cheese IMPLEMENTATION.
 METHOD constructor.
   super->constructor( ).
   pizza = o_pizza.
 ENDMETHOD.
 METHOD get_desc.
   desc = |Cheese { pizza->get_desc( ) } |.
 ENDMETHOD.

 METHOD get_cost.
   cost = 5 + pizza->get_cost( ).
 ENDMETHOD.


ENDCLASS.

" olives topping
CLASS cl_olives DEFINITION INHERITING FROM cl_pizza.
 PUBLIC SECTION.
  METHODS constructor IMPORTING o_pizza TYPE REF TO cl_pizza.
    METHODS get_desc REDEFINITION.
  METHODS get_cost REDEFINITION.
 PRIVATE SECTION.
  DATA: pizza TYPE REF TO cl_pizza.
ENDCLASS.

CLASS cl_olives IMPLEMENTATION.
 METHOD constructor.
   super->constructor( ).
   pizza = o_pizza.
 ENDMETHOD.
 METHOD get_desc.
   desc = |Olives { pizza->get_desc( ) } |.
 ENDMETHOD.

 METHOD get_cost.
   cost = 3 + pizza->get_cost( ).
 ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
DATA(o_thin_pizza) = NEW cl_olives( o_pizza = NEW cl_cheese( o_pizza = NEW cl_thin_crust_pizza( ) ) ).
WRITE: o_thin_pizza->get_desc( ).
WRITE: |Total cost: { o_thin_pizza->get_cost( ) } |.

NEW-LINE.
DATA(o_thick_pizza) = NEW cl_cheese( o_pizza = NEW cl_thick_crust_pizza( ) ).
WRITE: o_thick_pizza->get_desc( ).
WRITE: |Total cost: { o_thick_pizza->get_cost( ) } |.
