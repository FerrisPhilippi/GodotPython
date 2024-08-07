import asyncio
import websockets
import ast


async def server(ws, path):
    async for msg in ws:
        msg = msg.decode('utf-8')
        # print(f"Msg from client: {msg}")
        dictionary = ast.literal_eval(msg)
        print(dictionary)
        await ws.send(f"Got your message: {msg}")

start_server = websockets.serve(server, "localhost", 6000)
print("Server started!")
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
