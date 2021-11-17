create or replace package PKG_DRAW
as
  function f_create_draw
  return TBL_DRAW.ID%TYPE;

  procedure p_set_organizer(
    pi_id_draw TBL_DRAW.ID%TYPE
    ,pi_id_member_organizer TBL_MEMBER.ID%TYPE
  );
  
end PKG_DRAW;
/