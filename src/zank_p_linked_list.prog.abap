*&---------------------------------------------------------------------*
*& Report ZANK_P_LINKED_LIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_linked_list.

* Singly linked list Implementation

CLASS cl_node DEFINITION.
  PUBLIC SECTION.
    DATA: value TYPE i,
          next TYPE REF TO cl_node.
    METHODS: constructor IMPORTING node_value TYPE i.
ENDCLASS.

CLASS cl_node IMPLEMENTATION.
  METHOD constructor.
    value = node_value.
  ENDMETHOD.
ENDCLASS.

CLASS cl_list DEFINITION.
  PUBLIC SECTION.
    DATA: head_node TYPE REF TO cl_node.
    DATA: tail_node TYPE REF TO cl_node.
    DATA: loop_node TYPE REF TO cl_node. " Just to create the loop. No other use

*    List operations

    "Adds new element at the end of the list
    METHODS: add IMPORTING element TYPE i.

    "Removes given element from the list
    METHODS: remove IMPORTING element TYPE i.

    "Deletes the duplicates from the sorted list
    METHODS: delete_duplicates IMPORTING is_sorted TYPE abap_bool.

    "Returns true if list has a cycle
    METHODS: is_cyclic RETURNING VALUE(is_cyclic) TYPE abap_bool.

    "Returns the size of a linked list
    METHODS: get_size IMPORTING node TYPE REF TO cl_node RETURNING VALUE(size) TYPE i.

    "Returns the middle of the Linked list
    METHODS: find_middle RETURNING VALUE(middle) TYPE i.

    "Prints the current list
    METHODS: print_list.

    "Adds 2 given linked lists and returns a new list
    METHODS: add_lists IMPORTING list1 TYPE REF TO cl_list
                                 list2 TYPE REF TO cl_list
                       EXPORTING list3 TYPE REF TO cl_list.

    "Sorts the given linked list
    METHODS: sort IMPORTING list TYPE REF TO cl_list
                  EXPORTING sorted_list TYPE REF TO cl_list.

    "Reverses the current linked list and exports a new reversed list
    METHODS: reverse EXPORTING reversed_list TYPE REF TO cl_list.
ENDCLASS.

CLASS cl_list IMPLEMENTATION.

  METHOD add.
    DATA(o_node) = NEW cl_node( node_value = element ).

    IF head_node IS NOT BOUND AND tail_node IS NOT BOUND.
      head_node = tail_node = o_node.
    ELSE.
       tail_node->next = o_node.
       tail_node = o_node.

      " Just to create a loop
*       IF o_node->value = 3.
*         loop_node = o_node.
*       ENDIF.
*       IF o_node->value = 15.
*         tail_node->next = loop_node.
*       ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD remove.

  ENDMETHOD.


  METHOD delete_duplicates.
* For sorted list
   IF is_sorted EQ abap_false.
    DATA: start_pointer TYPE REF TO cl_node.
    DATA: end_pointer TYPE REF TO cl_node.
    end_pointer = head_node->next.
    start_pointer = head_node.

    WHILE end_pointer IS BOUND.
      IF start_pointer->value EQ end_pointer->value.
          start_pointer->next = end_pointer->next.
          start_pointer = end_pointer->next.
          end_pointer = start_pointer->next.
       ELSE.
         start_pointer = end_pointer.
         end_pointer = start_pointer->next.
      ENDIF.
    ENDWHILE.
* For Un-sorted list
   ELSE.

*   2 Loops method
    DATA(first_pointer) = head_node.
    DATA(second_pointer) = head_node->next.
    DATA:prev_node TYPE REF TO cl_node.

    WHILE first_pointer IS BOUND.
    second_pointer = first_pointer->next.
    WHILE second_pointer IS BOUND.
      IF first_pointer->value EQ second_pointer->value.
        prev_node->next = second_pointer->next.
       ELSE.
        prev_node = second_pointer.
      ENDIF.
      second_pointer = second_pointer->next.
    ENDWHILE.
    first_pointer = first_pointer->next.

  ENDWHILE.

   ENDIF.
  ENDMETHOD.

  METHOD find_middle.
