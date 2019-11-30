import os
import re

def import_file(path, dst, leading_white_spaces):
  src = open(path, "r")
  for line in src:
    dst.write((" " * leading_white_spaces) + line)
  src.close()

if __name__ == "__main__":
  src = open("./templates/_index.html", "r")
  dst = open("./index.html", "w")

  for line in src:
    # match = re.search(r"{{'(.+)'}}", line)
    match = re.search(r"include\('(.+)'\)", line)
    if match:
      file = match.group(1)
      import_file(file, dst, len(line) - len(line.lstrip()))
    else:
      dst.write(line)

  src.close()
  dst.close()

  print("Done compiling!")
