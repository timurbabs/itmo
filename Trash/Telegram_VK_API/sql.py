import sqlite3
from sqlite3 import Error


def post_sql_query(sql_query):
    with sqlite3.connect('data.sqlite3') as connection:
        cursor = connection.cursor()
        try:
            cursor.execute(sql_query)
        except Error as e:
            print(e, sql_query)
            return
        result = cursor.fetchall()
        return result


def create_tables():
    groups_query = '''CREATE TABLE IF NOT EXISTS GROUPS
                        (group_id INTEGER,
                        group_name TEXT,
                        user_id INTEGER
                        );'''
    users_query = '''CREATE TABLE IF NOT EXISTS USERS 
                            (logged BOOLEAN,
                            user_id INTEGER
                            );'''
    post_sql_query(groups_query)
    post_sql_query(users_query)


def logged_true(user_id):
    user_check_query = f'SELECT * FROM USERS WHERE user_id = {user_id};'
    user_check_data = post_sql_query(user_check_query)
    if user_check_data:
        update_user_db = f'UPDATE USERS SET logged = TRUE WHERE user_id = {user_id};'
        post_sql_query(update_user_db)
    else:
        logged = True
        update_user_db = f'INSERT INTO USERS (user_id, logged) VALUES ({user_id}, {logged});'
        post_sql_query(update_user_db)


def logged_check(user_id):
    user_check_query = f'SELECT * FROM USERS WHERE user_id = {user_id} and logged = TRUE;'
    user_check_data = post_sql_query(user_check_query)
    print(user_check_data)
    if user_check_data:
        return False
    else:
        return True


def add_group(user_id, group_id, group_name):
    user_check_query = f'SELECT * FROM GROUPS WHERE group_id = {group_id} and user_id = {user_id};'
    user_check_data = post_sql_query(user_check_query)
    print(user_check_data)
    if not user_check_data:
        insert_to_db_query = f'INSERT INTO GROUPS (group_id, group_name, user_id) VALUES ({group_id}, "{group_name}", {user_id}); '
        post_sql_query(insert_to_db_query)


def delete_group(user_id, group_id):
    user_check_query = f'SELECT * FROM GROUPS WHERE group_id = {group_id} and user_id = {user_id};'
    user_check_data = post_sql_query(user_check_query)
    if user_check_data:
        delete_from_db_query = f'DELETE FROM GROUPS WHERE group_id = {group_id} and user_id = {user_id};'
        post_sql_query(delete_from_db_query)


def list_group(user_id):
    result = []
    get_all_query = f'SELECT * FROM GROUPS WHERE user_id = {user_id};'
    for value in post_sql_query(get_all_query):
        result.append(value[1])
    return result


def group_filter(user_id):
    result = []
    get_all_query = f'SELECT * FROM GROUPS WHERE user_id = {user_id};'
    for value in post_sql_query(get_all_query):
        result.append(value[0])
    return result
