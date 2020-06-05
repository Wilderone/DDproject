import psycopg2
import sqlalchemy as sa
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import xlrd
from pandas import *


def connect_base():
    con = psycopg2.connect(
        database="postgres",
        user="postgres",
        password="3955458",
        host="127.0.0.1",
        port="5432"
    )
    print("Database opened successfully")
    return con


def create_table(con, table_name, fields_xl):
    cur = con.cursor()

    fields_str = []
    for each_key in fields_xl.keys():
        if fields_str != []:
            fields_str.append(', ')
        fields_str.append(each_key)
        fields_str.append(' ')
        for each_item in range(fields_xl[each_key].__len__()):
            fields_str.append(str(fields_xl[each_key][each_item]))
            # type_str.append(' ')
        # print(type_str)
    query_text = 'CREATE TABLE ' + table_name + ' (' + ''.join(fields_str) + ');'
    # print(query_text)
    cur.execute(query_text)
    con.commit()
    print("Table created successfully")


def drop_table(con, table_name):
    cur = con.cursor()
    cur.execute(f'DROP TABLE {table_name};')
    con.commit()
    print("Table droped successfully")


def insert_table(con, table_name, data_xl):
    cur = con.cursor()

    fields_name = ','.join(data_xl.keys())
    fields_list = fields_name.split(',')
    # print(data_xl[fields_list[0]].__len__())
    for each_item in range(data_xl[fields_list[0]].__len__()):
        data_str = []
        for each_key in data_xl.keys():
            data_str.append(str(data_xl[each_key][each_item]))
        # print("'" + "', '".join(data_str) + "'")
        query_text = 'INSERT INTO ' + table_name + ' (' + ', '.join(data_xl.keys()) + ') VALUES (' + "'" + "', '".join(
            data_str) + "'" + ')'
        # print(query_text)
        cur.execute(query_text)

    con.commit()
    print('insert complite')


def print_value(con, table_name):
    cur = con.cursor()
    val_print = cur.execute(
        f'SELECT * FROM {table_name}'
    )
    print(val_print)


def getdata_xlp(path_xl, sheet_name):
    xls = ExcelFile(path_xl)
    df = xls.parse(sheet_name)
    data_xl = df.to_dict()
    # print(data_xl)
    return data_xl


def getfields_xlp(path_xl, field_sheet_name):
    xls = ExcelFile(path_xl)
    df = xls.parse(field_sheet_name)
    fields_xl = df.to_dict()
    # print(fields_xl)
    return fields_xl


def main():
    # Путь к файлу Экселя
    path_xl = 'e:\wb_traits_base.xls'

    # Название листа с данными для заливки.
    # ВАЖНО: первая строка должна содержать названия полей в базе
    data_sheet_name = 'DATA'

    # Название листа с данными для названия полей в базе.
    field_sheet_name = 'FIELDS'

    # Название таблицы в базе.
    table_name = 'TRAITS_DIC'

    # ВАЖНО: переqди в connect_base и укажи данные для подключения к базе
    con = connect_base()

    fields_xl = getfields_xlp(path_xl, field_sheet_name)
    data_xl = getdata_xlp(path_xl, data_sheet_name)

    create_table(con, table_name, fields_xl)
    insert_table(con, table_name, data_xl)
    # drop_table(con, table_name)
    # print_value(con, table_name)

    con.close()


main()
