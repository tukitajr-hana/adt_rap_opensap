CLASS zcl_rap_eml_379 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rap_eml_379 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**    " step 1 - READ
*    READ ENTITIES OF Zi_RAP_ATRAV_379
*      ENTITY travel
*        FROM VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A6' ) )
*      RESULT DATA(travels).
*
*    out->write( travels ).
*
** " step 2 - READ with Fields
*    READ ENTITIES OF Zi_RAP_ATRAV_379
*      ENTITY travel
*        FIELDS ( AgencyID CustomerID )
*      WITH VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A6' ) )
*      RESULT travels.
*
*    out->write( travels ).
*
**        " step 3 - READ with All Fields
*    READ ENTITIES OF Zi_RAP_ATRAV_379
*      ENTITY travel
*        ALL FIELDS
*      WITH VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A6' ) )
*      RESULT DATA(travels) .

*
*    out->write( travels ).
*
*
** " step 4 - READ By Association
*    READ ENTITIES OF Zi_RAP_ATRAV_379
*      ENTITY travel BY \_Booking
*        ALL FIELDS
*         WITH VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A6' ) )
*      RESULT DATA(bookings).
*
*    out->write( bookings ).


    DATA: input_key2 TYPE TABLE FOR READ IMPORT  Zi_RAP_ATRAV_379\_Booking.

   input_key2 = VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A6' ) ) .

    READ ENTITIES OF Zi_RAP_ATRAV_379
      ENTITY travel BY \_Booking
        ALL FIELDS
         WITH input_key2
      RESULT DATA(bookings)
        FAILED data(failed)
      REPORTED data(reported).


    out->write( bookings ).
    out->write( failed ).    " complex structures not supported by the console output
    out->write( reported ).  " complex structures not supported by the console output



    " step 5 - Unsuccessful READ
*  DATA: input_key TYPE TABLE FOR READ IMPORT  Zi_RAP_ATRAV_379 .
*
*    input_key = VALUE #( ( TravelUUID = 'FF64F5903EACCD471900C0869FF077A1' ) ) .

*    READ ENTITIES OF Zi_RAP_ATRAV_379
*      ENTITY travel
*        ALL FIELDS
*        WITH input_key
*      RESULT DATA(travels)
*      FAILED DATA(failed)
*      REPORTED DATA(reported).
*
*    out->write( travels ).
*    out->write( failed ).    " complex structures not supported by the console output
*    out->write( reported ).  " complex structures not supported by the console output


*   " step 6 - MODIFY Update
     MODIFY ENTITIES OF Zi_RAP_ATRAV_379
       ENTITY travel
         UPDATE
           SET FIELDS WITH VALUE
             #( ( TravelUUID  = 'FF64F5903EACCD471900C0869FF077A6'
                  Description = 'desc text RAP opensap379' ) )
      FAILED failed
      REPORTED reported.

" step 6b - Commit Entities
     COMMIT ENTITIES
       RESPONSE OF Zi_RAP_ATRAV_379
       FAILED     DATA(failed_commit)
       REPORTED   DATA(reported_commit).

     out->write( 'Update done' ).

       " step 7 - MODIFY Create
    MODIFY ENTITIES OF Zi_RAP_ATRAV_379
      ENTITY travel
        CREATE
          SET FIELDS WITH VALUE
            #( ( %cid        = 'MyContentID_1'
                 AgencyID    = '70012'
                 CustomerID  = '14'
                 BeginDate   = cl_abap_context_info=>get_system_date( )
                 EndDate     = cl_abap_context_info=>get_system_date( ) + 10
                 Description = 'teste create new instance - RAP@openSAP 379 r2' ) )

     MAPPED DATA(mapped)
     FAILED failed
     REPORTED reported.

    out->write( mapped-travel ).

    COMMIT ENTITIES
      RESPONSE OF Zi_RAP_ATRAV_379
      FAILED     failed_commit
      REPORTED   reported_commit.

    out->write( 'Create done' ).

   " step 8 - MODIFY Delete
    MODIFY ENTITIES OF Zi_RAP_ATRAV_379
      ENTITY travel
        DELETE FROM
          VALUE
            #( ( TravelUUID  = '26E2B0F7ECF31EDFBCF046C497DBE76A' ) )

     FAILED failed
     REPORTED reported.

    COMMIT ENTITIES
      RESPONSE OF Zi_RAP_ATRAV_379
      FAILED     failed_commit
      REPORTED   reported_commit.

    out->write( 'Delete done' ).

  ENDMETHOD.
ENDCLASS.
