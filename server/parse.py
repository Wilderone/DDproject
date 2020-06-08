import json
import db_exchange as db
import uuid as puuid

class ParseRequest:
    def __init__(self, data):
        self.data = data

        self.common = data['common']
        self.main_stats = data['basicsLs']
        self.secondary_stats = data['secondaryChars']
        self.current_hero = None
        try:
            self.current_hero = self.common['curr_hero_id']
        except KeyError:
            self.current_hero =None
        self.curr_player = None

    def current_owner(self):
        owner_data = self.data['common']
        owner = {}
        owner['first_name']= owner_data['owner'],
        owner['last_name']= owner_data['owner'],
        owner['mail'] = f'{owner_data["owner"]}@email.ru'
        try:
            guid = db.read_player(owner['mail'])
            owner['guid_player'] = guid
        except AttributeError:

            owner['guid_player'] = puuid.uuid1()
        owner['password_pl'] = 'superpassword'
        curr_player = db.write_data_player(**owner)
        self.current_player = curr_player
        print('CURRENT GUID',self.current_player)
        return curr_player

    def write_hero_common(self):
        result = {**self.common['nameSexExp'], **self.common['heigWeigSize'], **self.common['visLang'], **self.common['common']}
        return db.write_data_hero(self.current_player, id_hero=self.current_hero, **result)

    def current_hero_id(self):
        if self.current_hero:
            return self.current_hero
        else:
            return self.write_hero_common()

    def parse_hero_main_stats(self):
        result = []
        for i in self.main_stats:
            result.append({**i})

        return result


    def parse_hero_sec_stats(self):
        result = []
        for i in self.secondary_stats:
            result.append({**i})

        return result

    # her_common = {'name_hero': '10?',
    #               'level_hero': 1,
    #               'race': 5,
    #               'class_hero': 2,
    #               'sex': "bls",
    #               'currentexp': 200,
    #               'height': 230,
    #               'weight': 250, 'size': 3,
    #               'vision': 1, 'language_hero': 6,
    #               }
    #
    # "common":{
    #     "owner":"superuser",
    #     "guid_player":"",
    #     "common":{
    #         "race":"",
    #         "sex":"1",
    #         "class":"3"
    #     },
    #     "nameSexExp":{
    #         "name":"хуй",
    #         "level":"выфв111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111фы",
    #         "currentExp":"всыфв"
    #     },
    #     "heigWeigSize":{
    #         "height":"сй",
    #         "weight":"сйвdsad",
    #         "size":"цсйц "
    #     },
    #     "visLang":{
    #         "vision":"выфвыфвфывф",
    #         "language":"выфвфывфв"
    #     }
    # },