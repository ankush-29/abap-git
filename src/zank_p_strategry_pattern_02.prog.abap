*&---------------------------------------------------------------------*
*& Report ZANK_P_STRATEGRY_PATTERN_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_strategry_pattern_02.

INTERFACE if_sharing_technique.
  METHODS share.
ENDINTERFACE.

CLASS cl_share_by_email DEFINITION.
 PUBLIC SECTION.
  INTERFACES if_sharing_technique.
ENDCLASS.

CLASS cl_share_by_text DEFINITION.
 PUBLIC SECTION.
  INTERFACES if_sharing_technique.
ENDCLASS.

CLASS cl_share_by_sm DEFINITION.
 PUBLIC SECTION.
  INTERFACES if_sharing_technique.
ENDCLASS.

CLASS cl_share_by_email IMPLEMENTATION.
  METHOD if_sharing_technique~share.
    WRITE: |Sharing photos via email....|.
  ENDMETHOD.
ENDCLASS.

CLASS cl_share_by_text IMPLEMENTATION.
  METHOD if_sharing_technique~share.
    WRITE: |Sharing photos via text....|.
  ENDMETHOD.
ENDCLASS.

CLASS cl_share_by_sm IMPLEMENTATION.
  METHOD if_sharing_technique~share.
    WRITE: |Sharing photos via social media....|.
  ENDMETHOD.
ENDCLASS.

*&================================
* Component Class / Actual App
*&================================
INTERFACE if_photo_editor.
  METHODS edit.
  METHODS share.
ENDINTERFACE.

CLASS cl_photo_editor DEFINITION.

  PUBLIC SECTION.
    INTERFACES if_photo_editor.
    METHODS: click.
    METHODS: set_sharing_type IMPORTING sharing_type TYPE i.
    CONSTANTS: share_by_email TYPE i VALUE 1.
    CONSTANTS: share_by_text TYPE i VALUE 2.
    CONSTANTS: share_by_sm TYPE i VALUE 3.
  PRIVATE SECTION.
    DATA: share_behavior TYPE REF TO if_sharing_technique.
ENDCLASS.

CLASS cl_photo_editor IMPLEMENTATION.

  METHOD set_sharing_type.
    share_behavior = COND #( WHEN sharing_type = cl_photo_editor=>share_by_email THEN NEW cl_share_by_email( )
                             WHEN sharing_type = cl_photo_editor=>share_by_text THEN NEW cl_share_by_text( )
                             WHEN sharing_type = cl_photo_editor=>share_by_sm THEN NEW cl_share_by_sm( ) ).
  ENDMETHOD.
  METHOD click.
    WRITE: |Clicking a photo...|.
  ENDMETHOD.

  METHOD if_photo_editor~edit.
    WRITE: |Editing the photos....|.
  ENDMETHOD.

  METHOD if_photo_editor~share.
    share_behavior->share( ).
  ENDMETHOD.
ENDCLASS.

*&======================
* Client / Driver Code
*&======================
START-OF-SELECTION.
DATA(o_photo_editor) = NEW cl_photo_editor( ).
o_photo_editor->set_sharing_type( sharing_type = cl_photo_editor=>share_by_email ).
o_photo_editor->if_photo_editor~share( ).
NEW-LINE.
WRITE:|Changing the sharing type.....|.
NEW-LINE.
o_photo_editor->set_sharing_type( sharing_type = cl_photo_editor=>share_by_sm ).
NEW-LINE.
o_photo_editor->if_photo_editor~share( ).
