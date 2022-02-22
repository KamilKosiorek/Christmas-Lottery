create or replace package PKG_SEND_RESULT
as
  procedure p_send_result(
    pi_draw_id in TBL_DRAW.ID%TYPE
  );
  
end PKG_SEND_RESULT;
