import re
import os

avatar = "sophie"

swap_one = [
  ('i am'    , 'xou are'),
  ('am i'    , 'are xou'),
  ('me'      , 'xou'),
  ('i'       , 'xou'),
  ('mine'    , 'xours'),
  ('myself'  , 'xourself'),
  ('my'      , 'xour'),
  # ('i\\\'m'  , 'xou\\\'re'),
]

swap_two = [
  ('you are'   , 'I am'),
  ('are you'   , 'am I'),
  ('you'       , 'me'),
  ('yours'     , 'mine'),
  ('yourself'  , 'myself'),
  ('your'      , 'my'),
  # ('you\\\'re' , 'I\\\'m'),
]

swap_three = [
  ('xou are'   , 'you are'),
  ('are xou'   , 'are you'),
  ('xou'       , 'you'),
  ('xours'     , 'yours'),
  ('xourself'  , 'yourself'),
  ('xour'      , 'your'),
  # ('xou\\\'re' , 'you\\\'re'),
]


def read_file(fname):
  s = ""
  with open(fname, "r") as f:
    return f.read()


def write_file(fname, s):
  with open(fname, "w") as f:
    return f.write(s)


def swap_word(w, swap_map):
  """Swap a given word token according to given mapping"""
  for t in swap_map:
    if w == t[0]:
      return t[1]
  return w


def swap_sentence(s):
  """Swap all pronouns in a sentence"""
  # Split into words to ensure that non-pronoun words aren't affected
  s = s.lower()
  s = s.replace('i am', 'i_am').replace('you are', 'you_are').replace('am i ', 'am_i ').replace('are you ', 'are_you ')
  words = re.split('([\s+]|[\\,]|[\\\.]|[\?]|[\(]|[\)])', s.lower())
  words = [w.replace('i_am', 'i am').replace('you_are', 'you are').replace('am_i', 'am i').replace('are_you', 'are you') for w in words]
  # Make three swaps to exchange 1st and 2nd person pronouns
  words = [swap_word(w, swap_one) for w in words]
  words = [swap_word(w, swap_two) for w in words]
  words = [swap_word(w, swap_three) for w in words]
  return correct_sentence(''.join(words))


def correct_sentence(s):
  """Correct mistakes that might occur due to swapping"""
  s = s.replace(' i ', ' I ')
  s = s.replace('(me ', '(I ')
  s = s.replace('do me ', 'do I ')
  s = s.replace('did me ', 'did I ')
  s = s.replace('have me ', 'have I ')
  s = s.replace('had me ', 'had I ')
  s = s.replace('will me ', 'will I ')
  s = s.replace('would me ', 'would I ')
  s = s.replace('should me ', 'should I ')
  s = s.replace('can me ', 'can I ')
  s = s.replace('could me ', 'could I ')
  s = s.replace('me do ', 'I do ')
  s = s.replace('me did ', 'I did ')
  s = s.replace('me have ', 'I have ')
  s = s.replace('me had ', 'I had ')
  s = s.replace('me will ', 'I will ')
  s = s.replace('me would ', 'I would ')
  s = s.replace('me should ', 'I should ')
  s = s.replace('me can ', 'I can ')
  s = s.replace('me could ', 'I could ')
  s = s.replace('\. me', '\. I')
  s = s.replace('\, me', '\, I')
  s = s.replace('\: me', '\: I')
  s = s.replace('\! me', '\! I')
  s = s.replace('? me', '? I')
  s = s.replace('me\\\'re', 'I\\\'m')
  s = s.replace('you\\\'m', 'you\\\'re')
  s = s.replace(' nil ', ' NIL ')
  s = s.replace('(nil ', '(NIL ')

  res = []
  for idx, c in enumerate(list(s)):
    if idx-1 >= 0 and s[idx-1] == '(':
      res += [c.upper()]
    elif idx-2 >= 0 and s[idx-1] == ' ' and s[idx-2] in ['.', ':', '!', '?']:
      res += [c.upper()]
    else:
      res += [c]
        
  return ''.join(res)


def get_tree_type(tree_name):
  if '*reaction' in tree_name or 'reaction*' in tree_name:
    # Reaction tree -> swap pattern nodes and :out nodes
    return 'reaction'
  elif '*response' in tree_name:
    # Response tree -> swap pattern nodes and :out nodes
    return 'response'
  elif tree_name == '*gist-clause-trees-for-input*':
    # Select subtree for interpretation -> do nothing
    return 'choose-interpretation-subtree'
  elif tree_name == '*gist-clause-trees-for-response*':
    # Select subtree for response -> do nothing
    return 'choose-response-subtree'
  else:
    # Interpretation tree -> swap :gist nodes
    return 'interpretation'


