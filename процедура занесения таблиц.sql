CREATE OR REPLACE PROCEDURE public.insert_into_table (
)
AS
$body$
BEGIN


insert into  HEROES_TYPE_PARAM_DIC(NAME_TYPE_PARAM)
SELECT 'ОСНОВНЫЕ'
union
SELECT 'ВТОРИЧНЫЕ'
union
SELECT 'ЯЗЫК'
union
SELECT 'ЗРЕНИЕ'
union
SELECT 'РАЗМЕР';

INSERT INTO HEROES_PARAM_DIC(ID_TYPE_PARAM, NAME_PARAM,SHORT_NAME_FIELD )
	select ID_TYPE_PARAM ,'STRENGTH','STR' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT ID_TYPE_PARAM,'STAMINA','STA' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT ID_TYPE_PARAM,'AGILITY','AGL' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT ID_TYPE_PARAM,'INTELLECT','INT' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT ID_TYPE_PARAM,'WISDOME','WSD' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT ID_TYPE_PARAM,'CHARISMA' ,'CHA' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ОСНОВНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'DUNGEONS','DNG' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'HEALINGCHARS' ,'HEAL' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'INTIMIDATION','INTD' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM, 'ENDURANCE','EDNU' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'CONVERSATION','CONVR' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'STEALTH','STL' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'INSIGHT','INSG' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'MAGIC','MAGIC' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'ATHLETICS','ATHL' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'ACROBATICS','ACRB' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'DECEPTION','DCPT' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'NATURE','NATUR' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'THEF','THEF' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'STREETS','STRTS' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'ATTENTION','ATT' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'RELIGION','REL' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
	UNION SELECT  ID_TYPE_PARAM,'HISTORY','HIST' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ВТОРИЧНЫЕ'
  	UNION SELECT  ID_TYPE_PARAM,'ОБЩИЙ','COMMON_L' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЯЗЫК'
   	UNION SELECT  ID_TYPE_PARAM,'глубинный','DEEP_L' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЯЗЫК'
   	UNION SELECT  ID_TYPE_PARAM,'дварфский','DWARF_L' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЯЗЫК'
   	UNION SELECT  ID_TYPE_PARAM,'драконий','DRAKE_L' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЯЗЫК'
  	UNION SELECT  ID_TYPE_PARAM,'эльфийский','ELF_L' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЯЗЫК'
   	UNION SELECT  ID_TYPE_PARAM,'сумеречное','DARK_V' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЗРЕНИЕ'
   	UNION SELECT  ID_TYPE_PARAM,'ОБЫЧНОЕ','COMMON_V' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='ЗРЕНИЕ'
   	UNION SELECT  ID_TYPE_PARAM,'средний','COMMON_V' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='РАЗМЕР'
   	UNION SELECT  ID_TYPE_PARAM,'маленький','COMMON_V' FROM HEROES_TYPE_PARAM_DIC where  NAME_TYPE_PARAM ='РАЗМЕР'
	order by  1 desc;
INSERT INTO HEROES_RACES_DIC (NAME_RACE)
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
INSERT INTO HEROES_CLASS_DIC(NAME_CLASS)
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

insert into  RACE_PARAM_DEFAULT (ID_RACE,ID_PARAM,FIELD_DEFAULT,ADD_PARAM_CHOICE,ADD_PARAM_DEFAULT)
 SELECT  hr.ID_RACE,hp.ID_PARAM,10,
CASE when  hr.NAME_RACE in ('ДРАКОНОРОЖДЁННЫЙ','ДВАРФ','ЧЕЛОВЕК','ПОЛУОРК') Then TRUE else FALSE END
,FALSE
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'STRENGTH'
union
 SELECT  hr.ID_RACE,hp.ID_PARAM,10,
CASE when  hr.NAME_RACE in ('ТИФЛИНГ','ДРАКОНОРОЖДЁННЫЙ','ПОЛУРОСЛИК','ЧЕЛОВЕК','ПОЛУОРК', 'ДРЕВЕНЬ','МИНОТАВР') Then  TRUE else FALSE END
,CASE when  hr.NAME_RACE in ('ДВАРФ','ПОЛУЭЛЬФ') Then TRUE else FALSE END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'STAMINA'
union
 SELECT  hr.ID_RACE,hp.ID_PARAM,10,
