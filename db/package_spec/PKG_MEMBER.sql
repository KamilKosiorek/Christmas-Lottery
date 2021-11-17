create or replace package PKG_MEMBER
as
  function f_add_member(
    pi_id_draw TBL_DRAW.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  )
  return TBL_MEMBER.ID%TYPE;

end PKG_MEMBER;
/