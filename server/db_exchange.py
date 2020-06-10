import sqlalchemy as sa
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.dialects.postgresql import MONEY
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.exc import DataError
from sqlalchemy.dialects import postgresql
from sqlalchemy import not_, select, exists, update, UniqueConstraint, ForeignKeyConstraint, func
import psycopg2

from contextlib import contextmanager

import uuid as puuid
# from sqlalchemy.types import JSON
import json

Base = declarative_base()
DB_PATH = 'postgresql://backend:54321@80.65.23.35:9988/postgres'


class DBManager(object):
    """Правильная работа с engine
    вызывать get_db_session() у экземпляра класса"""

    def __init__(self):
        self.con_string = 'postgresql://backend:54321@80.65.23.35:9988/postgres'

        self.engine = self.create_db_engine()

    def get_database_connection_string(self):
        db_url = self.con_string
        return db_url

    def create_db_engine(self):
        connection_url = self.get_database_connection_string()
        return sa.create_engine(connection_url)

    def create_db_session(self):
        Session = sessionmaker()
        Session.configure(bind=self.engine)
        dbsession = Session()
        return dbsession

    def get_db_session(self):
        session = self.create_db_session()
        return session


class Player(Base):
    __tablename__ = 'players'
    guid_player = sa.Column(sa.Integer, primary_key=True)
    first_name = sa.Column(sa.VARCHAR)
    mid_name = sa.Column(sa.VARCHAR)
    last_name = sa.Column(sa.VARCHAR)
    mail = sa.Column(sa.VARCHAR)
    password_pl = sa.Column(sa.VARCHAR)


class Hero(Base):
    """"guid_player должен совпадать с guid пользователя, которому он принадлежит"""
    __tablename__ = "heroes"
    id_hero = sa.Column(sa.Integer, primary_key=True, autoincrement=True,
                        unique=True,
                        nullable=False)
    name_hero = sa.Column(sa.VARCHAR)
    id_race = sa.Column(sa.Integer)  # sa.Column(sa.ForeignKey('heroes_races_dic'))
    level_hero = sa.Column(sa.Integer)
    id_class = sa.Column(sa.Integer)
    sex = sa.Column(sa.VARCHAR)
    currentexp = sa.Column(sa.Integer)
    height = sa.Column(sa.Integer)
    weight = sa.Column(sa.Integer)
    size = sa.Column(sa.Integer)
    vision = sa.Column(sa.Integer)
    language_hero = sa.Column(sa.Integer)
    guid_player = sa.Column(sa.Integer)

    def convert_json(self):
        return json.dumps({'id_hero': self.id_hero, 'name_hero': self.name_hero.capitalize(),
                           'level_hero': self.level_hero, 'id_class': self.id_class, 'id_race': self.id_race},
                          ensure_ascii=False)


class Classes(Base):
    __tablename__ = "heroes_class_dic"
    id_class = sa.Column(sa.ForeignKey('heroes.id_class'), primary_key=True)
    name_class = sa.Column(sa.VARCHAR)

    def convert_json(self):
        return json.dumps({'id_class': self.id_class, 'name_class': self.name_class.capitalize()}, ensure_ascii=False)


class Races(Base):
    __tablename__ = "heroes_races_dic"
    id_race = sa.Column(sa.ForeignKey('heroes.id_race'), primary_key=True)
    name_race = sa.Column(sa.VARCHAR)
    count_languages = sa.Column(sa.Integer)
    language_default = sa.Column(sa.Integer)

    def __repr__(self):
        return f"'id_race': {self.id_race}, 'name_race':{self.name_race}"

    def convert_json(self):
        return json.dumps({'id_race': self.id_race, 'name_race': self.name_race.capitalize()}, ensure_ascii=False)


