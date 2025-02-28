CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD first_test.

    DATA(lv_message_local) = NEW zoblomov_cl_api_messages(
        )->message_get(
            id         = `TANUMER`
            number     = `010` ).

    DATA(lv_message_none) = NEW zoblomov_cl_api_messages( `NONE`
        )->message_get(
            id         = `TANUMER`
            number     = `010` ).


  ENDMETHOD.

ENDCLASS.
