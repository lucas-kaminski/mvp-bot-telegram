from api.telegram import sendMessage


class Carteiradotasso:
    def __init__(self):
        pass

    def run(self, **kwargs):
        user = kwargs["user"]

        sendMessage(user["TELEGRAM_ID"], "Comando a ser feito")
