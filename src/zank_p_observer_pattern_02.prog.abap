*&---------------------------------------------------------------------*
*& Report ZANK_P_OBSERVER_PATTERN_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_OBSERVER_PATTERN_02.

*&==========================================================================
* A Weather station monitors temprature, windspeed, pressure.
* A UI, A logger and an alert system are interested in the weather data
* All the subsrcibers should be notified whenever there is a change in
* the weather parameters
*&==========================================================================

INTERFACE if_observer.
  METHODS notification.
ENDINTERFACE.


INTERFACE if_weather_station.
  METHODS add_observer IMPORTING observer TYPE REF TO if_observer.
  METHODS remove_observer IMPORTING observer TYPE REF TO if_observer.
  METHODS notify.
ENDINTERFACE.

CLASS cl_weather_station DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_weather_station.
    METHODS get_temprature RETURNING VALUE(temp) TYPE i.
    METHODS get_pressure RETURNING VALUE(press) TYPE i.
    METHODS monitor_params.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_observer,
           observer TYPE REF TO if_observer,
           END OF ty_observer.

    DATA: observers TYPE TABLE OF ty_observer.
ENDCLASS.

CLASS cl_weather_station IMPLEMENTATION.

  METHOD if_weather_station~add_observer.
*    APPEND observer TO me->observers.
    observers = VALUE #( ( observer = observer ) ).
  ENDMETHOD.

  METHOD if_weather_station~remove_observer.
    DELETE observers WHERE observer = observer.
  ENDMETHOD.

  METHOD if_weather_station~notify.

    LOOP AT observers INTO DATA(observer).
      WRITE: |Data for observer { sy-tabix } |.
      observer-observer->notification( ).
    ENDLOOP.
  ENDMETHOD.
  METHOD get_pressure.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      EXPORTING
        ran_int_max   = 15
        ran_int_min   = 1
      IMPORTING
        ran_int       = press.
  ENDMETHOD.

  METHOD get_temprature.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      EXPORTING
        ran_int_max   = 90
        ran_int_min   = 30
      IMPORTING
        ran_int       = temp.
  ENDMETHOD.

  METHOD monitor_params.
*   act randomly to simulate a change
    DATA(rand) = 0.
 DO 2 TIMES.

    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      EXPORTING
        ran_int_max   = 10
        ran_int_min   = 1
      IMPORTING
        ran_int       = rand.



   IF rand > 7.
     if_weather_station~notify( ).
   ENDIF.
 ENDDO.
   ENDMETHOD.
ENDCLASS.

CLASS cl_ui_observer DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_observer.
    METHODS constructor IMPORTING weather_station TYPE REF TO cl_weather_station.

  PRIVATE SECTION.
    DATA: o_weather_station TYPE REF TO cl_weather_station.
ENDCLASS.

CLASS cl_ui_observer IMPLEMENTATION.

  METHOD constructor.
    WRITE: |UI Observer|.
    NEW-LINE.
    o_weather_station = weather_station.
  endmethod.
  METHOD if_observer~notification.
    WRITE:|===================================================================================|.
    NEW-LINE.
    WRITE: |Weather changed !|.
    NEW-LINE.
    WRITE: |Fethcing current data....|.
    NEW-LINE.
    WRITE: |Current pressure is { o_weather_station->get_pressure( ) } hPa|.
    NEW-LINE.
    WRITE: |Current temprature is { o_weather_station->get_temprature( ) } degree celcius|.
    NEW-LINE.
    WRITE:|===================================================================================|.
  ENDMETHOD.
ENDCLASS.

CLASS cl_alert_system DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_observer.
    METHODS constructor IMPORTING weather_station TYPE REF TO cl_weather_station.

  PRIVATE SECTION.
    DATA: o_weather_station TYPE REF TO cl_weather_station.
ENDCLASS.

CLASS cl_alert_system IMPLEMENTATION.

  METHOD constructor.
    WRITE: |Alert System|.
    NEW-LINE.
    o_weather_station = weather_station.
  endmethod.
  METHOD if_observer~notification.
    WRITE:|===================================================================================|.
    NEW-LINE.
    WRITE: |Weather data changed !|.
    NEW-LINE.
    WRITE: |Fethcing current data....|.
    NEW-LINE.
    WRITE: |Current pressure is { o_weather_station->get_pressure( ) } hPa|.
    NEW-LINE.
    WRITE: |Current temprature is { o_weather_station->get_temprature( ) } degree celcius|.
    NEW-LINE.
    WRITE:|===================================================================================|.
  ENDMETHOD.
ENDCLASS.


*&======================
* Driver Code
*&======================
START-OF-SELECTION.
DATA(o_weather_station) = NEW cl_weather_station( ).

WRITE:|Registring the UI observer...|.
DATA(o_ui_observer) = NEW cl_ui_observer( weather_station = o_weather_station ).
o_weather_station->if_weather_station~add_observer( observer = o_ui_observer ).
NEW-LINE.
*WRITE:|UI Observer registered...|.
*NEW-LINE.
*WRITE:|Fethcing data for 1 observer..|.
*NEW-LINE.
*o_weather_station->monitor_params( ).
*NEW-LINE.
WRITE:|Registring the Alert System...|.
NEW-LINE.
DATA(o_alert_sys) = NEW cl_alert_system( weather_station = o_weather_station ).
o_weather_station->if_weather_station~add_observer( observer = o_alert_sys ).
WRITE:|Fethcing data for 2 observers..|.
NEW-LINE.
o_weather_station->monitor_params( ).
NEW-LINE.
WRITE:|Remove UI Observer|.
NEW-LINE.
o_weather_station->if_weather_station~remove_observer( observer = o_ui_observer ).
NEW-LINE.
WRITE:|Fethcing data for 1 observer..|.
NEW-LINE.
