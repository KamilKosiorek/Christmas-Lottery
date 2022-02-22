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

   procedure p_update_member(
    pi_id_member TBL_MEMBER.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  )
  as
  begin
    update 
      TBL_MEMBER
    set
      NAME = pi_name
      ,EMAIL_ADDRESS = pi_email_address
    where
      ID = pi_id_member;
    
  end p_update_member;

  procedure p_delete_member(
    pi_id_member TBL_MEMBER.ID%TYPE
  )
  as
  begin
    delete
      TBL_MEMBER
    where
      ID = pi_id_member;
  end p_delete_member;

  procedure p_grid_save(
    pi_row_status varchar2
    ,pi_id_draw TBL_DRAW.ID%TYPE
    ,pio_id_member IN OUT TBL_MEMBER.ID%TYPE
    ,pi_name TBL_MEMBER.NAME%TYPE
    ,pi_email_address TBL_MEMBER.EMAIL_ADDRESS%TYPE
  )
  as
    e_unknown_row_status exception;
  begin
    if pi_row_status = PKG_DIM.c_grid_status_row_create then
      pio_id_member := f_add_member(
        pi_id_draw => pi_id_draw
        ,pi_name => pi_name
        ,pi_email_address => pi_email_address
      );
    elsif pi_row_status = PKG_DIM.c_grid_status_row_updarte then
      p_update_member(
        pi_id_member => pio_id_member
        ,pi_name => pi_name
        ,pi_email_address => pi_email_address
      );
    elsif pi_row_status = PKG_DIM.c_grid_status_row_delete then
      p_delete_member(
        pi_id_member=> pio_id_member
      );
    else
      raise e_unknown_row_status;
    end if;
  end p_grid_save; 

  function f_get_email(
    pi_id_member in TBL_MEMBER.ID%TYPE
  ) return TBL_MEMBER.EMAIL_ADDRESS%TYPE
  as
    v_email TBL_MEMBER.EMAIL_ADDRESS%TYPE;
  begin
    select 
      EMAIL_ADDRESS
    into
      v_email
    from
      TBL_MEMBER
    where
      ID= pi_id_member;

    return v_email;
    

  end f_get_email;
  
end PKG_MEMBER;
/