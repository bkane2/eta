from os import listdir, makedirs, remove
from os.path import isfile, join, exists


def preprocess_file(fname):
  with open(fname) as f:
    lines = f.readlines()
  lines = [line.rstrip() for line in lines]
  lines = [line.replace('Subject: ', '') for line in lines if "Subject: " in line]
  return lines


def write_log(fname, log):
  with open(fname, 'w+') as f:
    for line in log:
      f.write('("{}")'.format(line))
      f.write('\n')


def remove_files(dir):
  for f in get_all_files(dir):
    remove(dir+f)


def get_all_files(dir):
  return [f for f in listdir(dir) if isfile(join(dir, f)) and (not ".py" in f) and (f[0] != '.')]


def main():
  files = get_all_files(".")
  if not exists("logs/"):
    makedirs("logs/")
  else:
    remove_files("logs/")
  logs = [preprocess_file(f) for f in files]
  for file, log in zip(files, logs):
    fname = "logs/"+file.replace(".txt","")
    write_log(fname, log)


if __name__ == '__main__':
	main()