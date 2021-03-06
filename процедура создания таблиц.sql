﻿CREATE OR REPLACE PROCEDURE public.create_table (
)
AS
$body$
DROP TABLE IF EXISTS HEROES cascade;
DROP TABLE IF EXISTS PLAYERS cascade;
DROP TABLE IF EXISTS HEROES_RACES_DIC cascade;
DROP TABLE IF EXISTS HEROES_CLASS_DIC cascade;
DROP TABLE IF EXISTS HEROES_TYPE_PARAM_DIC cascade;
DROP TABLE IF EXISTS HEROES_PARAM_DIC cascade;
DROP TABLE IF EXISTS HEROES_PARAM_ADDFL_ARRAY cascade;
DROP TABLE IF EXISTS HEROES_LANGUAGE_DIC cascade;
DROP TABLE IF EXISTS HEROES_VISION_DIC cascade;
DROP TABLE IF EXISTS HEROES_SIZE_DIC cascade;
DROP TABLE IF EXISTS RACE_PARAM_DEFAULT CASCADE;

CREATE TABLE PLAYERS
(
	GUID_PLAYER    UUID NOT NULL PRIMARY KEY
	,FIRST_NAME     VARCHAR(100)
	,MID_NAME      VARCHAR(100)
	,LAST_NAME     VARCHAR(100)
    ,MAIL          VARCHAR(100)
	,PASSWORD_PL   bytea
);
CREATE TABLE HEROES_CLASS_DIC
(ID_CLASS  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_CLASS VARCHAR(30) NOT NULL
);
/*
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
*/

CREATE TABLE HEROES_RACES_DIC
(ID_RACE  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
	,NAME_RACE VARCHAR(30) NOT NULL
/*	,ID_FIELD_LANG        INT REFERENCES HEROES_LANGUAGE_DIC(ID_FIELD)
	,ID_FIELD_VISION      INT REFERENCES HEROES_VISION_DIC(ID_FIELD)
	,ID_FIELD_SIZE        INT REFERENCES HEROES_SIZE_DIC(ID_FIELD)*/
);



CREATE TABLE HEROES
(
	ID_HERO    		  INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY
   ,NAME_HERO         VARCHAR(50)
   ,ID_RACE           INT  REFERENCES HEROES_RACES_DIC(ID_RACE)
   ,LEVEL_HERO        INT
   ,ID_CLASS          INT REFERENCES HEROES_CLASS_DIC(ID_CLASS)
   ,SEX               VARCHAR(20)
   ,CURRENTEXP        INT
   ,HEIGHT            INT
   ,WEIGHT            INT
   ,SIZE              INT
   ,VISION            INT
   ,LANGUAGE_HERO     INT
   ,GUID_PLAYER       UUID NOT NULL references PLAYERS
);

CREATE TABLE HEROES_TYPE_PARAM_DIC
(ID_TYPE_PARAM   INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,NAME_TYPE_PARAM varchar(20) NOT NULL);

CREATE TABLE HEROES_PARAM_DIC
(ID_PARAM  INT  GENERATED ALWAYS AS IDENTITY  PRIMARY KEY
,ID_TYPE_PARAM int NOT NULL REFERENCES HEROES_TYPE_PARAM_DIC(ID_TYPE_PARAM)
,NAME_PARAM VARCHAR(30) NOT NULL
,SHORT_NAME_FIELD varchar(10));


CREATE TABLE HEROES_PARAM_ADDFL_ARRAY
(
	ID_HERO       INT REFERENCES HEROES
   ,ID_PARAM      INT REFERENCES HEROES_PARAM_DIC
   ,TRAINING      BOOL 	NOT NULL
   ,FIELD_INT     INT
   ,FIELD_STRING  VARCHAR(100)
   ,FIELD_MONEY   MONEY
   ,MODIFY_PARAM  int
   ,PRIMARY KEY (ID_HERO ,ID_PARAM ));

CREATE TABLE RACE_PARAM_DEFAULT
(
	ID_RACE              INT REFERENCES HEROES_RACES_DIC(ID_RACE)
   ,ID_PARAM             INT REFERENCES HEROES_PARAM_DIC(ID_PARAM)
   ,FIELD_DEFAULT        INT
   ,ADD_PARAM_CHOICE     BOOL
   ,ADD_PARAM_DEFAULT    BOOL
   ,PRIMARY KEY (ID_RACE ,ID_PARAM ));
$body$
LANGUAGE 'sql'
SECURITY INVOKER;


ALTER PROCEDURE public.create_table ()
  OWNER TO postgres;
