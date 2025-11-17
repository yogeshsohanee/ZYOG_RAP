CLASS zcl_read_practice_ysn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_READ_PRACTICE_YSN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*   example with Control structure
*    READ ENTITY zi_travel_ysn
*    FROM VALUE #( ( %key-TravelId = '00004142'
*                    %control = VALUE #( AgencyId = if_abap_behv=>mk-on
*                                        CustomerId = if_abap_behv=>mk-on
*                                        BeginDate = if_abap_behv=>mk-on )  ) )
*    RESULT DATA(lt_result_short)
*    FAILED DATA(lt_failed_short).
**

** Example with addition FIELDS and ALL_FIELDS (Without %Control)
*    READ ENTITY zi_travel_ysn
**    FIELDS ( AgencyId CustomerId CurrencyCode )
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004142' ) )
*    RESULT data(lt_result_short)
*    FAILED data(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

** Read with associations
*    READ ENTITY zi_travel_ysn
*    BY \_Booking
**    FIELDS ( AgencyId CustomerId CurrencyCode )
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004142' )
*                   ( %key-TravelId = '00004139' ) )
*    RESULT DATA(lt_result_short)
*    FAILED DATA(lt_failed_short).
*
*    IF lt_failed_short IS NOT INITIAL.
*      out->write( 'Read failed' ).
*    ELSE.
*      out->write( lt_result_short ).
*    ENDIF.

*
* READ ENTITY with LONG form - READ ENTITIES
*    READ ENTITIES OF zi_travel_ysn
*
*    ENTITY zi_travel_ysn
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004142' )
*                   ( %key-TravelId = '00004139' ) )
*    RESULT DATA(lt_result_long)
*
*    ENTITY zi_booking_ysn
*    ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00004142'
*                    %key-BookingId = '0010' ) )
*    RESULT DATA(lt_result_booking_long)
*    FAILED DATA(lt_failed_long).

*    Read entities with Dynamic form
    DATA: it_optab          TYPE abp_behv_retrievals_tab,
          it_travel         TYPE TABLE FOR READ IMPORT zi_travel_ysn, "This will import data as well as control structures
          it_travel_result  TYPE TABLE FOR READ RESULT zi_travel_ysn,
          it_booking        TYPE TABLE FOR READ IMPORT zi_travel_ysn\_Booking,
          it_booking_result TYPE TABLE FOR READ RESULT zi_travel_ysn\_Booking.

    it_travel = VALUE #( ( %key-TravelId = '00004142'
                            %control = VALUE #( AgencyId = if_abap_behv=>mk-on
                                                CustomerId = if_abap_behv=>mk-on
                                                BeginDate = if_abap_behv=>mk-on ) )
                           ).

    it_booking = VALUE #( ( %key-TravelId = '00004142'
                            %control = VALUE #(
                                                BookingDate = if_abap_behv=>mk-on
                                                BookingStatus = if_abap_behv=>mk-on
                                                BookingId = if_abap_behv=>mk-on
                                                ) )  ).
*   op = which operation you want to perform, entity_name = BO view name,
*   instance = which values we would like to fetch, results = table in which the results will be captured
    it_optab = VALUE #( ( op = if_abap_behv=>op-r-read
                          entity_name = 'ZI_TRAVEL_YSN'
                          instances = REF #( it_travel )
                          results = REF #( it_travel_result )
                           )

                           (
                            op = if_abap_behv=>op-r-read_ba
                            entity_name = 'ZI_TRAVEL_YSN'
                            sub_name = '_BOOKING'
                            instances = REF #( it_booking )
                            results = REF #( it_booking_result )
                           )
                           ).

    READ ENTITIES
       OPERATIONS it_optab
       FAILED DATA(lt_failed_dy).
    IF lt_failed_dy IS NOT INITIAL.
      out->write(  'READ FAILED' ).
    ELSE.
      out->write( it_travel_result ).
      out->write( it_booking_result ).
    ENDIF.

*    IF lt_failed_long IS NOT INITIAL.
*      out->write( 'Read Failed' ).
*    ELSE.
*      out->write( lt_result_long ).
*      out->write( lt_result_booking_long ).
*    ENDIF.
  ENDMETHOD.
ENDCLASS.
