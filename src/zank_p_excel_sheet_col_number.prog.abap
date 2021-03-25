*&---------------------------------------------------------------------*
*& Report ZANK_P_EXCEL_SHEET_COL_NUMBER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZANK_P_EXCEL_SHEET_COL_NUMBER.

PARAMETERS: input TYPE string.
TYPES:BEGIN OF ty_map,
      key TYPE i,
      val TYPE string,
      END OF ty_map.

DATA: map TYPE TABLE OF ty_map.
DATA: column TYPE string.
map = VALUE #( ( key = 1 val = 'A') ( key = 2 val = 'B') ( key = 3 val = 'C') ( key = 4 val = 'D') ( key = 5 val = 'E')
               ( key = 6 val = 'F') ( key = 7 val = 'G') ( key = 8 val = 'H') ( key = 9 val = 'I') ( key = 10 val = 'J')
               ( key = 11 val = 'K') ( key = 12 val = 'L') ( key = 13 val = 'M') ( key = 14 val = 'N') ( key = 15 val = 'O')
               ( key = 16 val = 'P') ( key = 17 val = 'Q') ( key = 18 val = 'R') ( key = 19 val = 'S') ( key = 20 val = 'T')
               ( key = 21 val = 'U') ( key = 22 val = 'V') ( key = 23 val = 'W') ( key = 24 val = 'X') ( key = 25 val = 'Y')
               ( key = 26 val = 'Z') ).
