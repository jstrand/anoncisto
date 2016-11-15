import tornado.websocket
import tornado.ioloop

sockets = []

class BroadcastSocket(tornado.websocket.WebSocketHandler):
    def open(self):
    	sockets.append(self)

        print("WebSocket opened")

    def on_message(self, message):
    	
    	print message

    	for socket in sockets:
    		socket.write_message(message)

    def on_close(self):
    	if self in sockets:
    		sockets.remove(self)

        print("WebSocket closed")

    def check_origin(self, origin):
        return True


if __name__ == "__main__":
    app = tornado.web.Application(
        [(r"/", BroadcastSocket)
        ])
    app.listen(9000)
    tornado.ioloop.IOLoop.current().start()

