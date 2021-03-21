import telebot
import parsing
from telebot.types import InlineKeyboardButton, InlineKeyboardMarkup

API_TOKEN = '1752094454:AAFRDIxO135xlcRAbuJ36VpzsilSCXfPuco'
bot = telebot.TeleBot(API_TOKEN)
more_data = None


@bot.message_handler(commands=['start'])
def start(message):
    keyboard = [[InlineKeyboardButton("ТЧ", callback_data='1'), InlineKeyboardButton("ЧН", callback_data='2'),
                 InlineKeyboardButton("ЗП", callback_data='3'), InlineKeyboardButton("ВК", callback_data='4')]]
    markup = InlineKeyboardMarkup(keyboard)
    bot.send_message(chat_id=message.chat.id, text='Choose your joke:', reply_markup=markup)


@bot.callback_query_handler(func=lambda call: True)
def query_handler(call):
    global more_data
    try:
        bot.answer_callback_query(callback_query_id=call.id)
        if call.data in ('1', '2', '3', '4'):
            bot.send_message(chat_id=call.message.chat.id, text=get_joke(call.data))
            keyboard = [
                [InlineKeyboardButton("More", callback_data='0'), InlineKeyboardButton("Another one", callback_data='9')]]
            markup = InlineKeyboardMarkup(keyboard)
            bot.send_message(chat_id=call.message.chat.id, text='Choose option:', reply_markup=markup)
            more_data = call.data
        elif call.data == "0":
            joke = get_joke(more_data)
            bot.send_message(chat_id=call.message.chat.id, text=joke)
            keyboard = [
                [InlineKeyboardButton("More", callback_data='0'), InlineKeyboardButton("Another one", callback_data='9')]]
            markup = InlineKeyboardMarkup(keyboard)
            bot.send_message(chat_id=call.message.chat.id, text='Choose option:', reply_markup=markup)
        elif call.data == "9":
            start(call.message)
    except Exception:
        pass


def get_joke(data: str):
    joke = None
    if data == "1":
        joke = parsing.get_data("ТЧ")
    elif data == "2":
        joke = parsing.get_data("ЧН")
    elif data == "3":
        joke = parsing.get_data("ЗП")
    elif data == "4":
        joke = parsing.get_data("ВК")
    return joke


bot.polling()
