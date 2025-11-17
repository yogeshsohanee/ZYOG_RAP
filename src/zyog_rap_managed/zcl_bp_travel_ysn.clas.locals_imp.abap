CLASS lhc_ZI_TRAVEL_YSN DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_ysn RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel_ysn RESULT result.
    METHODS earlynumbering_cba_booking FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_ysn\_booking.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_ysn.
ENDCLASS.

CLASS lhc_ZI_TRAVEL_YSN IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.
    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities ) ) "lines(lt_entities) is not compatible with quantity field so added CONV
          IMPORTING
            number            = DATA(lv_latest_num)
            returncode        = DATA(lv_code)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).
        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key ) TO failed-zi_travel_ysn.
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key
                          %msg = lo_error ) TO reported-zi_travel_ysn.
        ENDLOOP.
        EXIT.
    ENDTRY.

    ASSERT lv_qty = lines( lt_entities ).

    DATA(lv_current_num) = lv_latest_num - lv_qty.
    LOOP AT lt_entities INTO ls_entities.
      lv_current_num = lv_current_num + 1.
      APPEND VALUE #( %cid = ls_entities-%cid
                      TravelId = lv_current_num ) TO mapped-zi_travel_ysn.
    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.
    DATA: lv_mx_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travel_ysn IN LOCAL MODE
    ENTITY zi_travel_ysn BY \_Booking
    FROM CORRESPONDING #( entities )
    LINK DATA(lt_link_data).
  ENDMETHOD.

ENDCLASS.
