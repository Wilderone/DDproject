from flask import Flask, redirect, url_for, request, render_template, session, make_response
from flask_cors import CORS, cross_origin
from waitress import serve
import db_exchange as db
from parse import ParseRequest as pr
import json

app = Flask(__name__)
app.config.from_json("config.json")
CORS(app)

@app.route('/', methods=["POST"])
@cross_origin()
def get_data():
    data = request.get_json()
    new_pr = pr(data['dfs'])
    current_user = new_pr.current_owner()
    hero_id = new_pr.write_hero_common()
    return {'current_user':current_user, 'hero_id':hero_id}

@app.route('/stats', methods=["GET"])
@cross_origin()
def send_stats():
    stat_list = db.read_stats()

    return stat_list

@app.route('/race_class', methods=["GET"])
@cross_origin()
def send_races_classes():
    # Отправка доступных к загрузке героев
    player = db.read_player('superuser@email.ru') #Временно. Для получения пока единственного пользователя
    result = {"player":player, "races_classes": db.read_classes_races()}
    return result

@app.route('/heroes', methods=["GET"])
@cross_origin()
def send_heroes():
    uid = json.loads(request.headers.get('uid'))['uid']


    #res = json.dumps(db.get_preview_hero())
    res = json.dumps(db.select_all_heroes(uid))

    return res

@app.route('/selhero', methods=["POST"])
@cross_origin()
def selhero():

    req = request.get_json()

    guid = req['uid']
    id_hero = req['id']
    print(id_hero)
    res = db.select_one_hero(guid, id_hero)


    return res

# app.run(host="localhost", port="5000", debug=True)
serve(app, host='192.168.0.14', port=5000)