class MainStats(Base):
    __tablename__ = 'heroes_param_addfl_array'
    id_hero = sa.Column(sa.ForeignKey("heroes.id_hero"), primary_key=True)
    id_param = sa.Column(sa.Integer, primary_key=True)
    modify_param = sa.Column(sa.Integer)
    field_int = sa.Column(sa.Integer)
    field_string = sa.Column(sa.VARCHAR)
    field_money = sa.Column(MONEY)
    training = sa.Column(sa.BOOLEAN)

    def __repr__(self):
        return str([getattr(self, c.name, None) for c in self.__table__.c])

    def convert_json(self):
        return json.dumps({'id_param': self.id_param, 'training': self.training, 'field_int': self.field_int,
                           'field_string': self.field_string,
                           'field_money': self.field_money, 'modify_param': self.modify_param}, ensure_ascii=False)
            # {'id_param': self.id_param, 'training': self.training, 'field_int': self.field_int,
            #                'field_string': self.field_string,
            #                'field_money': self.field_money, 'modify_param': self.modify_param}, ensure_ascii=False)


def compile_query(query):
    compiler = query.compile if not hasattr(query, 'statement') else query.statement.compile
    return compiler(dialect=postgresql.dialect())


def upsert(session, model, rows, new_int='field_int', new_modif="modify_param", no_update_cols=[]):
    table = model.__table__

    stmt = insert(table).values(rows)

    update_cols = [c.name for c in table.c
                   if c not in list(table.primary_key.columns)
                   and c.name not in no_update_cols]

    on_conflict_stmt = stmt.on_conflict_do_update(
        index_elements=table.primary_key.columns,
        set_={k: getattr(stmt.excluded, k) for k in update_cols},
        index_where=(getattr(model, new_int) != getattr(stmt.excluded, new_int)))

    session.execute(on_conflict_stmt)


class HeroesParamDic(Base):
    __tablename__ = 'heroes_param_dic'
    id_param = sa.Column(sa.Integer, primary_key=True)
    id_type_param = sa.Column(sa.Integer, nullable=False)
    name_param = sa.Column(sa.VARCHAR)
    short_name_field = sa.Column(sa.VARCHAR)

    def __repr__(self):
        return f"'id_param: {self.id_param}, 'id_type_param':{self.id_type_param}, 'name_param':{self.name_param}, 'short_name_field':{self.short_name_field} "

    def convert_json(self):
        return json.dumps(
            {'id_param': self.id_param, 'name_param': self.name_param.capitalize(), 'id_type_param': self.id_type_param,
             'short_name_field': self.short_name_field}, ensure_ascii=False)
    ##return json.dumps({'id_param': {self.id_param}, 'id_type_param':{self.id_type_param}, 'name_param':{self.name_param.capitalize()}, 'short_name_field':{self.short_name_field}}, ensure_ascii=False)


def connect_db():
    engine = sa.create_engine(DB_PATH)
    Base.metadata.create_all(engine)
    sessions = sessionmaker(engine)
    return sessions()


@contextmanager
def session_scope():
    """Контекст для закрывания сессий по завершению работы
    и откату изменений при ошибке"""
    # session_manager = DBManager()
    # session = session_manager.get_db_session()
    session = connect_db()
    try:
        yield session
        session.commit()
    except:
        session.rollback()
        raise
    finally:
        session.close()


def read_classes_races_etc():
    """Получаем id-name классов и расс, upd: зрения, размеров, языков. Все для выпадающих список персонажа
    результат в формате {'name_field': str, 'id_field': int}"""

    with session_scope() as session:
        class_query = session.query(Classes).all()
        race_query = session.query(Races).all()

        vision_query = session.query(HeroesParamDic).filter(HeroesParamDic.id_type_param == 3).all()
        sizes_query = session.query(HeroesParamDic).filter(HeroesParamDic.id_type_param == 5).all()
        lang_query = session.query(HeroesParamDic).filter(HeroesParamDic.id_type_param == 4).all()
        race_result = []
        vision_result = []
        sizes_result = []
        lang_result = []
        class_result = []
        for i in race_query:
            race_result.append(i.convert_json())

        for i in class_query:
            class_result.append(i.convert_json())

        for i in vision_query:
            vision_result.append(i.convert_json())

        for i in sizes_query:
            sizes_result.append(i.convert_json())

        for i in lang_query:
            lang_result.append(i.convert_json())

        result = {'classes': class_result, "races": race_result, 'sizes': sizes_result, "vision": vision_result,
                  "language": lang_result}

        session.close()
        return result


