*&---------------------------------------------------------------------*
*& Report ZANK_P_SEARCHING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_SEARCHING.

INTERFACE if_searching_technique.
    CONSTANTS:
         binary_search TYPE string VALUE 'BINARY_SEARCH'.

    METHODS:
          search IMPORTING in_array TYPE int4_table
                           in_item TYPE int4
                 RETURNING VALUE(index) TYPE i.
ENDINTERFACE.

CLASS cl_binary_search DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_searching_technique.
ENDCLASS.

CLASS cl_binary_search IMPLEMENTATION.

  METHOD if_searching_technique~search.

    DATA(lt_array) = in_array.
    SORT lt_array ASCENDING.
    DATA(low) = 1.
    DATA(high) = lines( in_array ).
    index = -1.
    WHILE low < high.
      DATA(mid) = ( low + high ) / 2.
      IF in_item = lt_array[ mid ].
        index = mid.
        RETURN.
      ELSEIF lt_array[ mid ] > in_item.
        high = mid.
      ELSEIF lt_array[ mid ] < in_item.
        low = mid.
      ENDIF.
    ENDWHILE.

  ENDMETHOD.

ENDCLASS.

CLASS cl_search_provider DEFINITION.
  PUBLIC SECTION.
    METHODS: search IMPORTING in_array TYPE int4_table
                              in_item TYPE int4
                    RETURNING VALUE(index) TYPE i.
    METHODS: constructor IMPORTING search_technique TYPE string.
  PRIVATE SECTION.
    DATA: concrete_search TYPE REF TO if_searching_technique.

ENDCLASS.

CLASS cl_search_provider IMPLEMENTATION.

  METHOD constructor.
    concrete_search = COND #( WHEN search_technique EQ if_searching_technique=>binary_search THEN NEW cl_binary_search( ) ).
  ENDMETHOD.

  METHOD search.
    index = concrete_search->search( in_array = in_array in_item  =  in_item ).
  ENDMETHOD.

ENDCLASS.

*======================
* Driver Code
*======================
START-OF-SELECTION.
DATA: input_array TYPE int4_table.
input_array = VALUE #( ( 1 ) ( 3 ) ( 4 ) ( 5 ) ( 7 ) ( 9 )  ).
DATA(o_search) = NEW cl_search_provider( search_technique = if_searching_technique=>binary_search ).
DATA(found_at) = o_search->search( in_array = input_array in_item  = 9 ).

IF found_at NE -1.
 WRITE:|Element found at index: { found_at }|.
 ELSE.
  WRITE:|Element not found|.
ENDIF.
