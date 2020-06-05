﻿CREATE TABLE PLAYERS
(
	GUID_PLAYER    UUID NOT NULL PRIMARY KEY
	,FIRST_NAME     VARCHAR(100)
	,MID_NAME      VARCHAR(100)
	,LAST_NAME     VARCHAR(100)
    ,MAIL          VARCHAR(100)
	,PASSWORD_PL   bytea
);
CREATE TABLE HEROES_CLASS_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_FIELD VARCHAR(30) NOT NULL
);
CREATE TABLE HEROES_LANGUAGE_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_FIELD VARCHAR(30) NOT NULL
);
CREATE TABLE HEROES_VISION_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_FIELD VARCHAR(30) NOT NULL
);

CREATE TABLE HEROES_SIZE_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_FIELD VARCHAR(30) NOT NULL
);


CREATE TABLE HEROES_RACES_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
	,NAME_FIELD VARCHAR(30) NOT NULL
	,ID_FIELD_LANG        INT REFERENCES HEROES_LANGUAGE_DIC(ID_FIELD)
	,ID_FIELD_VISION      INT REFERENCES HEROES_VISION_DIC(ID_FIELD)
	,ID_FIELD_SIZE        INT REFERENCES HEROES_SIZE_DIC(ID_FIELD)
);



CREATE TABLE HEROES
(
	ID_HERO    		  INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY
   ,NAME_HERO         VARCHAR(50)
   ,ID_RACE           INT  REFERENCES HEROES_RACES_DIC(ID_FIELD)
   ,LEVEL_HERO        INT
   ,ID_CLASS          INT REFERENCES HEROES_CLASS_DIC(ID_FIELD)
   ,SEX               VARCHAR(20)
   ,CURRENTEXP        INT
   ,HEIGHT            INT
   ,WEIGHT            INT
   ,SIZE              INT
   ,VISION            INT
   ,LANGUAGE_HERO     INT
   ,GUID_PLAYER       UUID NOT NULL references PLAYERS
);

CREATE TABLE HEROES_PARAM_DIC
(ID_FIELD  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,MAIN_PARAM    BOOL NOT NULL
,NAME_FIELD VARCHAR(30) NOT NULL
,SHORT_NAME_FIELD varchar(5));


CREATE TABLE HEROES_PARAM_ADDFL_ARRAY
(
	ID_HERO       INT REFERENCES HEROES
   ,ID_FIELD      INT REFERENCES HEROES_PARAM_DIC
   ,TRAINING      BOOL 	NOT NULL
   ,FIELD_INT     INT
   ,FIELD_STRING  VARCHAR(100)
   ,FIELD_MONEY   MONEY
   ,PRIMARY KEY (ID_HERO ,ID_FIELD ));

CREATE TABLE RACE_PARAM_DEFAULT
(
	ID_RACE              INT REFERENCES HEROES_RACES_DIC(ID_FIELD)
   ,ID_FIELD_PARAM       INT REFERENCES HEROES_PARAM_DIC(ID_FIELD)
   ,FIELD_DEFAULT        INT
<<<<<<< Boris
   ,ADDTOPARAM           INT
=======
   ,ADD_TO_PARAM         INT
   ,ADD_TO_PARAM_DEFAULT INT
>>>>>>> добавил описание рассы
   ,PRIMARY KEY (ID_RACE ,ID_FIELD_PARAM ));

/*insert into  RACE_PARAM_DEFAULT (ID_RACE,ID_FIELD_PARAM) select hr.ID_FIELD,hp.ID_FIELD  from HEROES_PARAM_DIC hp
	,HEROES_RACES_DIC hr
<<<<<<< Boris
	where hp.main_param = true;
update RACE_PARAM_DEFAULT as rp
	set ADDTOPARAM = 2  where (rp.ID_RACE,rp.ID_FIELD_PARAM) in (
		select rpd.ID_RACE,hp.ID_FIELD  from    RACE_PARAM_DEFAULT rpd
			inner join HEROES_PARAM_DIC hp
				on rpd.ID_FIELD_PARAM = hp.ID_FIELD
			inner join HEROES_RACES_DIC hr
				on rpd.ID_RACE = hr.ID_FIELD
			where hp.NAME_FIELD = 'STRENGTH'
				and hr.NAME_FIELD in ('ДРАКОНОРОЖДЁННЫЙ','ДВАРФ','ЧЕЛОВЕК','ПОЛУОРК'));

update RACE_PARAM_DEFAULT as rp
	set ADDTOPARAM = 2  where rp.ID_RACE in (
		select rpd.ID_RACE  from    RACE_PARAM_DEFAULT rpd
			inner join HEROES_PARAM_DIC hp
				on rpd.ID_FIELD_PARAM = hp.ID_FIELD
			inner join HEROES_RACES_DIC hr
				on rpd.ID_RACE = hr.ID_FIELD
			where hp.NAME_FIELD = 'STRENGTH'
				and hr.NAME_FIELD in ('ДРАКОНОРОЖДЁННЫЙ','ДВАРФ','ЧЕЛОВЕК','ПОЛУОРК'));

=======
	where hp.main_param = true;
*/

