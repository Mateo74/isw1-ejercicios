import sys
import os
import re
import asyncio
import websockets

def file_filter(name):
  def run_filters(name, filters):
    for regex in filters:
      if re.search(regex, name):
        return True
    return False
  return not run_filters(name, ["^\.", "\.swp$"])

def file_times(path):
  for top_level in [x for x in os.listdir(path) if not x.startswith(".")]:
    for root, dirs, files in os.walk(top_level):
      for file_name in filter(file_filter, files):
        yield os.stat(os.path.join(root, file_name)).st_mtime

async def refresh(websocket, path):
  last_mtime = max(file_times('.'))
  while True:
    max_mtime = max(file_times('.'))
    if max_mtime > last_mtime:
      last_mtime = max_mtime
      await asyncio.sleep(1)
      await websocket.send('refresh')
    await asyncio.sleep(1)

start_server = websockets.serve(refresh, "127.0.0.1", 8178)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
