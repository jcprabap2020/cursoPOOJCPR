CLASS zcl_001_exec_jcpr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_001_exec_jcpr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    data: lo_contract type REF to zcl_002_contract_jcpr.
*    CREATE object lo_contract.
    data: lv_process type string.
    data(lo_contract) = new zcl_002_contract_jcpr(  ).
    data(lo_otro_cntr) = new zcl_002_contract_jcpr(  ).

    zcl_002_contract_jcpr=>currency = 'USD'.
    zcl_002_contract_jcpr=>set_cntr_type( iv_cntr_type = 'zona-99' ).

    if lo_contract is bound.
*        nada
        lo_contract->get_client( IMPORTING ev_client = data(lv_client) ).
        out->write( | Inicio = { lv_client } | ).
*        setea
        lo_contract->set_client(
          EXPORTING
            iv_client   = '**** Juan Carlos *****'
            iv_location = space
          IMPORTING
            ev_status   = data(lv_status)
          CHANGING
            cv_process  = lv_process
        ).
        out->write( | Status => { lv_status } Process => { lv_process } | ).
*        Algo
        lo_contract->get_client( IMPORTING ev_client = lv_client ).
        out->write( | Final = { lv_client } | ).

        out->write( | Mon-static_1 = { lo_contract->currency } | ).
        out->write( | Mon-static_2 = { lo_otro_cntr->currency } | ).
*------------------------------------------------------------------------------
*        lo_contract->set_cntr_type( iv_cntr_type = 'Type-1' ).
*        lo_otro_cntr->set_cntr_type( iv_cntr_type = 'Type-2' ).

*        lo_contract->get_cntr_type( IMPORTING ev_cntr_type = data(lv_type) ).
*        out->write( | Tipo-1 = { lv_type } | ).
*
*        lo_otro_cntr->get_cntr_type( IMPORTING ev_cntr_type = lv_type ).
*        out->write( | Tipo-2 = { lv_type } | ).

         zcl_002_contract_jcpr=>get_cntr_type( importing ev_cntr_type = data(lv_tipo) ).
         out->write( lv_tipo ).

         lo_otro_cntr->set_client(
           EXPORTING
             iv_client   = '***** Marccela *****'
             iv_location = 'Chile'
           IMPORTING
             ev_status   = data(lv_stat2)
           CHANGING
             cv_process  = lv_process
         ).
        lo_otro_cntr->get_client( IMPORTING ev_client = lv_client ).
        out->write( | lo_otro_cntr = { lv_client } | ).

*        "Metodo Funcional

        out->write( data = | met funcional 1 = { lo_otro_cntr->trae_nom_cli( iv_cod_cl = '12' )  } | name = 'obj-1' ).
        out->write( data = | met funcional 2 = { lo_contract->trae_nom_cli( iv_cod_cl = '10' )  } | name = 'obj-2' ).

        data(lti_vuelos) = lo_contract->trae_vuelos( iv_cod_cl = 'UA' ).

         out->write( data = lti_vuelos name = 'Vuelos' ).


    endif.

  ENDMETHOD.

ENDCLASS.
