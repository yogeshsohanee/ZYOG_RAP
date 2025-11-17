CLASS lhc_zi_booking_ysn DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Booksuppl FOR NUMBERING
      IMPORTING entities FOR CREATE ZI_BOOKING_YSN\_Booksuppl.

ENDCLASS.

CLASS lhc_zi_booking_ysn IMPLEMENTATION.

  METHOD earlynumbering_cba_Booksuppl.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
