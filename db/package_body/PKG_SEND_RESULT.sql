create or replace package body PKG_SEND_RESULT
as

  function f_create_mail_content(
    pi_id_member_buyer in TBL_RESULT.ID_MEMBER_BUYER%TYPE
    ,pi_id_member_getting in TBL_RESULT.ID_MEMBER_GETTING%TYPE
  ) return clob
  as
    v_member_buyer_name TBL_MEMBER.NAME%TYPE;
    v_member_getting_name TBL_MEMBER.NAME%TYPE;
    v_content clob;
  begin
    select
      name
    into
      v_member_buyer_name
    from
      TBL_MEMBER
    where
      id = pi_id_member_buyer;
    
    select
      name
    into
      v_member_getting_name
    from
      TBL_MEMBER
    where
      id = pi_id_member_getting;

    v_content:=
'Ho, ho, ho '||v_member_buyer_name||'!
W tym roku grzeczny był/była '||v_member_getting_name||'.

'||v_member_getting_name||' marzy o:
';


    for i IN (SELECT * FROM TBL_PRESENTS where ID_MEMBER = pi_id_member_getting order by seq)
    loop
      v_content:=v_content||i.SEQ||'. '||i.DESCRIPTION||'
';
    end loop;

    return v_content;

  end f_create_mail_content;

  procedure p_send_result(
    pi_draw_id in TBL_DRAW.ID%TYPE
  )
  as
    v_content clob;
  begin
    for i in (select * from TBL_RESULT where ID_DRAW = pi_draw_id) loop
      v_content:= f_create_mail_content(
        pi_id_member_buyer => i.ID_MEMBER_BUYER
        ,pi_id_member_getting => i.ID_MEMBER_GETTING
      );

      APEX_MAIL.SEND(
        p_to =>PKG_MEMBER.f_get_email(
          pi_id_member => i.ID_MEMBER_BUYER
        )
        ,p_from => 'christmaslottery@oracle.com'
        ,p_body => v_content
        ,p_subj => 'Loteria Świąteczna'
      );


    end loop;

    APEX_MAIL.PUSH_QUEUE;
    
  end p_send_result;
  
end PKG_SEND_RESULT;
