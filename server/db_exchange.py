import sqlalchemy as sa
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.dialects.postgresql import MONEY
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.exc import DataError

import uuid as puuid
# from sqlalchemy.types import JSON
import json

Base = declarative_base()
DB_PATH = 'postgresql://backend:54321@80.65.23.35:9988/postgres'


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
    id_race = sa.Column(sa.Integer) #sa.Column(sa.ForeignKey('heroes_races_dic'))
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
                           'level_hero' : self.level_hero, 'id_class' : self.id_class, 'id_race' : self.id_race}, ensure_ascii=False)


class Classes(Base):
    __tablename__ = "heroes_class_dic"
    id_field = sa.Column(sa.ForeignKey('heroes.id_class'), primary_key=True)
    name_field = sa.Column(sa.VARCHAR)

    def convert_json(self):
        return json.dumps({'id_field': self.id_field, 'name_field': self.name_field.capitalize()}, ensure_ascii=False)


class Races(Base):
    __tablename__ = "heroes_races_dic"
    id_field = sa.Column(sa.ForeignKey('heroes.id_race'), primary_key=True)
    name_field = sa.Column(sa.VARCHAR)

    def __repr__(self):
        return f"'id_field': {self.id_field}, 'name_field':{self.name_field}"

    def convert_json(self):
        return json.dumps({'id_field': self.id_field, 'name_field': self.name_field.capitalize()}, ensure_ascii=False)


class MainStats(Base):
    __tablename__ = 'heroes_param_addfl_array'
    id_hero = sa.Column(sa.ForeignKey("heroes.id_hero"), primary_key=True)
    id_field = sa.Column(sa.Integer)

    field_int = sa.Column(sa.Integer)
    field_string = sa.Column(sa.VARCHAR)
    field_money = sa.Column(MONEY)
    training = sa.Column(sa.BOOLEAN)


class HeroesParamDic(Base):
    __tablename__ = 'heroes_param_dic'
    id_field = sa.Column(sa.Integer, primary_key=True)
    main_param = sa.Column(sa.BOOLEAN, nullable=False)
    name_field = sa.Column(sa.VARCHAR)
    short_name_field = sa.Column(sa.VARCHAR)


def connect_db():
    engine = sa.create_engine(DB_PATH)
    Base.metadata.create_all(engine)
    sessions = sessionmaker(engine)
    return sessions()


# <Сияние чистого ебланства>
# def get_gen_rc(cq):
#     """Получение генератора, для рас или классов. На вход query объект,
#     дальше вызывается функцией validate_rc чтоб скомпоновать данные"""
#     index = 0
#     res = {}
#     for q in cq:
#         for k, v in q.__dict__.items():
#             if type(v) == str or type(v) == int:
#                 if type(v) == str:
#                     res[str(index)] = {str(k): v.capitalize()}
#                 else:
#                     res[str(index)] = {str(k): v}
#                 yield res
#                 index += 1
#
# def validate_rc(gen):
#     """Генератор записывает всё в i"""
#     for i in gen:
#         continue
#     cntr = 0
#     res_clases = {}
#     while cntr < len(i):
#         res_clases[str(cntr)] = {**i[str(cntr)], **i[str(cntr + 1)]}
#         cntr += 2
#     return res_clases
# </Сияние чистого ебланства>


def read_classes_races():
    """Получаем id-name классов и расс
    результат в формате {'name_field': str, 'id_field': int}"""

    session = connect_db()

    class_query = session.query(Classes).all()
    race_query = session.query(Races).all()
    race_result = []

    for i in race_query:
        race_result.append(i.convert_json())

    class_result = []

    for i in class_query:
        class_result.append(i.convert_json())

    result = {'classes': class_result, "races": race_result}
    return result


# a = read_classes_races()


def read_stats():
    """Получаем id-name полей статов"""
    session = connect_db()
    main_stats = session.query(HeroesParamDic).filter(HeroesParamDic.main_param == 't').all()
    secondary_stats = session.query(HeroesParamDic).filter(HeroesParamDic.main_param == 'f').all()
    main_stats_result = {i.id_field: f'{i.name_field.lower()}-base' for i in main_stats}
    secondary_stats_result = {i.id_field: i.name_field.lower() for i in secondary_stats}
    result = {}
    result['main_stats'] = main_stats_result
    result['secondary_stats'] = secondary_stats_result
    return result


