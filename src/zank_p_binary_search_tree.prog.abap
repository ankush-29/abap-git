*&---------------------------------------------------------------------*
*& Report ZANK_P_BINARY_SEARCH_TREE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_binary_search_tree.

CLASS cl_leaf DEFINITION.
  PUBLIC SECTION.
    DATA: value TYPE i,
          left TYPE REF TO cl_leaf,
          right TYPE REF TO cl_leaf.
    METHODS: constructor IMPORTING leaf_value TYPE i.
ENDCLASS.

CLASS cl_leaf IMPLEMENTATION.
  METHOD constructor.
    value = leaf_value.
  ENDMETHOD.
ENDCLASS.

CLASS cl_bst DEFINITION.
  PUBLIC SECTION.
    DATA: root_node TYPE REF TO cl_leaf.
    CLASS-DATA: pointer TYPE REF TO cl_leaf. " to travese the tree

*   Tree operations
    METHODS: add IMPORTING node TYPE REF TO cl_leaf
                           direction TYPE c OPTIONAL.

ENDCLASS.

CLASS cl_bst IMPLEMENTATION.

  METHOD add.
    IF root_node IS NOT BOUND.
      root_node = node.
      pointer = root_node.
      RETURN.
    ENDIF.

    IF direction EQ 'L'.
*      pointer = root_node->left.
      IF pointer IS NOT BOUND.
        pointer = root_node->left.
        pointer = node.
        root_node->left = pointer.
      ELSE.
        pointer = pointer->left.
        add( EXPORTING node = node direction = 'L' ).
      ENDIF.

      RETURN.
    ENDIF.

    IF direction EQ 'R'.
*
      IF pointer IS NOT BOUND.
         pointer = root_node->right.
        pointer = node.
        root_node->right = pointer.
      ELSE.
        pointer = pointer->right.
        add( EXPORTING node = node direction = 'R' ).
      ENDIF.

      RETURN.
    ENDIF.

    IF node->value < root_node->value. "Add to the left
      add( EXPORTING node = node direction = 'L' ).
    ELSEIF node->value > root_node->value. "Add to the right
      add( EXPORTING node = node direction = 'R' ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

DATA(new_tree) = NEW cl_bst( ).
new_tree->add( EXPORTING node = NEW cl_leaf( 3 ) ).
new_tree->add( EXPORTING node = NEW cl_leaf( 5 ) ).
new_tree->add( EXPORTING node = NEW cl_leaf( 2 ) ).
new_tree->add( EXPORTING node = NEW cl_leaf( 10 ) ).
BREAK-POINT.
