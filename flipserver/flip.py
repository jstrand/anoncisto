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

    port = 9000

    app = tornado.web.Application(
        [(r"/", BroadcastSocket)
        ])
    app.listen(port)

    print "Listening on ", port
    tornado.ioloop.IOLoop.current().start()

