*&---------------------------------------------------------------------*
*& Report ZANK_P_FACTORY_METHOD_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_FACTORY_METHOD_PATTERN.

*&==============================================================
* Scenario : Based on the travel type ( Flight/Bus/Train)
* get the total seats available
* ==============================================================

*&============
*& Product
*&============
INTERFACE modes_of_travel.
  METHODS get_no_of_seats RETURNING VALUE(seats) TYPE i.
ENDINTERFACE.

*&===================
*& Concrete Products
*&===================

* Flight
CLASS flight DEFINITION.
  PUBLIC SECTION.
    INTERFACES modes_of_travel.
ENDCLASS.

* Train
CLASS train DEFINITION.
  PUBLIC SECTION.
    INTERFACES modes_of_travel.
ENDCLASS.

* Bus
CLASS bus DEFINITION.
  PUBLIC SECTION.
    INTERFACES modes_of_travel.
ENDCLASS.

CLASS flight IMPLEMENTATION.
  METHOD modes_of_travel~get_no_of_seats.
    seats = 180.
  ENDMETHOD.
ENDCLASS.

CLASS train IMPLEMENTATION.
  METHOD modes_of_travel~get_no_of_seats.
    seats = 1000.
  ENDMETHOD.
ENDCLASS.

CLASS bus IMPLEMENTATION.
  METHOD modes_of_travel~get_no_of_seats.
    seats = 52.
  ENDMETHOD.
ENDCLASS.

*&===========================
*& Creator Factory
*&===========================
INTERFACE modes_of_travel_factory.
  METHODS travel_type IMPORTING travel_type TYPE i RETURNING VALUE(o_travel_type) TYPE REF TO modes_of_travel.
ENDINTERFACE.

*&===========================
*& Concrete Factories
*&===========================

* Travel Factory
CLASS travel_factory DEFINITION.
  PUBLIC SECTION.
  INTERFACES modes_of_travel_factory.
ENDCLASS.


CLASS travel_factory IMPLEMENTATION.
  METHOD modes_of_travel_factory~travel_type.

    CASE travel_type.
      WHEN 1.
        o_travel_type = NEW flight( ).
      WHEN 2.
        o_travel_type = NEW train( ).
      WHEN 3.
        o_travel_type = NEW bus( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.

*&==================================
*& Driver Code
*&==================================
START-OF-SELECTION.

* Client intansiates the factory
DATA(o_travel_factory) = NEW travel_factory( ).

* Client gets the appropriate Object of the travel mode
DATA(flight) = o_travel_factory->modes_of_travel_factory~travel_type( travel_type = 1 ).

WRITE: flight->get_no_of_seats( ).
