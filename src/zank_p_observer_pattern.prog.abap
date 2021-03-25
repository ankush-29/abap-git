*&---------------------------------------------------------------------*
*& Report ZANK_P_OBSERVER_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_observer_pattern.

* Design a notification system where subscribers to a service will get notified
* in case there is a an update in the service.
* Example: facebook 'like' notifications
INTERFACE if_subscribers.
  METHODS: update.
ENDINTERFACE.

INTERFACE if_notification_service.
  METHODS: add IMPORTING sub TYPE REF TO if_subscribers,
           remove IMPORTING sub TYPE REF TO if_subscribers,
           notify.

ENDINTERFACE.

CLASS cl_notification_service DEFINITION.
  PUBLIC SECTION.
   INTERFACES if_notification_service.
   METHODS: read_likes EXPORTING likes TYPE i.

  PRIVATE SECTION.
  TYPES: BEGIN OF ty_subscribers,
         subscriber TYPE REF TO if_subscribers,
        END OF ty_subscribers.

  DATA: subscribers TYPE TABLE OF ty_subscribers.

ENDCLASS.

CLASS cl_notification_service IMPLEMENTATION.

  "Register subscribers
  METHOD if_notification_service~add .
   subscribers = VALUE #( ( subscriber = sub ) ).
  ENDMETHOD.

  "De-register subscribers
  METHOD if_notification_service~remove.
    DELETE subscribers WHERE subscriber = sub.
  ENDMETHOD.

  "Notify subscribers
  METHOD if_notification_service~notify.
    LOOP AT subscribers INTO DATA(observers).
      observers-subscriber->update( ).
    ENDLOOP.
  ENDMETHOD.

  " read number of likes
  METHOD read_likes.
    DATA: rand TYPE i.

    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      EXPORTING
        ran_int_max   = 100
        ran_int_min   = 1
      IMPORTING
        ran_int       = likes.
  ENDMETHOD.

ENDCLASS.

CLASS cl_subscribers DEFINITION.

PUBLIC SECTION.
INTERFACES if_subscribers.
METHODS: constructor IMPORTING service TYPE REF TO cl_notification_service .

PRIVATE SECTION.
  DATA: server TYPE REF TO cl_notification_service.
*  METHODS display_likes.
ENDCLASS.

CLASS cl_subscribers IMPLEMENTATION.

  " keep information about the service.
  METHOD constructor.
    server = service.
  ENDMETHOD.
  "receive updates from service
  METHOD if_subscribers~update.
    server->read_likes(
      IMPORTING
        likes = DATA(likes)
    ).

  WRITE: |Notification Recieved, number of liks are :{ likes } |.
  NEW-LINE.
  ENDMETHOD.

ENDCLASS.

*------------------------------
* Driver Code
*------------------------------
START-OF-SELECTION.

DATA(notification_service) = NEW cl_notification_service( ).
DATA(o_subscriber) = NEW cl_subscribers( notification_service ).

WRITE: |Registring a new subscriber.....|.
notification_service->if_notification_service~add( sub = o_subscriber  ).
NEW-LINE.
NEW-LINE.


" The following code would strictly reside in the notification system/service.
WRITE: |A like recieved, notify the subscribers --->> |.
notification_service->if_notification_service~notify( ).
NEW-LINE.
NEW-LINE.

WRITE:|Number of likes updated, notify the subscribers --->>|.
notification_service->if_notification_service~notify( ).
