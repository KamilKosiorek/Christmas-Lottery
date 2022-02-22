create or replace trigger tbl_draw_biu
    before insert or update 
    on tbl_draw
    for each row
begin
    if inserting then
        :new.draw_date := sysdate;
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
        :new.app_session_id :=sys_context('APEX$SESSION','APP_SESSION');
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end tbl_draw_biu;
/