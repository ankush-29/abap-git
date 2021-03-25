*&---------------------------------------------------------------------*
*& Report ZANK_P_TIME_TO_BUY_AND_SELL_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_TIME_TO_BUY_AND_SELL_2.

*&=================================================================================================
* Say you have an array prices for which the ith element is the price of a given stock on day i.
* Design an algorithm to find the maximum profit.
* You may complete as many transactions as you like -
* - (i.e., buy one and sell one share of the stock multiple times).
* Note: You may not engage in multiple transactions at the same time-
* - (i.e., you must sell the stock before you buy again).
*&=================================================================================================

TYPES:BEGIN OF ty_array,
      value TYPE i,
      END OF ty_array.

DATA: input TYPE TABLE OF ty_array.

input = VALUE #( ( value = 1 )
                 ( value = 2 )
                 ( value = 3 )
                 ( value = 4 )
                 ( value = 5 )
                 ( value = 6 ) ).

* Peak Valley approach.
* Find the difference between all the consecutive valleys and Peaks ( peak - valley )
* Add them

DATA(net_profit) = 0.
LOOP AT input INTO DATA(stock_price).
  DATA(index) = sy-tabix.
  DATA(buying_price) = stock_price-value.

  TRY.
    DATA(selling_price) = input[ index + 1 ]-value.
  CATCH cx_sy_itab_line_not_found.
    EXIT.
  ENDTRY.

  IF ( selling_price GT buying_price ).
    net_profit = net_profit + ( selling_price - buying_price ).
   ELSE.
     CONTINUE.
  ENDIF.
ENDLOOP.

WRITE: | Net Profit is { net_profit } |.
