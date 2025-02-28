CLASS lcl_util DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS destination_cloud_get
      IMPORTING
        name          TYPE string
        service       TYPE string
      RETURNING
        VALUE(result) TYPE string.


    METHODS _bapi_message_getdetail
      IMPORTING
        id         TYPE clike
        number     TYPE clike
        textformat TYPE clike DEFAULT ``
      EXPORTING
        message    TYPE string.

    DATA:
      BEGIN OF ms_config,
        dest_name   TYPE string,
        check_error TYPE abap_bool,
        text        TYPE string,
        t_log       TYPE bapirettab,
      END OF ms_config.

ENDCLASS.

CLASS lcl_util IMPLEMENTATION.

  METHOD _bapi_message_getdetail.

    TYPES:
      BEGIN OF ty_export,
        id         TYPE c LENGTH 20,
        number     TYPE n LENGTH 3,
        textformat TYPE c LENGTH 3,
      END OF ty_export.
    DATA(ls_export) = VALUE ty_export(
        id          = id
        number      = number
        textformat  = textformat
     ).

    TYPES:
      BEGIN OF ty_import,
        message TYPE c LENGTH 220,
      END OF ty_import.
    DATA(ls_import) = VALUE ty_import( ).


    TRY.
        DATA(lv_fm_name) = `BAPI_MESSAGE_GETDETAIL`.
        CALL FUNCTION lv_fm_name
          DESTINATION ms_config-dest_name
          EXPORTING
            id            = ls_export-id            " Message class
            number        = ls_export-number        " Message number
            textformat    = ls_export-textformat    " Format of text to be displayed
          IMPORTING
            message       = ls_import-message
          EXCEPTIONS
            error_message = 2
            OTHERS        = 1.                " Message Short Text
        IF sy-subrc <> 0.
          ms_config-text = z2ui5_cl_util=>msg_get_s( sy )-text.
          ms_config-check_error = abap_true.
          RETURN.
        ENDIF.
      CATCH cx_root INTO DATA(x).
        ms_config-text = z2ui5_cl_util=>msg_get_s( x )-text.
        ms_config-check_error = abap_true.
        RETURN.
    ENDTRY.

    message = ls_import-message.
    RETURN.



*    CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
*      EXPORTING
*        id            = ls_export-id                " Message class
*        number        = ls_export-number              " Message number
*        textformat    = ls_export-textformat                 " Format of text to be displayed
*      IMPORTING
*        message       = ls_import-message
*      EXCEPTIONS
*        error_message = 2
*        OTHERS        = 1.                " Message Short Text

  ENDMETHOD.


  METHOD destination_cloud_get.

*        DATA(lo_rfc_dest) = cl_rfc_destination_provider=>create_by_cloud_destination(
*                                       i_name = |FSD_RFC|
**                                       i_service_instance_name = |CA_EXTERNAL_API_SIN|
*       ).
*
*        DATA(lv_rfc_dest) = lo_rfc_dest->get_destination_name( ).

  ENDMETHOD.

ENDCLASS.



