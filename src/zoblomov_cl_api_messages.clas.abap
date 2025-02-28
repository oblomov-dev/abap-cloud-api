CLASS zoblomov_cl_api_messages DEFINITION
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



CLASS zoblomov_cl_api_messages IMPLEMENTATION.

  METHOD message_get.

  ENDMETHOD.

ENDCLASS.
