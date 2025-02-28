CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_get_msg FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD test_get_msg.

    DATA(lv_message_local) = NEW zoblomov_cl_api_message(
        )->message_get(
            id         = `TANUMER`
            number     = `010` ).

    DATA(lv_message_none) = NEW zoblomov_cl_api_message( `NONE`
        )->message_get(
            id         = `TANUMER`
            number     = `010` ).

    TRY.
        DATA(lv_message_fail) = NEW zoblomov_cl_api_message( `DUMMY`
            )->message_get(
                id         = `TANUMER`
                number     = `010` ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_root INTO DATA(x).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
