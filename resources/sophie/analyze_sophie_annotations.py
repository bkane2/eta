import pandas as pd
import numpy as np
from sklearn.metrics import cohen_kappa_score


def dialogues_by_quality(df, criteria='both'):

  dialogues = []

  for g, dialogue in df.groupby(['User', 'Session']):
    dialogue_id = f'{g[0]}s{g[1]}.txt'
    
    appropriate = dialogue[dialogue['Response_Appropriate'] == 1]

    if criteria == 'both':
      dialogues.append((dialogue_id, (len(appropriate)/len(dialogue), len(appropriate))))
    elif criteria == 'percent':
      dialogues.append((dialogue_id, len(appropriate)/len(dialogue)))
    else:
      dialogues.append((dialogue_id, len(appropriate)))
  
  if criteria == 'both':
    sort1 = [x[0] for x in sorted(dialogues, key=lambda x : x[1][0])]
    sort2 = [x[0] for x in sorted(dialogues, key=lambda x : x[1][1])]
    dialogues = [(d[0], sort1.index(d[0])+sort2.index(d[0])) for d in dialogues]
    return sorted(dialogues, key=lambda x : x[1])
  else:
    return sorted(dialogues, key=lambda x : x[1])


def print_interannotator_agreement(df1, df2):

  print('ASR_Error:', cohen_kappa_score(df1['ASR_Error'], df2['ASR_Error']))
  print('Gist_Correct:', cohen_kappa_score(df1['Gist_Correct'], df2['Gist_Correct']))
  print('Response_Appropriate:', cohen_kappa_score(df1['Response_Appropriate'], df2['Response_Appropriate']))


def print_statistics(df):

  n = len(df)
  
  gist_incorrect = len(df[df['Gist_Correct'] == -1])
  gist_nil = len(df[df['Gist_Correct'] == 0])
  gist_correct = len(df[df['Gist_Correct'] == 1])

  response_inappropriate = len(df[df['Response_Appropriate'] == -1])
  response_clarify = len(df[df['Response_Appropriate'] == 0])
  response_appropriate = len(df[df['Response_Appropriate'] == 1])

  asr_error = len(df[df['ASR_Error'] > 0])
  asr_error_transcription = len(df[df['ASR_Error'] == 1])
  asr_error_interruption = len(df[df['ASR_Error'] == 2])

  print()
  print('Gist correct:', gist_correct / n)
  print('  - Incorrect:', gist_incorrect / n)
  print('  - Nil:', gist_nil / n)
  print()

  print('Response appropriate:', response_appropriate / n)
  print('  - Inappropriate:', response_inappropriate / n)
  print('  - Clarify:', response_clarify / n)
  print()

  print('Number ASR error:', asr_error / n)
  print('  - Transcription errors:', asr_error_transcription / n)
  print('  - User interrupted:', asr_error_interruption / n)
  print()

  gist_correct_adjusted = len(df[((df['ASR_Error'] > 0) & (df['Gist_Correct'] == 0)) | (df['Gist_Correct'] == 1)])
  response_appropriate_adjusted = len(df[((df['ASR_Error'] > 0) & (df['Response_Appropriate'] == 0)) | (df['Response_Appropriate'] == 1)])

  print('Gist correct (ASR error adjusted):', gist_correct_adjusted / n)
  print('Response appropriate (ASR error adjusted):', response_appropriate_adjusted / n)
  print()

  return gist_correct_adjusted/n, response_appropriate_adjusted/n


def main():
  df_kate = pd.read_csv('sophie_annotations_kate.csv')
  df_ben = pd.read_csv('sophie_annotations_ben.csv')

  gist1, response1 = print_statistics(df_kate)
  print('\n-------------------------------------------------------------------------------\n')
  gist2, response2 = print_statistics(df_ben)
  print('\n-------------------------------------------------------------------------------\n')
  print('Average gist correct:', (gist1+gist2)/2)
  print('Average response correct:', (response1+response2)/2)
  print('\n-------------------------------------------------------------------------------\n')
  print_interannotator_agreement(df_kate, df_ben)
  print('\n-------------------------------------------------------------------------------\n')
  print('Dialogues by quality (worst to best)')
  # print(dialogues_by_quality(df_ben, criteria='percent'))
  # print()
  # print(dialogues_by_quality(df_ben, criteria='count'))
  # print()
  dialogues_sorted = dialogues_by_quality(df_ben)
  print([x[0] for x in dialogues_sorted])


if __name__ == '__main__':
	main()