create or replace package body PKG_EXCLUSIONS
as
  procedure p_add_exclusions(
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

  end p_add_exclusions;
  
end PKG_EXCLUSIONS;
/