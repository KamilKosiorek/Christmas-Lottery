create or replace package body PKG_RESULT
as

  gc_random_limit number default 10;
  gv_random_counter number default 0;
  


  procedure p_reset_random_counter
  as
  begin
    gv_random_counter :=0;
  end p_reset_random_counter;

  procedure p_increase_random_counter
  as
  begin
    gv_random_counter := gv_random_counter + 1;
  end p_increase_random_counter;
  


  procedure p_generate_result(
    pi_id_draw in TBL_DRAW.ID%TYPE
  )
  as
    v_member_possibilities number default 0;
    draw_limit_exceeded exception;
    v_seq number;
  begin
    delete 
      TBL_RESULT
    where
      ID_DRAW = pi_id_draw;

    for i in (select * from TBL_MEMBER where ID_DRAW = pi_id_draw order by dbms_random.random) loop
      select 
        count(1)
      into
        v_member_possibilities 
      from 
        tbl_member m1
      join 
        tbl_member m2
      on
          m1.id != m2.id
      where 
        m1.ID = i.id 
        and m1.ID_DRAW = pi_id_draw 
        and m2.ID_DRAW = pi_id_draw
        and not exists (select 1 from tbl_exclusions e where m1.ID = e.id_member_buyer and m2.ID = e.id_member_getting)
        and not exists (select 1 from tbl_result r where m2.ID = r.id_member_getting);

      if v_member_possibilities > 0 then

        v_seq := TRUNC(DBMS_RANDOM.value(1,v_member_possibilities+1));
        
        insert into TBL_RESULT
          (
            ID_DRAW
            ,ID_MEMBER_BUYER
            ,ID_MEMBER_GETTING
          )
          select
            pi_id_draw
            ,ID_MEMBER_BUYER
            ,ID_MEMBER_GETTING
          from (
            select 
              m1.id ID_MEMBER_BUYER, 
              m2.id id_member_getting,
              rownum seq
            from 
              tbl_member m1
            join 
              tbl_member m2
            on
                m1.id != m2.id
            where 
              m1.ID = i.id 
              and m1.ID_DRAW = pi_id_draw 
              and m2.ID_DRAW = pi_id_draw
              and not exists (select 1 from tbl_exclusions e where m1.ID = e.id_member_buyer and m2.ID = e.id_member_getting)
              and not exists (select 1 from tbl_result r where m2.ID = r.id_member_getting)
          )
          where seq = v_seq;
      else
        p_increase_random_counter;
        if gv_random_counter >= gc_random_limit then
          raise draw_limit_exceeded;
        else 
          p_generate_result(pi_id_draw => pi_id_draw);
        end if;
      end if;

    end loop;

  exception
    when draw_limit_exceeded then
      delete 
        TBL_RESULT
      where
        ID_DRAW = pi_id_draw;
      raise;
  end p_generate_result;
  
end PKG_RESULT;
/