create or replace package body PKG_RESULT
as
  procedure p_generate_result(
    pi_id_draw in TBL_DRAW.ID%TYPE
  )
  as
  begin
    delete 
      TBL_RESULT
    where
      ID_DRAW = pi_id_draw;

    
    

  end p_generate_result;
  
end PKG_RESULT;
/