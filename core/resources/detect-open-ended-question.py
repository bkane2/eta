#!/usr/bin/env python3
#
# Simple script to classify 'open-ended questions', which are characterized by
# certain forms of wh-questions. This uses a template-based approach using word
# features, borrowed from Eta's pattern transduction implementation.
#
# This is currently fairly rudimentary, under the assumption that it's more important
# to correctly recognize an open-ended question than to avoid classifying a narrow
# question as open-ended. Eventually, it may be better to train a classifier for this.
# 

import sys

open_ended_templates = [
  'who modal 0',
  'why 0',
  'how 0',
  'wh_ 0 think 0',
  'wh_ 0 you 5 want 0',
  'tell 5 me 0 think 0',
  'aux 5 you 0 think 0',
  'wh_ 3 be 0 you 5 opinion 0',
  'wh_ 0' # this will classify any wh-question as open-ended
]

word_features = {
  'index-pron' : ['I', 'you', 'me', 'us', 'mine', 'yours', 'ours'],
  'refl-pron'  : ['oneself', 'myself', 'yourself', 'himself', 'herself',
                  'itself', 'ourselves', 'yourselves', 'themselves'],
  'ana-pron'   : ['he', 'she', 'it', 'they', 'him', 'her', 'them', 'hers', 'theirs'],
  'anaphor'    : ['ana-pron', 'his', 'her', 'its', 'their'],
  'wh-pron'    : ['who', 'whom', 'what', 'which'],
  'rel-pron'   : ['that', 'which', 'when', 'who', 'whom'],
  'pron'       : ['index-pron', 'refl-pron', 'ana-pron', 'wh-pron', 'rel-pron'],
  'wh-det'     : ['which', 'what', 'whose'],
  'index-det'  : ['that', 'those', 'these', 'this'],
  'det'        : ['the', 'a', 'an', 'my', 'yours', 'his', 'her', 'its', 'our', 'their', 'all',
                  'every', 'each', 'any', 'index-det', 'some', 'many', 'one', 'two', 'three',
                  'another', 'other', 'wh-det'],
  'np_'        : ['pron', 'det'],
  'modal'      : ['can', 'could', 'will', 'would', 'shall', 'should', 'might', 'may', 'ought'],
  'have'       : ['has', 'had'],
  'necessity'  : ['need', 'have'],
  'be'         : ['am', 'are', 'is', 'was', 'were'],
  'do'         : ['does', 'did', 'doing'],
  'aux-base'   : ['have', 'be', 'do'],
  'aux'        : ['modal', 'have', 'be', 'do'],
  'freq'       : ['often', 'frequently', 'many', 'few', 'lots'],
  'deg-adv'    : ['not', 'just', 'very', 'only', 'exactly', 'precisely'],
  'conj'       : ['but', 'and', 'or'],
  'wh_'        : ['wh-det', 'wh-pron', 'why', 'how', 'when', 'where'],
  'think'      : ['thinking', 'know', 'understand'],
  'tell'       : ['say', 'repeat'],
  'opinion'    : ['opinions', 'thought', 'thoughts', 'value', 'values', 'need', 'needs', 'preference', 'preferences']
}



def assign_word_features(d):
  """Given a dict mapping word features to words, create a dict
     mapping any particular word to its word features."""
  feat_dict = dict()
  for f, ws in d.items():
    ws = get_base_words(ws, d) + [f]
    for w in ws:
      if w not in feat_dict:
        feat_dict[w] = []
      feat_dict[w] += [f]
  return feat_dict



def get_base_words(ws, d):
  """Given a list of words or features, reduce to a list of
     base words by expanding features."""
  ret = []
  for w in ws:
    if w in d:
      ret += get_base_words(d[w], d) + [w]
    else:
      ret += [w]
  return ret



def process_str(s, convert_int = False):
  """Converts a string into a list of words (converting integer
     strings to ints if convert_int = True is given)."""
  words = s.lower().split()
  if convert_int:
    words = [int(w) if w.isnumeric() else w for w in words]
  return words



def match(words, pattern, feat_dict = None):
  """Implements a simple recursive template-based matching algorithm. 'words' should
     be a list of strings. 'pattern' should be a list of strings or ints, where strings
     are interpreted as words to be matched. 0 is interpreted as 'match any number of
     words', and any other int n is interpreted as 'match at most n words'."""
  # Base case 1: pattern empty or invalid form
  if not isinstance(pattern, list) or not pattern:
    return False
  # Base case 2: empty input or invalid form
  if not isinstance(words, list) or not words:
    if len(pattern) == 1 and isinstance(pattern[0], int):
      return True
    else:
      return False

  tok = pattern[0]
  rst = pattern[1:]
  # Pattern starts with 0
  if tok == 0:
    if not rst:
      return True
    elif match(words, rst, feat_dict):
      return True
    elif match(words[1:], pattern, feat_dict):
      return True
    else:
      return False
  # Pattern starts with 1
  if tok == 1:
    if not rst:
      return True if len(words) == 1 else False
    elif match(words, rst, feat_dict):
      return True
    elif match(words[1:], rst, feat_dict):
      return True
    else:
      return False
  # Pattern starts with n
  if isinstance(tok, int):
    if match(words, rst, feat_dict):
      return True
    elif match(words[1:], [tok-1]+rst, feat_dict):
      return True
    else:
      return False
  # Pattern is a word or feature
  else:
    if not (tok == words[0] or (feat_dict and words[0] in feat_dict and tok in feat_dict[words[0]])):
      return False
    elif not (rst or words[1:]):
      return True
    elif match(words[1:], rst, feat_dict):
      return True
    else:
      return False



def is_open_ended(s):
  """Go through each template for open-ended questions, and return True once a first match is found."""
  feat_dict = assign_word_features(word_features)
  for template in open_ended_templates:
    if match(process_str(s), process_str(template, convert_int = True), feat_dict=feat_dict):
      return True
  return False



def main(argv):
  """Print 1 to stdout if the given argument is an open-ended question; 0 otherwise."""
  if is_open_ended(argv):
    print(1)
  else:
    print(0)



if __name__ == '__main__':
  if len(sys.argv) != 2:
    exit('Please input single string as command line argument.')
  elif not isinstance(sys.argv[1], str):
    exit('Please input single string as command line argument.')
  main(sys.argv[1])