# a = read_classes_races()


def read_stats():
    """Получаем id-name полей статов"""
    with session_scope() as session:
        main_stats = session.query(HeroesParamDic).filter(HeroesParamDic.id_type_param == int(1)).all()
        secondary_stats = session.query(HeroesParamDic).filter(HeroesParamDic.id_type_param == int(2)).all()
        main_stats_result = {i.id_param: f'{i.name_param.capitalize()}-base' for i in main_stats}
        secondary_stats_result = {i.id_param: i.name_param.lower() for i in secondary_stats}
        result = {}
        result['main_stats'] = main_stats_result
        result['secondary_stats'] = secondary_stats_result

        return result


def read_player(mail):
    """Запрос guid пользователя по email"""
    with session_scope() as session:
        try:
            guid = session.query(Player).filter(Player.mail == mail).first().guid_player
        except AttributeError:
            guid = write_data_player(**superuser)
        return guid


def write_data_player(**kwargs):
    """Запись нового пользователя. Проверка на уникальность через mail.
    Функция возвращает guid_player в виде объекта UUID"""
    with session_scope() as session:
        print("WRITE DATA PLAYER")
        try:
            for playr in session.query(Player).order_by(Player.mail):
                if playr.mail == kwargs['mail']:
                    print(f'user {playr.first_name} already exists')
                    return playr.guid_player
        except (KeyError, DataError):
            return print('keyerror')
        try:
            new_player = insert(Player).returning(Player.guid_player).values(**kwargs)  # Player(**kwargs)
        except (KeyError, DataError):
            return print(f'Ошибка {kwargs}')
        current_guid = session.execute(new_player)
        result = current_guid.fetchall()
        return result


def write_data_hero(guid, id_hero=None, **kwargs):
    """Принимаем guid пользователя, добавляем связанного с ним героя
    возвращает id вновь созданного героя"""
    # TODO: придумать как не дать делать новую запись если перс уже есть

    with session_scope() as session:
        print("WRITE DATA HERO")
        if id_hero:
            update_hero(guid, id_hero, **kwargs)

        else:
            try:
                # new_hero = Hero(**kwargs, guid_player=guid)

                new_hero = insert(Hero).returning(Hero.id_hero).values(**kwargs, guid_player=guid)
                rproxy = session.execute(new_hero)
                session.commit()

                id_hero = rproxy.fetchone()
                session.close()
                print('ID HERO', id_hero)
                res = 0
                for i in id_hero:
                    res = i

                return {'hero': res, 'status': 'created'}

            except ValueError:
                return print(f'Ошибка при записи персонажа!')


def update_hero(guid, id_hero, stats):
    data = []

    for st in stats:

        st['id_hero'] = id_hero
        print('stats', st)

        data.append({k: v for k, v in st.items() if
                     k in ['id_hero', 'id_param', 'training', 'field_int', 'field_string', 'field_money',
                           'modify_param']})

    with session_scope() as session:
        upsert(session, MainStats, data, no_update_cols=['id_hero'])
        session.commit()


def select_all_heroes(guid):
    """По GUID пользователя читаем всех доступных ему персов"""
    with session_scope() as session:
        hers = session.query(Hero).filter(Hero.guid_player == guid).all()
        available_hers = []
        for i in hers:
            curr_res = {}
            for key in i.__dict__.keys():
                if key != '_sa_instance_state' and key != 'guid_player':
                    curr_res[key] = i.__dict__[key]
            available_hers.append(curr_res)
    return available_hers





