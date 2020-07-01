class /edu/cl_trcnr_create definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
    types begin of ts_error.
    types msgid type symsgid.
    types msgtype type symsgty.
    types msgnumber type symsgno.
    types msgvar1 type symsgv.
    types msgvar2 type symsgv.
    types msgvar3 type symsgv.
    types msgvar4 type symsgv.
    types tablename type c length 30.
    types fieldname type c length 30.
    types critchange type c length 10.
    types end of ts_error.

    types tt_errors type standard table of ts_error with empty key.
    types tt_intervals type standard table of cl_numberrange_intervals=>nr_nriv_line with empty key.
endclass.



class /edu/cl_trcnr_create implementation.

  method if_oo_adt_classrun~main.
    data(object) = value cl_numberrange_objects=>nr_attributes-object( ).
    data(devclass) = value cl_numberrange_objects=>nr_attributes-devclass( ).
    data(corrnr) = value cl_numberrange_objects=>nr_attributes-corrnr( ).

    object   = '/EDU/TRCNR'.
    devclass = '/EDU/LOG_NR'.
    corrnr   = 'H01K900006'.

    data(errors) = value tt_errors( ).

    try.
        cl_numberrange_objects=>create(
          exporting
            attributes = value #( object     = object
                                  domlen     = '/EDU/DO_LOG_NR'
                                  percentage = 90
                                  buffer     = abap_true
                                  noivbuffer = 10
                                  devclass   = devclass
                                  corrnr     = corrnr )
              obj_text = value #( object     = object
                                  langu      = cl_abap_context_info=>get_user_language_abap_format( )
                                  txt        = |Log's trace ID|
                                  txtshort   = |Log's trace ID| )
          importing
            errors     = errors
            returncode = data(returncode) ).

        if returncode eq 'E'.
          loop at errors reference into data(err).
            data(msg) = corresponding symsg( err->* mapping msgty = msgtype
                                                            msgno = msgnumber
                                                            msgv1 = msgvar1
                                                            msgv2 = msgvar2
                                                            msgv3 = msgvar3
                                                            msgv4 = msgvar4 ).

            message id msg-msgid type msg-msgty number msg-msgno
                  with msg-msgv1 msg-msgv2 msg-msgv3 msg-msgv4
                  into data(dummy).

            out->write( dummy ).
          endloop.

          return.
        endif.

        data(intervals) = value tt_intervals( ( nrrangenr  = '01'
                                                fromnumber = '0000000000000000001'
                                                tonumber   = '9999999999999999999'
                                                procind    = 'I' ) ).

        cl_numberrange_intervals=>create(
          exporting
            interval  = intervals
            object    = object
          importing
            error     = data(error)
            error_inf = data(error_inf)
            error_iv  = data(errors_iv)
            warning   = data(warning) ).

        out->write( |{ object } create successfuly!| ).
      catch cx_abap_context_info_error into data(cx_ctx).
        out->write( cx_ctx->get_text( ) ).
      catch cx_number_ranges into data(cx_nr).
        out->write( cx_nr->get_text( ) ).
    endtry.
  endmethod.

endclass.
