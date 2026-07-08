CLASS zcl_002_contract_jcpr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      types: lty_vuelos type STANDARD TABLE OF /DMO/FLIGHT WITH EMPTY KEY.

      CLASS-DATA: currency type c LENGTH 3.

      methods: set_client IMPORTING iv_client   type string
                                    iv_location type string
                          EXPORTING ev_status   type string
                          changing  cv_process  type string,

               get_client exporting ev_client   type string,
               trae_nom_cli importing iv_cod_cl type string
                            returning value(rv_name_cli) type string.



      METHODS trae_vuelos importing value(iv_cod_cl) type string
                          returning value(rt_vuelo) TYPE lty_vuelos.

      CLASS-METHODS: set_cntr_type importing iv_cntr_type type string,
                     get_cntr_type exporting ev_cntr_type type string.
  PROTECTED SECTION.
      data: creation_date type sydate.
  PRIVATE SECTION.
      DATA client type string.
      CLASS-DATA cntr_type type string.

ENDCLASS.



CLASS zcl_002_contract_jcpr IMPLEMENTATION.

  METHOD set_client.
    client = iv_client.
    ev_status = 'OK'.
    cv_process = 'Started'.
  ENDMETHOD.

  METHOD get_client.
    if client is initial.
      ev_client = 'nada'.
    else.
      ev_client = client.
    endif.
  ENDMETHOD.

  METHOD get_cntr_type.
    ev_cntr_type = cntr_type.
  ENDMETHOD.

  METHOD set_cntr_type.
    cntr_type = iv_cntr_type.
  ENDMETHOD.

  METHOD trae_nom_cli.
    case iv_cod_cl.
        when 10.
          rv_name_cli = 'Mario Soto'.
        when 11.
          rv_name_cli = 'Susana Soto'.
        when 12.
          rv_name_cli = 'Pedro Soto'.
    endcase.
  ENDMETHOD.

  METHOD trae_vuelos.
    select from /dmo/flight
    fields *
    where carrier_id = @iv_cod_cl
    into table @rt_vuelo.
  endmethod.

ENDCLASS.
