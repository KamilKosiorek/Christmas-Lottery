create or replace package body PKG_MEMBER
as
  function f_add_member(
    pi_id_draw TBL_DRAW.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  )
  return TBL_MEMBER.ID%TYPE
  as
    v_id TBL_MEMBER.ID%TYPE;
  begin
    insert into 
      TBL_MEMBER 
      (
        ID_DRAW
        ,NAME
        ,EMAIL_ADDRESS
      )
    values 
      (
        pi_id_draw
        ,pi_name
        ,pi_email_address
      )
    returning 
      ID 
    into
      v_id;

    return v_id;

  end f_add_member;

end PKG_MEMBER;
/