def get_preview_hero(uid):
    """Отладочная функция. Выбирает всех персонажей в базе"""
    with session_scope() as session:
        tables = session.query(Hero, Races, Classes).filter(Hero.guid_player == uid).filter(
            Hero.id_race == Races.id_race, Hero.id_class == Classes.id_class).all()
        res = []
        for hero, race, clas in tables:
            res.append(
                {"id_hero": hero.id_hero, "name_hero": hero.name_hero, "class_hero": clas.name_class.capitalize(),
                 "hero_level": hero.level_hero})

        return res


def hero_main_stats(id, **kwargs):
    """Запись основных характеристик героя"""
    with session_scope() as session:
        insrt = insert(MainStats).values(id_hero=id, **kwargs)
        do_update = insrt.on_conflict_do_update(index_elements=['id_hero', 'id_param'],
                                                set_=dict(training=kwargs['training'],
                                                          field_int=kwargs['field_int'],
                                                          field_money=kwargs['field_money']))

        session.execute(do_update)


def read_hero_params(id_hero):
    with session_scope() as session:
        result = []
        hero_stats = session.query(MainStats).filter(MainStats.id_hero == id_hero).all()
        for stat in hero_stats:

            result.append(stat.convert_json())

        return result


def select_one_hero(guid, id):
    """"Выбор героя по гуид пользователя и ид героя"""

    for i in select_all_heroes(guid):
        if i["id_hero"] == int(id):
            print('one_hero', i)

            return i


# --------------DATA FOR TESTS---------------
superuser = {
    'guid_player': puuid.uuid1(),
    'first_name': 'superuser',
    'mid_name': '',
    'last_name': '',
    'mail': 'superuser@mail.ru',
    'password_pl': '21q2w3e4r'
}

her_common = {'name_hero': 'ZINA_HERO',
              'level_hero': 1,
              'id_race': 5,
              'id_class': 2,
              'sex': "bls",
              'currentexp': 200,
              'height': 230,
              'weight': 250, 'size': 3,
              'vision': 1, 'language_hero': 6,
              }
her_stats = {
    'id_hero': 15,
    'training': False,
    'field_int': 2,
    'field_string': None,
    'field_money': None
}

# --------------DATA FOR TESTS---------------

# ------------------TESTS---------------------
# #DB_PATH = 'postgresql://backend:54321@80.65.23.35:9988/postgres'
# engine = sa.create_engine((DB_PATH))
# ses = engine.raw_connection()
# curs = ses.cursor()
# #curs.execute('CALL create_table();')
# curs.execute('CALL insert_into_table()')
# ses.commit()
# ses.close()
#
# write_data_player(**player)
# a = write_data_hero(read_player(player['mail']), **her_common)


# herid = select_one_hero(read_player(player['mail']), her_common['id_hero'])
# current_player = read_player('zina@korzina.ru')
# hero_main_stats( 6, **her_stats)
#
# current_player = read_player('zina@korzina.ru')
# heroes = select_all_heroes(current_player)


# h = select_one_hero(current_player, heroes[0].id_hero)
# print(h)
# print(heroes)
# for i in heroes:
#     for stat in i:
#         print(stat)


# try:
#     session.add(MainStats(id_hero=id, **kwargs))
#     session.commit()
#
# except IntegrityError:
# print('HELLO')
# her = session.query(MainStats).filter(MainStats.id_hero == id).filter(
#     MainStats.id_field == kwargs['id_field']).first()
# print(her)
#
# her_updt = (update(MainStats).where(MainStats.id_field == kwargs['id_field'], MainStats.id_hero == id).values(training=kwargs['training'],
#                                                                         field_int=kwargs['field_int'],
#                                                                         field_money=kwargs['field_money']))
# print(her_updt)
# updtd = update(her).where(her.id_hero == id).values(**kwargs)
