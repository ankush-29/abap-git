*&---------------------------------------------------------------------*
*& Report ZANK_P_MAJORITY_ELEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_MAJORITY_ELEMENT.

*&==========================================================================
* Given an array of size n, find the majority element.
* The majority element is the element that appears more than n/2 times.
*&==========================================================================

*Input: [2,2,1,1,1,2,2]
*Output: 2

TYPES: BEGIN OF ty_array,
       value TYPE i,
       END OF ty_array.

DATA: array TYPE TABLE OF ty_array.

array = VALUE #( ( value = 3 ) ( value = 3 ) ( value = 1 )
                 ( value = 1 ) ( value = 3 ) ( value = 2 )
                 ( value = 3 ) ( value = 3 ) ( value = 1 ) ).

DATA(total_count) = lines( array ).
DATA(maj_count) = total_count / 2.
SORT array ASCENDING by value.

* Solution 1
*DATA(counter) = 1.
*LOOP AT array INTO DATA(row) FROM 2.
*  IF row-value = array[ sy-tabix - 1 ]-value.
*    counter = counter + 1.
*    IF counter = maj_count.
*      EXIT.
*      ELSE.
*       CONTINUE.
*    ENDIF.
*   ELSE.
*     counter = 1.
*     CONTINUE.
*  ENDIF.
*ENDLOOP.
*DATA(result) = row-value.

* Solution 2
DATA(result) = array[ maj_count ]-value.

WRITE: |Majority count is { maj_count }|.
NEW-LINE.
WRITE: |Majority element is { result }|.