CASE when  hr.NAME_RACE in ('ЭЛАДРИН','ЧЕЛОВЕК','ГИТЗЕРАЙ', 'ДРЕВЕНЬ') Then  TRUE else FALSE END
,CASE when  hr.NAME_RACE in ('ПОЛУРОСЛИК','ЭЛЬФ') Then TRUE else FALSE END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'AGILITY'
union
 SELECT  hr.ID_RACE,hp.ID_PARAM,10,
CASE when  hr.NAME_RACE in ('ТИФЛИНГ','ЧЕЛОВЕК','ГИТЗЕРАЙ', 'ЭЛЬФ') Then TRUE else FALSE END
,CASE when  hr.NAME_RACE in ('ЭЛАДРИН') Then TRUE else FALSE END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'INTELLECT'
union
 SELECT  hr.ID_RACE,hp.ID_PARAM,10,
CASE when  hr.NAME_RACE in ('ДВАРФ','ЧЕЛОВЕК','ЭЛЬФ', 'ПОЛУЭЛЬФ','МИНОТАВР','ШАРДМАЙНД') Then  TRUE else FALSE END
, FALSE
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'WISDOME'
union
 SELECT  hr.ID_RACE,hp.ID_PARAM,8,
CASE when  hr.NAME_RACE in ('ПОЛУЭЛЬФ','ЭЛАДРИН','ПОЛУРОСЛИК', 'ЧЕЛОВЕК','ШАРДМАЙНД') Then TRUE else FALSE END
,CASE when  hr.NAME_RACE in ('ТИФЛИНГ','ДРАКОНОРОЖДЁННЫЙ') Then  TRUE else FALSE END
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr
			where hp.NAME_PARAM = 'CHARISMA';

insert into  RACE_PARAM_DEFAULT (ID_RACE,ID_PARAM,ADD_PARAM_CHOICE)
 SELECT  hr.ID_RACE,hp.ID_PARAM,TRUE
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr,heroes_type_param_dic htpd
  			where hp.ID_TYPE_PARAM = htpd.id_type_param
            and htpd.NAME_TYPE_PARAM = 'ЯЗЫК' and hp.NAME_PARAM IN('дварфский' ,'великаний' )
            and hr.NAME_RACE in ('ТИФЛИНГ','ПОЛУРОСЛИК','ЧЕЛОВЕК','ДЕВ','МИНОТАВР','ШАРДМАЙНД','Голиаф')
UNION
 SELECT  hr.ID_RACE,hp.ID_PARAM,TRUE
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr,heroes_type_param_dic htpd
  			where hp.ID_TYPE_PARAM = htpd.id_type_param
            and htpd.NAME_TYPE_PARAM = 'ЯЗЫК' and hp.NAME_PARAM in ('глубинный','драконий','эльфийский')
            and NAME_RACE in ('ТИФЛИНГ','ПОЛУРОСЛИК','ЧЕЛОВЕК','ДЕВ','МИНОТАВР','ШАРДМАЙНД')  ;
insert into  RACE_PARAM_DEFAULT (ID_RACE,ID_PARAM,ADD_PARAM_DEFAULT)
 SELECT  hr.ID_RACE,hp.ID_PARAM,TRUE
  FROM  HEROES_PARAM_DIC hp,HEROES_RACES_DIC hr,heroes_type_param_dic htpd
  			where hp.ID_TYPE_PARAM = htpd.id_type_param
            and htpd.NAME_TYPE_PARAM = 'ЯЗЫК' and hp.NAME_PARAM in ('глубинный','драконий','эльфийский')
            and NAME_RACE in ('ТИФЛИНГ','ПОЛУРОСЛИК','ЧЕЛОВЕК','ДЕВ','МИНОТАВР','ШАРДМАЙНД')  ;
end;
$body$
LANGUAGE 'plpgsql'
SECURITY INVOKER;


ALTER PROCEDURE public.insert_into_table ()
  OWNER TO postgres;
