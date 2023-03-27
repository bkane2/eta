import os
import re

PATH = "lissa-gpt/schemas/subdialogues/main/"
# RULE_FILE = "sophie/rules/eta-generation/reaction/rules-for-question-reaction.lisp"
# RULE_FILE = "sophie/day1/rules/rules-for-statement-reaction-specific.lisp"
# RULE_FILE = "sophie-gpt/day4/rules/eta-reaction/rules-for-question-reaction.lisp"


def convert_rules(fname):
  with open(fname, 'r') as f:
    contents = f.read()

  contents = re.sub(r'([1-9])[\s]*\*([a-zA-Z\-]*)\*[\s]*(\([0-9]*[\s]*:schema\))',
                    r'\1 \2.v \3', contents)

  with open(fname, 'w') as f:
    f.write(contents)


def convert_schema(fname):
  with open(fname, 'r') as f:
    contents = f.read()

  if 'defparameter' in contents:

    predicate = contents.split('defparameter *')[1].split('*')[0]
    contents_trunc = contents.split(f'END defparameter')
    if '?' in contents_trunc[1]:
      print(f'WARNING: episode var found in schema {predicate} attachments; skipping')
      return
    contents = contents_trunc[0] + 'END ' + predicate + '.v'
    contents = contents.replace(f'defparameter *{predicate}*', f'store-schema \'{predicate+".v"}')
    
    with open(fname, 'w') as f:
      f.write(contents)


for fname in os.listdir(PATH):
  if '.lisp' in fname:
    convert_schema(PATH+fname)

# convert_rules(RULE_FILE)