*    Using 2 pointer ( slow-fast ) approach
    DATA(slow) = head_node.
    DATA(fast) = head_node.

    WHILE fast IS BOUND AND fast->next IS BOUND .
      fast = fast->next->next.
      slow = slow->next.
    ENDWHILE.
    middle = slow->value.
  ENDMETHOD.

  METHOD print_list.
   DATA(current) = head_node.

    WHILE current IS BOUND.
      WRITE: |{ current->value } |.
      current = current->next.
    ENDWHILE.

  ENDMETHOD.

  METHOD get_size.
**  Iterative approach
*   size = 0.
*   DATA(pointer) = list->head_node.
*   WHILE pointer IS BOUND.
*     size = size + 1.
*     pointer = pointer->next.
*   ENDWHILE.

* Using recursion
    DATA(current) = node.
    IF current IS NOT BOUND.
      RETURN.
    ENDIF.
    size = 1 + get_size( current->next ).

  ENDMETHOD.

  METHOD sort.

  ENDMETHOD.

  METHOD add_lists.

  ENDMETHOD.

  METHOD is_cyclic.
    "Using Flyod's cycle finding Algorithm ( Assuming we do not have the tail variable )
    "Move slow = 1 step and fast = 2 steps. If pointers meet, then true
   DATA(slow) = head_node.
   DATA(fast) = head_node.
   is_cyclic = abap_false.
   WHILE fast IS BOUND AND fast->next IS BOUND.
     slow = slow->next.
     fast = fast->next->next.
     IF slow->value EQ fast->value.
       is_cyclic = abap_true.
       RETURN.
     ENDIF.

   ENDWHILE.
  ENDMETHOD.

  METHOD reverse.
    DATA(current) = head_node.
    DATA(following) = head_node.
    DATA: previous TYPE REF TO cl_node.

    WHILE current IS BOUND.
      following = following->next.
      current->next = previous.
      previous = current.
      current = following.
    ENDWHILE.
    head_node = previous.
  ENDMETHOD.


ENDCLASS.


START-OF-SELECTION.
DATA(list_1) = NEW cl_list( ).
DATA(list_2) = NEW cl_list( ).

** Add new elements to the list
*list_1->add( element = 1 ).
*list_1->add( element = 2 ).
*list_1->add( element = 3 ). "Loop to here
*list_1->add( element = 5 ).
*list_1->add( element = 9 ).
*list_1->add( element = 11 ).
*list_1->add( element = 15 ). "Loop from here
*
**WRITE:|===== List 1 =====|.
**NEW-LINE.
**list_1->print_list( ).
**NEW-LINE.

list_2->add( element = 3 ).
list_2->add( element = 7 ).
list_2->add( element = 5 ).
list_2->add( element = 3 ).
list_2->add( element = 6 ).


WRITE: | List Size { list_2->get_size( node = list_2->head_node ) } |.
NEW-LINE.
list_2->print_list( ).
NEW-LINE.
list_2->delete_duplicates( is_sorted = abap_false ).
NEW-LINE.
list_2->print_list( ).
NEW-LINE.
*WRITE:|===== List 2 =====|.
*NEW-LINE.
*list_2->print_list( ).
*NEW-LINE.
*
*WRITE:|===== New Added List =====|.
*NEW-LINE.

* Find middle element of the linked list
*WRITE:|===== Middle Element ====|.
*NEW-LINE.
*WRITE: list_1->find_middle( ).
*NEW-LINE.

* Delete the duplicate nodes from the sorted list
*list_1->delete_duplicates( ).
*WRITE:|===== After removing duplicates =====|.
*NEW-LINE.
*list_1->print_list( ).
*NEW-LINE.

* Reverse the current list
list_2->reverse( ).
BREAK-POINT.

 " Stack
*    o_node->next = head_node.
*    head_node = o_node.
