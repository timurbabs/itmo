import telebot
from parsing import get_data
from data import API_TOKEN
from telebot.types import InlineKeyboardButton, InlineKeyboardMarkup

bot = telebot.TeleBot(API_TOKEN)


@bot.message_handler(commands=['start'])
def start(message):
    keyboard = [[InlineKeyboardButton("ТЧ", callback_data='1'), InlineKeyboardButton("ЧН", callback_data='2'),
                 InlineKeyboardButton("ЗП", callback_data='3'), InlineKeyboardButton("ВК", callback_data='4')]]
    markup = InlineKeyboardMarkup(keyboard)
    bot.send_message(chat_id=message.chat.id, text='Choose your joke.', reply_markup=markup)


more_data = None


@bot.callback_query_handler(func=lambda call: True)
def query_handler(call):
    global more_data
    try:
        if call.data in ('1', '2', '3', '4'):
            keyboard = [[InlineKeyboardButton("More", callback_data='0'),
                         InlineKeyboardButton("Another one", callback_data='9')]]
            markup = InlineKeyboardMarkup(keyboard)
            bot.send_message(chat_id=call.message.chat.id, text=get_data(call.data), reply_markup=markup)
            bot.answer_callback_query(callback_query_id=call.id)
            more_data = call.data
        elif call.data == "0":
            keyboard = [[InlineKeyboardButton("More", callback_data='0'),
                         InlineKeyboardButton("Another one", callback_data='9')]]
            markup = InlineKeyboardMarkup(keyboard)
            bot.send_message(chat_id=call.message.chat.id, text=get_data(more_data), reply_markup=markup)
            bot.answer_callback_query(callback_query_id=call.id)
        elif call.data == "9":
            start(call.message)
            bot.answer_callback_query(callback_query_id=call.id)
    except Exception:
        pass


bot.polling()
