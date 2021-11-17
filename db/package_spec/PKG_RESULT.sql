create or replace package PKG_RESULT
as
  procedure p_generate_result(
    pi_id_draw in TBL_DRAW.ID%TYPE
  );
  
end PKG_RESULT;
/