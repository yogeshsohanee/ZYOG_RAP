CLASS lhc_ZSAC_I_Bill_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZSAC_I_Bill_Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZSAC_I_Bill_Header RESULT result.
    METHODS calculate_netamount FOR MODIFY
      IMPORTING keys FOR ACTION ZSAC_I_Bill_Header~calculate_netamount RESULT result.

ENDCLASS.

CLASS lhc_ZSAC_I_Bill_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD calculate_netamount.
*    1. Read all header keys passed into the action
    READ ENTITIES OF ZSAC_I_Bill_Header IN LOCAL MODE
    ENTITY ZSAC_I_Bill_Header
    BY \_item
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_items)
    FAILED DATA(ls_failed).
*    2. Calculate net amount per BillId
    DATA lt_updates TYPE TABLE FOR UPDATE zsac_i_bill_header.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<lfs_key>).
*    sum up quantity * item amount for all items of this billing document
      DATA(lv_net_amount) = REDUCE decfloat34(
      INIT total = CONV decfloat34( 0 )
      FOR item IN lt_items
      WHERE ( BillId = <lfs_key>-BillId )
      NEXT total = total + ( item-Quantity * item-ItemAmount ) ).

      APPEND VALUE #( BillId = <lfs_key>-BillId
                      NetAmount = lv_net_amount
                      %control = VALUE #(  NetAmount = if_abap_behv=>mk-on ) ) TO lt_updates.
    ENDLOOP.
*  3. Modify the header entity with the new net amount
    MODIFY ENTITIES OF ZSAC_I_Bill_Header in local mode
    entity ZSAC_I_Bill_Header
    UPDATE FIELDS ( NetAmount )
    WITH lt_updates
    REPORTED DATA(ls_reported).

*    4. Read back the updates headers to return as result
    READ ENTITIES OF ZSAC_I_bill_header IN LOCAL MODE
    ENTITY ZSAC_I_bill_header
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result_headers).

*    5. Fill result parameter
    result = VALUE #( for header in lt_result_headers (  %tky = header-%tky %param = header ) ).


  ENDMETHOD.
ENDCLASS.
