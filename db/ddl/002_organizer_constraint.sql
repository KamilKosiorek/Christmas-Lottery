alter table "TBL_DRAW" modify
("ID_MEMBER_ORGANIZER" NUMBER);
alter table "TBL_DRAW" add constraint
"TBL_DRAW_ORGANIZER" foreign key ("ID_MEMBER_ORGANIZER") references "TBL_MEMBER" ("ID") on delete set null;

