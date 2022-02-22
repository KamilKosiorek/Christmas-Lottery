create or replace package body PKG_EXCLUSIONS
as
  procedure p_add_exclusion(
    pi_id_draw in TBL_DRAW.ID%TYPE
    ,pi_member_buyer in TBL_EXCLUSIONS.ID_MEMBER_BUYER%TYPE
    ,pi_member_getting in TBL_EXCLUSIONS.ID_MEMBER_GETTING%TYPE
    ,pi_twosided_exclusion in varchar2 default 'N'
  )
  as
  begin
    insert into 
      TBL_EXCLUSIONS 
      (
        ID_DRAW
        ,ID_MEMBER_BUYER
        ,ID_MEMBER_GETTING
      )
    values 
      (
        pi_id_draw
        ,pi_member_buyer
        ,pi_member_getting
      );

    if pi_twosided_exclusion = 'Y' then
      insert into 
        TBL_EXCLUSIONS 
        (
          ID_DRAW
          ,ID_MEMBER_BUYER
          ,ID_MEMBER_GETTING
        )
      values 
        (
          pi_id_draw
          ,pi_member_getting
          ,pi_member_buyer
        );
    end if;

  end p_add_exclusion;

  procedure p_update_exclusion(
    pi_id_exclusion TBL_EXCLUSIONS.ID%TYPE
    ,pi_member_buyer TBL_EXCLUSIONS.ID_MEMBER_BUYER%TYPE
    ,pi_member_getting TBL_EXCLUSIONS.ID_MEMBER_GETTING%TYPE
  )
  as
  begin
    update 
      TBL_EXCLUSIONS
    set
      ID_MEMBER_BUYER = pi_member_buyer
      ,ID_MEMBER_GETTING = pi_member_getting
    where
      ID = pi_id_exclusion;

  end p_update_exclusion;

  procedure p_delete_exclusion(
    pi_id_exclusion TBL_EXCLUSIONS.ID%TYPE
  )
  as
  begin
    delete
      TBL_EXCLUSIONS
    where
      ID = pi_id_exclusion;

  end p_delete_exclusion;

  procedure p_grid_save(
    pi_row_status varchar2
    ,pi_id_exclusion TBL_EXCLUSIONS.ID%TYPE
    ,pi_member_buyer TBL_EXCLUSIONS.ID_MEMBER_BUYER%TYPE
    ,pi_member_getting TBL_EXCLUSIONS.ID_MEMBER_GETTING%TYPE
  )
  as
    e_unknown_row_status exception;
  begin
    if pi_row_status = PKG_DIM.c_grid_status_row_updarte then
      p_update_exclusion(
        pi_id_exclusion => pi_id_exclusion
        ,pi_member_buyer => pi_member_buyer
        ,pi_member_getting => pi_member_getting
      );
    elsif pi_row_status = PKG_DIM.c_grid_status_row_delete then
      p_delete_exclusion(
        pi_id_exclusion=> pi_id_exclusion
      );
    else
      raise e_unknown_row_status;
    end if;
  end p_grid_save;



  
end PKG_EXCLUSIONS;
/