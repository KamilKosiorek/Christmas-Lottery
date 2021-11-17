create or replace package PKG_EXCLUSIONS
as
  procedure p_add_exclusions(
    pi_id_draw in TBL_DRAW.ID%TYPE
    ,pi_member_buyer in TBL_EXCLUSIONS.ID_MEMBER_BUYER%TYPE
    ,pi_member_getting in TBL_EXCLUSIONS.ID_MEMBER_GETTING%TYPE
    ,pi_twosided_exclusion in varchar2 default 'N'
  );
  
end PKG_EXCLUSIONS;
/