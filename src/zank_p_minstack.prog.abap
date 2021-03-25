*&---------------------------------------------------------------------*
*& Report ZANK_P_MINSTACK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_minstack.

*&================================================================================================
* Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
*
*        push(x) -- Push element x onto stack.
*        pop() -- Removes the element on top of the stack.
*        top() -- Get the top element.
*        getMin() -- Retrieve the minimum element in the stack.
*&================================================================================================

INTERFACE if_stack.
  METHODS: push IMPORTING element TYPE i
                RETURNING VALUE(new_stack) TYPE REF TO if_stack.

  METHODS: pop EXPORTING element TYPE i
               RETURNING VALUE(new_stack) TYPE REF TO if_stack.

  METHODS: top EXPORTING element TYPE i.

  METHODS: get_min EXPORTING element TYPE i.
ENDINTERFACE.

CLASS cl_stack DEFINITION.

  PUBLIC SECTION.
    INTERFACES if_stack.

  PRIVATE SECTION.
    DATA: stack TYPE int4_table,
          min_element TYPE i.

ENDCLASS.

CLASS cl_stack IMPLEMENTATION.

  METHOD if_stack~push.

    IF stack IS INITIAL.
      min_element = element.
     ELSE.
       min_element = COND #( WHEN element LT min_element THEN element
                             ELSE min_element ).
    ENDIF.

    APPEND element TO me->stack.
    new_stack = me.
  ENDMETHOD.

  METHOD if_stack~pop.
    IF stack IS NOT INITIAL.
      DESCRIBE TABLE stack LINES DATA(last_index).
      DELETE stack INDEX last_index.


      element = stack[ last_index - 1 ].
      min_element = COND #( WHEN element LT min_element THEN element
                            ELSE min_element ).

    ENDIF.
    new_stack = me.
  ENDMETHOD.

  METHOD if_stack~get_min.
    element = min_element.
  ENDMETHOD.

  METHOD if_stack~top.
    IF stack IS NOT INITIAL.
       DESCRIBE TABLE stack LINES DATA(last_index).
       element = stack[ last_index ].
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*===============
* Driver Code
*===============
START-OF-SELECTION.
DATA(stack_1) = NEW cl_stack( ).
stack_1->if_stack~push( element = -2 ).
stack_1->if_stack~push( element = 0 ).
stack_1->if_stack~push( element = -3 ).

stack_1->if_stack~get_min( IMPORTING element = DATA(min_element) ).
WRITE:| Minimum element in the stack is { min_element } |.
NEW-LINE.

stack_1->if_stack~pop( ).

stack_1->if_stack~top( IMPORTING element = DATA(top_element) ).
WRITE:| Top element in the stack is { top_element } |.
NEW-LINE.

stack_1->if_stack~get_min( IMPORTING element = min_element ).
WRITE:| Minimum element in the stack is { min_element } |.
NEW-LINE.
