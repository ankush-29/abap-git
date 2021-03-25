*&---------------------------------------------------------------------*
*& Report ZANK_P_SORTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_SORTING.

*=======================================
* Different sorting techniques
*=======================================

INTERFACE if_sorting_technique.
    CONSTANTS: bubble_sort TYPE string VALUE 'BUBBLE_SORT'.
    CONSTANTS: merge_sort TYPE string VALUE 'MERGE_SORT'.
    CONSTANTS: quick_sort TYPE string VALUE 'QUICK_SORT'.

    METHODS: sort IMPORTING array TYPE int4_table
                  EXPORTING out_array TYPE int4_table.

*    METHODS: print IMPORTING array TYPE int4_table.
ENDINTERFACE.

CLASS cl_bubble_sort DEFINITION.
 PUBLIC SECTION.
  INTERFACES if_sorting_technique.
ENDCLASS.

CLASS cl_merge_sort DEFINITION.
 PUBLIC SECTION.
  INTERFACES if_sorting_technique.
ENDCLASS.

CLASS cl_quick_sort DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_sorting_technique.
ENDCLASS.

CLASS cl_bubble_sort IMPLEMENTATION.
  METHOD if_sorting_technique~sort.

    DATA(iteration) = lines( array ) - 1.
    DATA(lt_array) = array.
    DO iteration TIMES.

    LOOP AT lt_array ASSIGNING FIELD-SYMBOL(<fs_row>) FROM 2.
      IF lt_array[ sy-tabix ] LT lt_array[ sy-tabix - 1 ] .
        DATA(temp) = lt_array[ sy-tabix ].
        lt_array[ sy-tabix ] = lt_array[ sy-tabix - 1 ].
        lt_array[ sy-tabix - 1 ] = temp.
      ENDIF.
    ENDLOOP.
    ENDDO.
    out_array = lt_array.
  ENDMETHOD.

ENDCLASS.

CLASS cl_merge_sort IMPLEMENTATION.

  METHOD if_sorting_technique~sort.

    DATA: left_array TYPE int4_table.
    DATA: right_array TYPE int4_table.

    CHECK lines( array ) > 1.
      DATA(mid) = ( lines( array ) ) / 2.

*     build left array
      INSERT LINES OF array FROM 1 TO mid INTO TABLE left_array.

*     build right array
      INSERT LINES OF array FROM ( mid + 1 ) TO lines( array ) INTO TABLE right_array.

*     Merge sort left and right arrays
      me->if_sorting_technique~sort( left_array ).
      me->if_sorting_technique~sort( right_array ).

*     Merge the 2 arrays into a new array
      DATA(left_index) = 1.
      DATA(right_index) = 1.
      DATA(new_index) = 1.

      WHILE left_index < lines( left_array ) AND right_index < lines( right_array ).
        APPEND INITIAL LINE TO out_array.
        IF left_array[ left_index ] >= right_array[ right_index ].
          out_array[ new_index ] = right_array[ right_index ].
          right_index = right_index + 1.
        ELSE.
          out_array[ new_index ] = left_array[ left_index ].
          left_index = left_index + 1.
        ENDIF.
        new_index = new_index + 1.
      ENDWHILE.

      WHILE left_index < lines( left_array ).
        APPEND INITIAL LINE TO out_array.
        out_array[ new_index ] = left_array[ left_index ].
        new_index = new_index + 1.
        left_index = left_index + 1.
      ENDWHILE.

      WHILE right_index < lines( right_array ).
        APPEND INITIAL LINE TO out_array.
        out_array[ new_index ] = right_array[ right_index ].
        new_index = new_index + 1.
        left_index = left_index + 1.
      ENDWHILE.

  ENDMETHOD.

ENDCLASS.

CLASS cl_quick_sort IMPLEMENTATION.

  METHOD if_sorting_technique~sort.


  ENDMETHOD.

ENDCLASS.
*=====================
* Sorting provider
*=====================
CLASS cl_sorter DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING sorting_tech TYPE string.
    METHODS: sort IMPORTING array TYPE int4_table
                  EXPORTING out_array TYPE int4_table.
    METHODS: print IMPORTING array TYPE int4_table.
  PRIVATE SECTION.
    DATA: sorter TYPE REF TO if_sorting_technique.

ENDCLASS.

CLASS cl_sorter IMPLEMENTATION.

  METHOD constructor.
    sorter = COND #( WHEN sorting_tech EQ if_sorting_technique=>bubble_sort THEN NEW cl_bubble_sort( )
                     WHEN sorting_tech EQ if_sorting_technique=>merge_sort THEN NEW cl_merge_sort( ) ).
  ENDMETHOD.

  METHOD sort.
    sorter->sort( EXPORTING array = array
                  IMPORTING out_array = out_array ).
  ENDMETHOD.

  METHOD print.
    LOOP AT array INTO DATA(element).
      WRITE: |{ element } |.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

*=========================
* Driver Code to test
*=========================
START-OF-SELECTION.
DATA: input_array TYPE int4_table.
input_array = VALUE #( ( 3 ) ( 7 ) ( 1 )  ).
DATA(o_sorter) = NEW cl_sorter( sorting_tech = if_sorting_technique=>bubble_sort ).
o_sorter->sort( EXPORTING array = input_array
                IMPORTING out_array = DATA(sorted_array)  ).
o_sorter->print( array = sorted_array ).