insert into  RACE_PARAM_DEFAULT (ID_RACE,ID_FIELD_PARAM,FIELD_DEFAULT,ADD_TO_PARAM,ADD_TO_PARAM_DEFAULT)
 SELECT hr.id_field,hp.id_field,10,
CASE when  hr.NAME_FIELD in ('ДРАКОНОРОЖДЁННЫЙ','ДВАРФ','ЧЕЛОВЕК','ПОЛУОРК') Then 2 else 0 END
,0
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'STRENGTH'
--				and hr.NAME_FIELD in ('ДРАКОНОРОЖДЁННЫЙ','ДВАРФ','ЧЕЛОВЕК','ПОЛУОРК')
union
 SELECT hr.id_field,hp.id_field,10,
CASE when  hr.NAME_FIELD in ('ТИФЛИНГ','ДРАКОНОРОЖДЁННЫЙ','ПОЛУРОСЛИК','ЧЕЛОВЕК','ПОЛУОРК', 'ДРЕВЕНЬ','МИНОТАВР') Then 2 else 0 END
,CASE when  hr.NAME_FIELD in ('ДВАРФ','ПОЛУЭЛЬФ') Then 2 else 0 END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'STAMINA'
union
 SELECT hr.id_field,hp.id_field,10,
CASE when  hr.NAME_FIELD in ('ЭЛАДРИН','ЧЕЛОВЕК','ГИТЗЕРАЙ', 'ДРЕВЕНЬ') Then 2 else 0 END
,CASE when  hr.NAME_FIELD in ('ПОЛУРОСЛИК','ЭЛЬФ') Then 2 else 0 END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'AGILITY'
union
 SELECT hr.id_field,hp.id_field,10,
CASE when  hr.NAME_FIELD in ('ТИФЛИНГ','ЧЕЛОВЕК','ГИТЗЕРАЙ', 'ЭЛЬФ') Then 2 else 0 END
,CASE when  hr.NAME_FIELD in ('ЭЛАДРИН') Then 2 else 0 END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'INTELLECT'
union
 SELECT hr.id_field,hp.id_field,10,
CASE when  hr.NAME_FIELD in ('ДВАРФ','ЧЕЛОВЕК','ЭЛЬФ', 'ПОЛУЭЛЬФ','МИНОТАВР','ШАРДМАЙНД') Then 2 else 0 END
, 0
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'WISDOME'
union
 SELECT hr.id_field,hp.id_field,8,
CASE when  hr.NAME_FIELD in ('ПОЛУЭЛЬФ','ЭЛАДРИН','ПОЛУРОСЛИК', 'ЧЕЛОВЕК','ШАРДМАЙНД') Then 2 else 0 END
,CASE when  hr.NAME_FIELD in ('ТИФЛИНГ','ДРАКОНОРОЖДЁННЫЙ') Then 2 else 0 END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_FIELD = 'CHARISMA'
<<<<<<< Boris

>>>>>>> добавил описание рассы
=======
select 1
>>>>>>> добавил инсерты рассы


--update RACE_PARAM_DEFAULT as rp set FIELD_DEFAULT = 1,ADDTOPARAM = 1 where rp.ID_RACE in (1)

INSERT INTO HEROES_PARAM_DIC(MAIN_PARAM, NAME_FIELD,SHORT_NAME_FIELD )
	select TRUE,'STRENGTH','STR'
	UNION SELECT TRUE,'STAMINA','STA'
	UNION SELECT TRUE,'AGILITY','AGL'
	UNION SELECT TRUE,'INTELLECT','INT'
	UNION SELECT TRUE,'WISDOME','WSD'
	UNION SELECT TRUE,'CHARISMA' ,'CHA'
	UNION SELECT  FALSE,'DUNGEONS','DNG'
	UNION SELECT  FALSE,'HEALINGCHARS' ,'HEAL'
	UNION SELECT  FALSE,'INTIMIDATION','INTD'
	UNION SELECT  FALSE, 'ENDURANCE','EDNU'
	UNION SELECT  FALSE,'CONVERSATION','CONVR'
	UNION SELECT  FALSE,'STEALTH','STL'
	UNION SELECT  FALSE,'INSIGHT','INSG'
	UNION SELECT  FALSE,'MAGIC','MAGIC'
	UNION SELECT  FALSE,'ATHLETICS','ATHL'
	UNION SELECT  FALSE,'ACROBATICS','ACRB'
	UNION SELECT  FALSE,'DECEPTION','DCPT'
	UNION SELECT  FALSE,'NATURE','NATUR'
	UNION SELECT  FALSE,'THEF','THEF'
	UNION SELECT  FALSE,'STREETS','STRTS'
	UNION SELECT  FALSE,'ATTENTION','ATT'
	UNION SELECT  FALSE,'RELIGION','REL'
	UNION SELECT  FALSE,'HISTORY','HIST'
	order by  1 desc;
