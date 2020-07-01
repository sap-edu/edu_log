class lhc_Text definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_authorizations for authorization
      importing keys request requested_authorizations for Text result result.

endclass.

class lhc_Text implementation.

  method get_authorizations.
    data ls_result like line of result.

    loop at keys reference into data(key).
      ls_result = value #( langu = key->langu
                           msgid = key->msgid
                           msgno = key->msgno
                           %update = if_abap_behv=>auth-allowed
                           %delete = if_abap_behv=>auth-allowed ).
      insert ls_result into table result.
    endloop.
  endmethod.

endclass.
