CLASS zcl_data_generator_ysn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DATA_GENERATOR_YSN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  " delete existing entries in the database table

    DELETE FROM ztravel_ysn.

    DELETE FROM zBOOKING_ysn.

    DELETE FROM zbooksupp_ysn.

    COMMIT WORK.

    " insert travel demo data

    INSERT ztravel_ysn FROM (

        SELECT *

          FROM /dmo/travel_m

      ).

    COMMIT WORK.



    " insert booking demo data

    INSERT zbooking_ysn FROM (

        SELECT *

          FROM   /dmo/booking_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.

    INSERT zbooksupp_ysn FROM (

        SELECT *

          FROM   /dmo/booksuppl_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.



    out->write( 'Travel and booking demo data inserted.').
  ENDMETHOD.
ENDCLASS.
