CLASS zcl_misc_379 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES my_type TYPE zty_travel_sts.
    DATA  my_data TYPE my_type.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_misc_379 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    FINAL(descr) = cl_abap_enumdescr=>describe_by_data( my_data ) .
*    FINAL(descr2) = cl_abap_enumdescr=>get( p_members ).

    out->write( '-- CL_ABAP_ENUMDESCR' ).

    FINAL(enum_descr) = CAST cl_abap_enumdescr(
    cl_abap_typedescr=>describe_by_data( my_data ) ).

   out->write( '-kind' ).
    out->write( enum_descr->kind ) .
  out->write( '-type_kind' ).
    out->write( enum_descr->type_kind ).
    out->write( '-base_type_kind' ).
    out->write( enum_descr->base_type_kind ).
      out->write( '-members' ).
    out->write( enum_descr->members ).
    data(tabe) = enum_descr->members.



  ENDMETHOD.
ENDCLASS.
