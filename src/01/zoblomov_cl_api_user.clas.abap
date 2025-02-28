CLASS zoblomov_cl_api_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zoblomov_cl_api_.

  PUBLIC SECTION.

    METHODS check_exists
      IMPORTING
        name          TYPE clike
      RETURNING
        VALUE(result) TYPE abap_bool.

    METHODS get_detail
      IMPORTING
        name          TYPE clike
      RETURNING
        VALUE(result) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoblomov_cl_api_user IMPLEMENTATION.

  METHOD check_exists.

  ENDMETHOD.

  METHOD get_detail.

  ENDMETHOD.

ENDCLASS.
