*&---------------------------------------------------------------------*
*& Report ZANK_P_DECORATOR_PATTERN_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_DECORATOR_PATTERN_03.

*============================
* Component to be decorated
*============================

CLASS car DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS engine_power ABSTRACT RETURNING VALUE(power) TYPE string.
    METHODS tyre_type ABSTRACT RETURNING VALUE(tyre) TYPE string.
ENDCLASS.

CLASS race_car DEFINITION INHERITING FROM car.

  PUBLIC SECTION.
    METHODS engine_power REDEFINITION.
    METHODS tyre_type REDEFINITION.
ENDCLASS.

CLASS off_road_car DEFINITION INHERITING FROM car.

  PUBLIC SECTION.
    METHODS engine_power REDEFINITION.
    METHODS tyre_type REDEFINITION.
ENDCLASS.

CLASS off_road_car IMPLEMENTATION.

  METHOD engine_power.
    power = |10 bhp|.
    WRITE:/ power.
    NEW-LINE.
  ENDMETHOD.

  METHOD tyre_type.
    tyre = |Off Road tyres|.
    WRITE:/ tyre.
    NEW-LINE.
  ENDMETHOD.
ENDCLASS.

CLASS race_car IMPLEMENTATION.

  METHOD engine_power.
    power = |20 bhp|.
    WRITE:/ power.
    NEW-LINE.
  ENDMETHOD.

  METHOD tyre_type.
    tyre = |Race tyres|.
    WRITE:/ tyre.
    NEW-LINE.
  ENDMETHOD.
ENDCLASS.

*==========================
* Decorators
*==========================

CLASS looks DEFINITION INHERITING FROM car.

  PUBLIC SECTION.
    METHODS engine_power REDEFINITION.
    METHODS tyre_type REDEFINITION.
    METHODS constructor IMPORTING car_type TYPE REF TO car.
  PRIVATE SECTION.
    DATA: o_car TYPE REF TO car.
ENDCLASS.

CLASS looks IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    o_car = car_type.
  ENDMETHOD.

  METHOD engine_power.
    o_car->engine_power( ).
  ENDMETHOD.

  METHOD tyre_type.
    o_car->tyre_type( ).
  ENDMETHOD.
ENDCLASS.

CLASS spoiler DEFINITION INHERITING FROM looks.

  PUBLIC SECTION.
    METHODS add_spoiler.
ENDCLASS.

CLASS spoiler IMPLEMENTATION.

  METHOD add_spoiler.
    WRITE:/ |Spoiler added|.
    NEW-LINE.
  ENDMETHOD.
ENDCLASS.

CLASS ovrm DEFINITION INHERITING FROM looks.
  PUBLIC SECTION.
    METHODS add_ovrm.
ENDCLASS.

CLASS ovrm IMPLEMENTATION.

  METHOD add_ovrm.
    WRITE:/ |OVRM Added|.
    NEW-LINE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

DATA(o_race_car) = NEW race_car( ).
DATA(o_spoiler_rc) = NEW spoiler( car_type = o_race_car ). " Spiler Added Race car


o_spoiler_rc->add_spoiler( ).
o_spoiler_rc->engine_power( ).
o_spoiler_rc->tyre_type( ).
DATA(o_ovrm_off_rc) = NEW ovrm( car_type = NEW off_road_car( ) ). " OVRM Added Off-road car
DATA(ovrm_splr_rc) = NEW ovrm( car_type = NEW spoiler( car_type = o_race_car ) ). " spoiler Added, OVRM Added Race car