def get_directive(s):
  if ':gist' in s or ':gist-coref' in s:
    return 'gist'
  elif ':out' in s:
    return 'out'
  elif ':ulf' in s or ':ulf-recur' in s or ':ulf-coref' in s:
    return 'ulf'
  elif ':subtree' in s or ':subtrees' in s or ':subtree+clause' in s:
    return 'subtree'
  elif ':schema' in s or ':schema+args' in s or ':schemas' in s or ':schema+ulf' in s:
    return 'schema'
  else:
    return None


def is_swappable(tree_type, directive):
  """Return true if pronouns should be swapped given a particular directive in a particular tree type,
     otherwise return false"""
  if tree_type == 'reaction' or tree_type == 'response':
    if directive == 'out' or directive == None:
      return True
  if tree_type == 'interpretation':
    if directive == 'gist':
      return True
  return False


def swap_contents(contents):
  """Procedurally swap pronouns in a given list of characters"""
  # Apply preprocessing to combine certain groups of characters
  contents = preprocess_treenames(contents)
  contents = preprocess_lists(contents)
  contents = preprocess_whitespace(contents)
  contents = preprocess_gist_rules(contents)

  tree_type = None
  directive = None
  res = []
  for idx, c in enumerate(contents):
    # If looking at a tree name, extract tree type of subsequent tokens
    if c[0] == '*':
      tree_type = get_tree_type(c)
      res += [c]
    # Otherwise, looking at some other token
    else:
      # Extract directive from lookahead token (if any)
      if idx+1 < len(contents):
        directive = get_directive(contents[idx+1])
      else:
        directive = None

      # Decide whether pronoun swap should be made based on current tree type and directive
      if len(c.strip()) > 1 and is_swappable(tree_type, directive):
        # If so, make swap
        res += [swap_sentence(c)]
      else:
        # Otherwise, attach token without modification
        res += [c]
      
  return res


def preprocess_whitespace(contents):
  """Combine any whitespace preceding some token"""
  res = []
  temp = None
  for c in contents:
    if c == ' ' and not temp:
      temp = c
    elif c != ' ' and temp:
      temp += c
      res += [temp]
      temp = None
    elif temp:
      temp += c
    else:
      res += [c]
  return res


def preprocess_gist_rules(contents):
  """In the case of gist rules which include topic key, combine gist-clause and topic key"""
  res = []
  skip2 = False
  skip1 = False
  temp = None
  for idx, c in enumerate(contents):
    if skip2:
      skip2 = False
      skip1 = True
      continue
    if skip1:
      skip1 = False
      continue

    if c == '(' and not temp:
      temp = ['(']
    elif c == '(' and temp:
      res += temp
      res += [c]
      temp = None
    elif c == ')' and idx+1 < len(contents) and len(contents[idx+1]) > 1 and temp:
      temp += [')']
      temp += [contents[idx+1]]
      temp += [contents[idx+2]]
      res += [''.join(temp)]
      temp = None
      skip2 = True
    elif c == ')' and temp:
      res += temp
      res += [c]
      temp = None
    elif temp:
      temp += [c]
    else:
      res += [c]
  return res


def preprocess_lists(contents):
  """Combine together any 'bottom-level' lists (i.e. patterns and directives)"""
  res = []
  temp = None
  for c in contents:
    if c == '(' and not temp:
      temp = ['(']
    elif c == '(' and temp:
      res += temp
      res += [c]
      temp = None
    elif c == ')' and temp:
      temp += [')']
      res += [''.join(temp)]
      temp = None
    elif temp:
      temp += [c]
    else:
      res += [c]
  return res


def preprocess_treenames(contents):
  """Combine together names of tree roots"""
  res = []
  temp = None
  for c in contents:
    if c == '*' and not temp:
      temp = '*'
    elif c != '*' and temp:
      temp += c
    elif c == '*' and temp:
      temp += '*'
      res += [temp]
      temp = None
    else:
      res += [c]
  return res


def swap_file(fname):
  contents = list(read_file(fname))
  contents_new = swap_contents(contents)
  write_file(fname, "".join(contents_new))


def swap_files_all(directory):
  for root, dirs, files in os.walk(directory, topdown=False):
    for name in files:
      if name[0] != '.':
        fname = os.path.join(root, name)
        if '/rules/' in fname:
          swap_file(fname)


def main():
  swap_files_all('avatars/'+avatar+'/')


if __name__ == "__main__":
  main()