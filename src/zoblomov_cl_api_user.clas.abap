CLASS zoblomov_cl_api_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zoblomov_cl_api_.

  PUBLIC SECTION.

    METHODS message_get
      IMPORTING
        id            TYPE clike
        number        TYPE clike
        textformat    TYPE clike DEFAULT ``
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoblomov_cl_api_user IMPLEMENTATION.

  METHOD message_get.

  ENDMETHOD.

ENDCLASS.
