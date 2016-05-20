*&---------------------------------------------------------------------*
*& Report  Z_ALV_INTERACTIVE
*&
*& Showing details of a sales document in va03 transaction given no in an ALV *
*&
*&
*&---------------------------------------------------------------------*

REPORT z_alv_interactive.
TYPE-POOLS: slis.
TABLES: vbak.

INCLUDE z_alv_interactive_top.

INCLUDE z_alv_interactive_selscreen.

INCLUDE z_alv_forms.



START-OF-SELECTION.
  PERFORM clear_refresh.
  PERFORM selection.

  IF sy-subrc = 0.

    gw_fieldcat-fieldname =    'VBELN'.
    gw_fieldcat-hotspot =    'X'.
    gw_fieldcat-seltext_m =    'Sales Docno'.
    PERFORM field_catalog.


    gw_fieldcat-fieldname =    'ERNAM'.
    gw_fieldcat-seltext_m =    'Created By'.
    PERFORM field_catalog.


    gw_fieldcat-fieldname =    'ERDAT'.
    gw_fieldcat-seltext_m =    'Date Created'.
    PERFORM field_catalog.

    PERFORM alv_grid.

  ENDIF.

FORM USER_COMMAND USING lv_ucomm TYPE sy-ucomm
                             lw_rs_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.
      READ TABLE gt_sales INTO gw_sales INDEX lw_rs_selfield-tabindex.
      SET PARAMETER ID 'AUN' FIELD gw_sales-vbeln.
      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
  ENDCASE.
ENDFORM.

  END-OF-SELECTION.
  PERFORM clear_refresh.