def read_player(mail):
    """Запрос guid пользователя по email"""
    session = connect_db()
    guid = session.query(Player).filter(Player.mail == mail).first().guid_player
    return guid



def write_data_player(**kwargs):
    """Запись нового пользователя. Проверка на уникальность через mail.
    Функция возвращает guid_player в виде объекта UUID"""
    session = connect_db()
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
    session.commit()
    return current_guid.fetchall()


def write_data_hero(guid, **kwargs):
    """Принимаем guid пользователя, добавляем связанного с ним героя
    возвращает id вновь созданного героя"""
    # TODO: придумать как не дать делать новую запись если перс уже есть
    session = connect_db()
    print("WRITE DATA HERO")

    try:
        # new_hero = Hero(**kwargs, guid_player=guid)
        new_hero = insert(Hero).returning(Hero.id_hero).values(**kwargs, guid_player=guid)
        rproxy = session.execute(new_hero)
        session.commit()

        id_hero = rproxy.fetchone()
        print('ID HERO', id_hero)
        res = 0
        for i in id_hero:
            res = i
        print('NHIDdsada', res)
        return res

    except ValueError:
        return print(f'Ошибка при записи персонажа!')

def update_hero(guid, id_hero, **kwargs):
    session = connect_db()
    herlist = select_all_heroes(guid)
    for i in herlist:
        print(f"send_name {kwargs['name_hero']}-{type(kwargs['name_hero'])} eq {i.name_hero}-{type(i.name_hero)}"
              f" send class {kwargs['id_class']}-{type(kwargs['id_class'])} {i.id_class}-{type(str(i.id_class))}"
              f"send race {kwargs['id_race']}-{type(kwargs['id_race'])} {i.id_race}-{type(str(i.id_race))}")
        if (str(kwargs['name_hero']) == str(i.name_hero)) and (str(kwargs['id_class']) == str(i.id_hero)) and (
                str(kwargs['id_race']) == str(i.id_race)):
            print('SAMEEE')
            insrt = insert(Hero).values(guid_player=guid, **kwargs)
            do_update = insrt.on_conflict_do_update(index_elements=['id_hero'],
                                                    set_=dict(**kwargs))

            session.execute(do_update)
            session.commit()
            print(f'hero {i.name_hero} already exists')
            return i.id_hero


def select_all_heroes(guid):
    """По GUID пользователя читаем всех доступных ему персов"""
    session = connect_db()
    hers = session.query(Hero).filter(Hero.guid_player == guid).all()
    available_hers = []
    for i in hers:
        curr_res = {}
        for key in i.__dict__.keys():
            if key != '_sa_instance_state' and key != 'guid_player':
                curr_res[key] = i.__dict__[key]

        available_hers.append(curr_res)
    print(available_hers)
    return available_hers

def get_preview_hero(uid):
    """Отладочная функция. Выбирает всех персонажей в базе"""
    session = connect_db()
    tables = session.query(Hero, Races, Classes).filter(Hero.guid_player==uid).filter(Hero.id_race == Races.id_field, Hero.id_class == Classes.id_field).all()
    res = []
    for hero, race, clas in tables:
        res.append({"id_hero":hero.id_hero, "name_hero":hero.name_hero, "class_hero":clas.name_field.capitalize(), "hero_level":hero.level_hero})
    return res


def hero_main_stats(id, **kwargs):
    """Запись основных характеристик героя"""
    session = connect_db()
    insrt = insert(MainStats).values(id_hero=id, **kwargs)
    do_update = insrt.on_conflict_do_update(index_elements=['id_hero', 'id_field'],
                                            set_=dict(training=kwargs['training'],
                                                      field_int=kwargs['field_int'],
                                                      field_money=kwargs['field_money']))

    session.execute(do_update)
    session.commit()


def select_one_hero(guid, id):
    """"Выбор героя по гуид пользователя и ид героя"""
    for i in select_all_heroes(guid):
       #print(i, type(i.id_hero))
       # print(type(id))

        if i["id_hero"] == int(id):
            return i


# --------------DATA FOR TESTS---------------
player = {
    'guid_player': puuid.uuid1(),
    'first_name': 'Zina',
    'mid_name': '',
    'last_name': 'Korzina',
    'mail': 'a@korfdsfszina.ru',
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
    'id_field': 15,
    'training': False,
    'field_int': 2,
    'field_string': None,
    'field_money': None
}


# --------------DATA FOR TESTS---------------

# ------------------TESTS---------------------
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
