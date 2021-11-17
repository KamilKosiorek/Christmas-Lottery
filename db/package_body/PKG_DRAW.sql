create or replace package body PKG_DRAW
as
  function f_create_draw
  return TBL_DRAW.ID%TYPE
  as
    v_id TBL_DRAW.ID%TYPE;
  begin
    insert into 
      TBL_DRAW 
      (
        ID
      )
     values
      (
        null
      )
    returning 
      ID 
    into 
      v_id;

    return v_id;
  end f_create_draw;

  procedure p_set_organizer(
    pi_id_draw TBL_DRAW.ID%TYPE
    ,pi_id_member_organizer TBL_MEMBER.ID%TYPE
  )
  as
  begin
    update 
      TBL_DRAW
    set 
      id_member_organizer=pi_id_member_organizer
    where 
      id = pi_id_draw;

  end p_set_organizer;
  
end PKG_DRAW;
/