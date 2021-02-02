import telebot
import sql
import re
from services import Vk


API_TOKEN = '1554735236:AAGFbtZPFVWCXf6aUmOt8xXOQm2C-FNnuiw'
bot = telebot.TeleBot(API_TOKEN)
sql.create_tables()


@bot.message_handler(commands=['start'])
def send_welcome(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    bot.reply_to(message, f"""\
    Hi there {message.from_user.username}, I am PostBot.
    """)


@bot.message_handler(commands=['add_group'])
def add_group(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    text = message.text
    try:
        group_id = text.split(' ')[1]
    except IndexError:
        bot.reply_to(message, f"""\
                    Need group id.
                    """)
        return
    group_id = int(re.search(r'\d+', group_id).group())
    group_name = Vk.get_group_name(group_id)
    sql.add_group(message.from_user.id, group_id, group_name)
    bot.reply_to(message, f"""\
        Group {group_name} successfully added.
        """)


@bot.message_handler(commands=['delete_group'])
def delete_group(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    text = message.text
    try:
        group_id = text.split(' ')[1]
    except IndexError:
        bot.reply_to(message, f"""\
                    Need group id.
                    """)
        return
    group_id = int(re.search(r'\d+', group_id).group())
    group_name = Vk.get_group_name(group_id)
    sql.delete_group(message.from_user.id, group_id)
    bot.reply_to(message, f"""\
            Group {group_name} successfully deleted.
            """)


@bot.message_handler(commands=['list_group'])
def list_group(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    result = sql.list_group(message.from_user.id)
    result = '\n'.join(result)
    if not result:
        result = "List is empty."
    bot.reply_to(message, result)


@bot.message_handler(commands=['login'])
def login(message):
    try:
        Vk.auth()
        sql.logged_true(message.from_user.id)
        bot.reply_to(message, f"""\
                            Authentication completed successfully.
                            """)
    except RuntimeError:
        bot.reply_to(message, f"""\
                    Authentication completed with error.
                    """)


@bot.message_handler()
def post(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    group_ids = sql.group_filter(message.from_user.id)
    for group_id in group_ids:
        Vk.post(group_id, message.text)
    bot.reply_to(message, f"""\
                        Post completed successfully.
                        """)


@bot.message_handler(content_types=['photo'])
def post_photo(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    file_id = message.photo[-1].file_id
    file_info = bot.get_file(file_id)
    downloaded_file = bot.download_file(file_info.file_path)
    group_ids = sql.group_filter(message.from_user.id)
    for group_id in group_ids:
        Vk.post_photo(group_id, downloaded_file, message.caption)
    bot.reply_to(message, f"""\
                            Post completed successfully.
                            """)


@bot.message_handler(content_types=['video'])
def post_video(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    file_id = message.video.file_id
    file_info = bot.get_file(file_id)
    downloaded_file = bot.download_file(file_info.file_path)
    group_ids = sql.group_filter(message.from_user.id)
    for group_id in group_ids:
        Vk.post_video(group_id, downloaded_file, message.caption, "Test")
    bot.reply_to(message, f"""\
                            Post completed successfully.
                            """)


@bot.message_handler(content_types=['document'])
def post_document(message):
    if sql.logged_check(message.from_user.id):
        bot.reply_to(message, f"""\
                            You need to login first.
                            """)
        return
    file_id = message.document.file_id
    file_info = bot.get_file(file_id)
    downloaded_file = bot.download_file(file_info.file_path)
    group_ids = sql.group_filter(message.from_user.id)
    for group_id in group_ids:
        Vk.post_document(group_id, downloaded_file, message.caption, message.document.file_name)
    bot.reply_to(message, f"""\
                            Post completed successfully.
                            """)


bot.polling()
