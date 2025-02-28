CLASS lcl_util DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS destination_cloud_get
      IMPORTING
        name          TYPE string
        service       TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.

CLASS lcl_util IMPLEMENTATION.

  METHOD destination_cloud_get.

*        DATA(lo_rfc_dest) = cl_rfc_destination_provider=>create_by_cloud_destination(
*                                       i_name = |FSD_RFC|
**                                       i_service_instance_name = |CA_EXTERNAL_API_SIN|
*       ).
*
*        DATA(lv_rfc_dest) = lo_rfc_dest->get_destination_name( ).

  ENDMETHOD.

ENDCLASS.
