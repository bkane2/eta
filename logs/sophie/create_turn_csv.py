from os import listdir, makedirs, remove
from os.path import isfile, join, exists
import pandas as pd
import numpy as np


def get_all_files(dir):
  return [f for f in listdir(dir) if isfile(join(dir, f)) and (not ".py" in f) and (f[0] != '.')]


def get_turns(fname):
  with open('logs_original/'+fname+'.txt') as f:
    lines = f.readlines()
  lines = [line.rstrip() for line in lines]
  turns = []
  for i in range(1,len(lines)):
    if "Subject: " in lines[i]:
      turns.append((lines[i-1].replace("LISSA:", "").strip(), lines[i].replace("Subject:", "").strip()))
  return turns


def get_gists(fname):
  with open('logs_out/gist/'+fname+'.txt') as f:
    lines = f.readlines()
  with open('logs_out/text/'+fname+'.txt') as f:
    lines_in = f.readlines()
  lines = [line.rstrip() for line in lines]
  lines_in = [line.rstrip() for line in lines_in]
  turns = []
  for i in range(0,len(lines)):
    if "USER : " in lines[i] and not "(BYE)" in lines_in[i]:
      turns.append(lines[i].replace("USER : ", "").strip())
  return turns


def get_responses(fname):
  with open('logs_original/'+fname+'.txt') as f:
    lines = f.readlines()
  lines = [line.rstrip() for line in lines]
  turns = []
  for i in range(1,len(lines)):
    if "Subject: " in lines[i-1]:
      turns.append(lines[i].replace("LISSA:", "").strip())
  return turns


def create_turn_csv(user_sessions):
  data = []
  for u in user_sessions.keys():
    for s_idx, s in enumerate(user_sessions[u]):
      f = u+'s'+s
      inputs = get_turns(f)
      gists = get_gists(f)
      responses = get_responses(f)
      for ((context, input), gist, response) in zip(inputs, gists, responses):
        data.append((u, s, context, input, gist, response))

  df = pd.DataFrame(data, columns=['User', 'Session', 'Context', 'Utterance', 'Gist', 'Response'])
  df['ASR_Error'] = np.nan
  df['Gist_Correct'] = np.nan
  df['Response_Appropriate'] = np.nan
  df.to_csv('sophie_eval.csv', index=False)


def main():
  files = get_all_files("logs_in/")
  files = [f.split('s') for f in files]
  users = set([f[0] for f in files])
  user_sessions = dict()
  for u in users:
    session_numbers = [f[1] for f in files if f[0] == u]
    session_numbers.sort()
    user_sessions[u] = session_numbers

  create_turn_csv(user_sessions)


if __name__ == '__main__':
	main()