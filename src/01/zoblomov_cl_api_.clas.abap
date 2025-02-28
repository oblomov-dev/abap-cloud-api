CLASS zoblomov_cl_api_ DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:
      BEGIN OF ms_config,
        dest_name   TYPE string,
        check_error TYPE abap_bool,
        text        TYPE string,
        t_log       TYPE bapirettab,
      END OF ms_config.

    METHODS constructor
      IMPORTING
        dest_name    TYPE clike OPTIONAL
        dest_service TYPE clike OPTIONAL
        http_url     TYPE clike OPTIONAL
          PREFERRED PARAMETER dest_name.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoblomov_cl_api_ IMPLEMENTATION.

  METHOD constructor.

    super->constructor( ).

    IF http_url IS NOT INITIAL.


    ELSE.

      ms_config-dest_name = lcl_util=>destination_cloud_get(
           name    = dest_name
           service = dest_service
       ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