INSERT INTO HEROES_RACES_DIC (NAME_FIELD)
	SELECT 'ДВАРФ'
	UNION SELECT 'ПОЛУЭЛЬФ'
	UNION SELECT 'ТИФЛИНГ'
	UNION SELECT 'ЭЛАДРИН'
	UNION SELECT 'ДРАКОНОРОЖДЁННЫЙ'
	UNION SELECT 'ПОЛУРОСЛИК'
	UNION SELECT 'ЧЕЛОВЕК'
	UNION SELECT 'ЭЛЬФ'
	UNION SELECT 'ГНОМ'
	UNION SELECT 'ГОЛИАФ'
	UNION SELECT 'ДЭВ'
	UNION SELECT 'ПОЛУОРК'
	UNION SELECT 'ГИТЗЕРАЙ'
	UNION SELECT 'ДРЕВЕНЬ'
	UNION SELECT 'МИНОТАВР'
	UNION SELECT 'ШАРДМАЙНД'
order by  1 desc;
INSERT INTO HEROES_CLASS_DIC(NAME_FIELD)
	SELECT 'АПОСТОЛ'
	UNION SELECT 'БАРД'
	UNION SELECT 'ВАРВАР'
	UNION SELECT 'ВОЕНАЧАЛЬНИК'
	UNION SELECT 'ВОИН'
	UNION SELECT 'ВОЛШЕБНИК'
	UNION SELECT 'ДРУИД'
	UNION SELECT 'ЖРЕЦ'
	UNION SELECT 'ЖРЕЦ РУН'
	UNION SELECT 'КАРАТЕЛЬ'
	UNION SELECT 'КОЛДУН'
	UNION SELECT 'ЛОВЕЦ'
	UNION SELECT 'МОНАХ'
	UNION SELECT 'ПАЛАДИН'
	UNION SELECT 'ПЛУТ'
	UNION SELECT 'ПСИ-ВОИН'
	UNION SELECT 'ПСИОНИК'
	UNION SELECT 'РЕВНИТЕЛЬ'
	UNION SELECT 'СЛЕДОПЫТ'
	UNION SELECT 'ХРАНИТЕЛЬ'
	UNION SELECT 'ЧАРОДЕЙ'
	UNION SELECT 'ШАМАН'order by  1 desc;

INSERT INTO HEROES_LANGUAGE_DIC(NAME_FIELD)
SELECT 'ДВАРФСКИЙ'
UNION SELECT 'ОБЩИЙ'
UNION SELECT 'ЭЛЬФИЙСКИЙ'
UNION SELECT 'ДРАКОНИЙ'
UNION SELECT 'ВЕЛИКАНИЙ'
UNION SELECT 'ГЛУБИННЫЙ';

INSERT INTO HEROES_VISION_DIC(NAME_FIELD)
SELECT 'СУМЕРЕЧНОЕ'
UNION SELECT 'ОБЫЧНОЕ';
INSERT INTO HEROES_SIZE_DIC(NAME_FIELD)
SELECT 'СРЕДНИЙ'
UNION SELECT 'МАЛЕНЬКИЙ';
/*
select * from PLAYERS;
select * from HEROES;
select * from HEROES_PARAM_DIC;
select * from HEROES_PARAM_ADDFL_ARRAY;

DROP TABLE PLAYERS cascade;
DROP TABLE HEROES_RACES_DIC cascade;
DROP TABLE HEROES_CLASS_DIC cascade;
DROP TABLE HEROES cascade;
DROP TABLE HEROES_PARAM_DIC cascade;
DROP TABLE HEROES_PARAM_ADDFL_ARRAY cascade;
DROP TABLE HEROES_LANGUAGE_DIC cascade;
DROP TABLE HEROES_VISION_DIC cascade;
DROP TABLE HEROES_SIZE_DIC cascade;
DROP TABLE RACE_PARAM_DEFAULT CASCADE;

*/
/*
   CREATE OR REPLACE FUNCTION work.fun_test_2 ()
     RETURNS TABLE(id numeric, number numeric, name text, znach numeric) AS
   $BODY$
    DECLARE
    rec RECORD;
   BEGIN
   FOR rec IN EXECUTE 'select * from work.test where znach = 10'
        LOOP
                id = rec.id;
                number =rec.number;
                name = rec.name;
                znach = rec.znach;
                RETURN next;
        END LOOP;
   END;
   $BODY$
     LANGUAGE 'plpgsql' VOLATILE
     COST 100
     ROWS 1000;
   ALTER FUNCTION work.fun_test_2 () OWNER TO postgres;
*/

--INSERT INTO HEROES_PARAM_DIC(MAIN_PARAM, NAME_FIELD,SHORT_NAME_FIELD )

/*
insert into HEROES_ADDFL_INT
select 1,6,1

  delete  from HEROES_BASE_PARAM_DIC


CREATE TABLE HEROES_BASE_PARAM_ADDFL_INT
(
	ID_HERO     INT REFERENCES HEROES
   ,ID_FIELD      INT REFERENCES HEROES_BASE_PARAM_DIC
   ,FIELD         INT
   ,PRIMARY KEY (ID_HERO ,ID_FIELD ));

drop table PLAYERS
drop table  HEROES_PARAM_ADDFL_INT;
drop table  HEROES_PARAM_DIC;
drop table  HEROES;
*/
