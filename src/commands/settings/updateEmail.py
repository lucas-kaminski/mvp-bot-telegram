from api.telegram import updateMessage

class UpdateEmail():
  def __init__ (self):
    pass

  def run(self, **kwargs):
    chat_id = kwargs['chat_id']
    message_id = kwargs['message_id']

    updateMessage(chat_id, message_id, text='Envie seu e-mail')
