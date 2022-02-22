create or replace package PKG_MEMBER
as
  function f_add_member(
    pi_id_draw TBL_DRAW.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  )
  return TBL_MEMBER.ID%TYPE;

  procedure p_grid_save(
    pi_row_status varchar2
    ,pi_id_draw TBL_DRAW.ID%TYPE
    ,pio_id_member IN OUT TBL_MEMBER.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  );

  function f_get_email(
    pi_id_member in TBL_MEMBER.ID%TYPE
  ) return TBL_MEMBER.EMAIL_ADDRESS%TYPE;

end PKG_MEMBER;
/