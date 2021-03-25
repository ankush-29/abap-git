*&---------------------------------------------------------------------*
*& Report ZANK_P_TIME_TO_BUY_AND_SELL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_TIME_TO_BUY_AND_SELL.

*&======================================================================================
* Say you have an array for which the ith element is the price of a given stock on day i.
* If you were only permitted to complete at most one transaction
* - (i.e., buy one and sell one share of the stock),
* design an algorithm to find the maximum profit.
*
* Note that you cannot sell a stock before you buy one
*&=====================================================================================

TYPES:BEGIN OF ty_array,
      value TYPE i,
      END OF ty_array.

DATA: input TYPE TABLE OF ty_array.

input = VALUE #( ( value = 7 )
                 ( value = 1 )
                 ( value = 5 )
                 ( value = 3 )
                 ( value = 6 )
                 ( value = 4 ) ).

DATA(output) = 0. " Expected = 5.


*=====================================
* Solution: 1 --> Using 2 Loops
*=====================================
*LOOP AT input INTO DATA(wa_input).
*
*  DATA(buying_price) = wa_input-value.
*  DATA(index) = sy-tabix.
*  LOOP AT input FROM ( index + 1 ) INTO DATA(wa_compare).
*  TRY.
*    DATA(selling_price) = wa_compare-value.
*  CATCH cx_sy_itab_line_not_found.
*    EXIT.
*  ENDTRY.
*
*  IF buying_price GT selling_price.
*    index = index + 1.
*    CONTINUE.
*   ELSE.
*     DATA(profit) = selling_price - buying_price.
*     output = COND #( WHEN output LT profit THEN profit
*                      ELSE output ).
*     index = index + 1.
*  ENDIF.
*  ENDLOOP.
*
*ENDLOOP.
*
*WRITE: output.

*======================================
* Solution: 2 --> Using 1 Loop
*-=====================================
DATA(net_profit) = 0.
DATA(min_price) = input[ 1 ]-value.
LOOP AT input INTO DATA(stock_price).

  net_profit = nmax( val1 = ( stock_price-value - min_price )
                     val2 = net_profit ).

  min_price =  nmin( val1 = min_price
                     val2 = stock_price-value ).

ENDLOOP.

WRITE: | Max profit is { net_profit } |.