CLASS lcl_message_getdetail DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      symsgid                        TYPE c LENGTH 000020 ##TYPSHADOW .
    TYPES:
      langu                          TYPE c LENGTH 000001 ##TYPSHADOW .
    TYPES:
      laiso                          TYPE c LENGTH 000002 ##TYPSHADOW .
    TYPES:
      bapi_linesize                  TYPE n LENGTH 000003 ##TYPSHADOW .
    TYPES:
      bapi_lmask                     TYPE c LENGTH 000255 ##TYPSHADOW .
    TYPES:
      symsgv                         TYPE c LENGTH 000050 ##TYPSHADOW .
    TYPES:
      symsgno                        TYPE n LENGTH 000003 ##TYPSHADOW .
    TYPES:
      bapi_tfrmt                     TYPE c LENGTH 000003 ##TYPSHADOW .
    TYPES:
      bapi_msg                       TYPE c LENGTH 000220 ##TYPSHADOW .
    TYPES:
      bapi_mtype TYPE c LENGTH 000001 ##TYPSHADOW .
    TYPES:
      balognr TYPE c LENGTH 000020 ##TYPSHADOW .
    TYPES:
      balmnr TYPE n LENGTH 000006 ##TYPSHADOW .
    TYPES:
      bapi_param TYPE c LENGTH 000032 ##TYPSHADOW .
    TYPES:
      bapi_line TYPE int4 ##TYPSHADOW .
    TYPES:
      bapi_fld TYPE c LENGTH 000030 ##TYPSHADOW .
    TYPES:
      bapilogsys TYPE c LENGTH 000010 ##TYPSHADOW .
    TYPES:
      BEGIN OF bapiret2                      ,
        type       TYPE bapi_mtype,
        id         TYPE symsgid,
        number     TYPE symsgno,
        message    TYPE bapi_msg,
        log_no     TYPE balognr,
        log_msg_no TYPE balmnr,
        message_v1 TYPE symsgv,
        message_v2 TYPE symsgv,
        message_v3 TYPE symsgv,
        message_v4 TYPE symsgv,
        parameter  TYPE bapi_param,
        row        TYPE bapi_line,
        field      TYPE bapi_fld,
        system     TYPE bapilogsys,
      END OF bapiret2                       ##TYPSHADOW .
    TYPES:
      bapi_tline TYPE c LENGTH 000255 ##TYPSHADOW .
    TYPES:
      BEGIN OF bapitgb                       ,
        line TYPE bapi_tline,
      END OF bapitgb                        ##TYPSHADOW .
    TYPES:
      _bapitgb                       TYPE STANDARD TABLE OF bapitgb                        WITH DEFAULT KEY ##TYPSHADOW .

    METHODS bapi_message_getdetail
      IMPORTING
        !id           TYPE symsgid
        !language     TYPE langu DEFAULT sy-langu
        !language_iso TYPE laiso OPTIONAL
        !line_size    TYPE bapi_linesize OPTIONAL
        !linkpattern  TYPE bapi_lmask OPTIONAL
        !message_v1   TYPE symsgv OPTIONAL
        !message_v2   TYPE symsgv OPTIONAL
        !message_v3   TYPE symsgv OPTIONAL
        !message_v4   TYPE symsgv OPTIONAL
        !number       TYPE symsgno
        !textformat   TYPE bapi_tfrmt
      EXPORTING
        !message      TYPE bapi_msg
        !return       TYPE bapiret2
      CHANGING
        !text         TYPE _bapitgb OPTIONAL .
    METHODS constructor
      IMPORTING
        !destination TYPE rfcdest .
  PROTECTED SECTION.

    DATA destination TYPE rfcdest .
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_message_getdetail IMPLEMENTATION.


  METHOD bapi_message_getdetail.
    DATA: _rfc_message_ TYPE char255,
          ls_return     LIKE return.
    CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL' DESTINATION me->destination
      EXPORTING
        id                    = id
        language              = language
        language_iso          = language_iso
        line_size             = line_size
        linkpattern           = linkpattern
        message_v1            = message_v1
        message_v2            = message_v2
        message_v3            = message_v3
        message_v4            = message_v4
        number                = number
        textformat            = textformat
      IMPORTING
        message               = message
        return                = return
      TABLES
        text                  = text
      EXCEPTIONS
        communication_failure = 1 MESSAGE _rfc_message_
        system_failure        = 2 MESSAGE _rfc_message_
        OTHERS                = 3.
    IF sy-subrc NE 0.
      DATA __sysubrc TYPE sy-subrc.
      DATA __textid TYPE scx_t100key.
      __sysubrc = sy-subrc.
      __textid-msgid = sy-msgid.
      __textid-msgno = sy-msgno.
      __textid-attr1 = sy-msgv1.
      __textid-attr2 = sy-msgv2.
      __textid-attr3 = sy-msgv3.
      __textid-attr4 = sy-msgv4.
      CASE __sysubrc.
        WHEN 1 .
          ls_return-type = 'E'.
          ls_return-message = |BAPI_MESSAGE_GETDETAIL         COMMUNICATION_FAILURE: { _rfc_message_ } for destination { me->destination }|.
          return                         = ls_return.
        WHEN 2 .
          ls_return-type = 'E'.
          ls_return-message = |BAPI_MESSAGE_GETDETAIL         SYSTEM_FAILURE: { _rfc_message_ } for destination { me->destination }|.
          return                         = ls_return.
        WHEN 3 .
          ls_return-type = 'E'.
          ls_return-message = |BAPI_MESSAGE_GETDETAIL         OTHERS: for destination { me->destination }|.
          return                         = ls_return.
      ENDCASE.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.
    me->destination = destination.
  ENDMETHOD.
ENDCLASS.
