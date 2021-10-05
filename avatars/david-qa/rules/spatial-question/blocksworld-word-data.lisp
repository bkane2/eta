; November 25, 2019
;=================================================================
; Word data used in the context of the blocksworld dialogue.
; Factored out so as to avoid duplication in the various rule files.
;

(MAPC 'ATTACHFEAT
'(
  (corp Adidas Burger_King Esso Heineken HP McDonalds Mercedes NVidia  
        Pepsi Shell SRI SRI_International Starbucks Texaco Target Toyota
        Twitter)

  (block blocks)
  (table tables)
  (stack stacks)
  (row rows)
  (edge edges)
  (face faces)
  (plane planes)
  (line lines)
  (circle circles)
  (pile piles)
  (object objects)
  (color colors)
  (structure structures)
  (direction directions)
  (way ways)
  (other others)
  (one ones)
  (thing things)

  (chair chairs)
  (book books)
  (bookshelf bookshelves)
  (book_shelf book_shelves)
  (bed beds)
  (tv tvs)
  (coffee_table coffee_tables)
  (poster posters)
  (laptop laptops)
  (pen pens)
  (tree trees)
  (microwave microwaves)
  (stove stoves)
  (fridge fridges)
  (sofa sofas)
  (human humans)
  (cat cats)
  (window windows)
  (box boxes)
  (pinetree pinetrees)
  (pine_tree pine_trees)
  (pine pines)
  (bird birds)
  (curtain curtains)
  (analog analogs)
  (clock clocks)
  (analog_clock analog_clocks)
  (pie pies)
  (door doors)
  (hammer hammers)
  (toothbrush toothbrushes)
  (tooth teeth)
  (brush brushes)
  (tooth_brush tooth_brushes)
  (bin bins)
  (recycle_bin recycle_bins)
  (desk desks)
  (ceiling ceilings)
  (fan fans)
  (light lights)
  (ceiling_fan ceiling_fans)
  (ceiling_light ceiling_lights)
  (banana bananas)
  (rose roses)
  (vase vases)
  (pencil pencils)
  (cardbox cardboxes)
  (card cards)
  (box boxes)
  (card_box card_boxes)
  (lamp lamps)
  (painting paintings)
  (picture pictures)
  (apple apples)
  (bowl bowls)
  (plate plates)
  (footrest footrests)
  (foot feet)
  (foot_rest foot_rests)
  (holder holders)
  (pencil_holder pencil_holders)
  (aquarium aquariums)
  (umbrella umbrellas)
  (floor floors)
  (floor_lamp floor_lamps)
  (rocking_chair rocking_chairs)

  (turn turns)
  (time times)
  (stage stages)
  (step steps)
  (question questions)
  (utterance utterances)
  (iteration iterations)
  (move moves)
  (action actions)
  (period periods)
  (start starts)
  (beginning beginnings)
  (while whiles)
  (second seconds)
  (minute minutes)
  (hour hours)

  (under underneath supporting support)
  (close next)
  (touching face-to-face abutting against flush)
  (farthest furthest)
  (rotated angled swivelled turned)

  (touch touches touched)
  (support supports supported)
  (connect connects connected)
  (consist_of consists_of consisted_of)
  (sit sits sat)
  (adjoin adjoins adjoined)
  (flank flanks flanked)
  (face faces faced)
  (move moves moved)
  (put puts)
  (change changes changed)
  (pick_up picks_up picked_up)
  (rotate rotates rotated)
  (place places placed)

  (reason reasons reasoning justification justifications explanation explanations)

  (adv-explain why how)

  (verb-rel-past touched supported connected consisted_of sat adjoined flanked
      faced moved puts changed picked_up rotated placed)

  (prep-bw on on_to under in behind near touching facing abutting between from
        below beneath above next_to close_to near_to visible on_top_of to_the_left_of
        to_the_right_of in_front_of adjacent_to flush_with towards)
  (prep-where-adv relative_to with_respect_to)

  (rel-adj near close touching facing adjacent flush central)
  (qual-adj purple blue green yellow orange red pink gray grey
            black white brown clear visible nearby)
  (num-adj two three four five six seven eight nine ten eleven twelve many)
  (sup-adj leftmost rightmost furthest farthest nearest closest highest
           tallest nearest topmost top uppermost smallest lowest largest
           centermost shortest backmost longest fewest frontmost)
  (sup-adj-base left right far near close high tall near small low large
           center central short back long few front)
  (ord-adj first second third fourth fifth sixth seventh eighth ninth
           tenth eleventh twelfth thirteenth fourteenth fifteenth sixteenth
           seventeens eighteenth nineteenth twentieth)
  (diff-adj other different same distinct separate unique)
  (compare-adj further closer nearer higher lower taller shorter larger smaller
               longer wider narrower)
  (adj-obj qual-adj rel-adj num-adj sup-adj sup-adj-base ord-adj diff-adj)
  (mod-n adj-obj corp)

  (noun-bw block table stack row edge face plane line circle pile object
        color structure left center right back front direction way other
        one thing)

  (noun-room table chair book bookshelf book_shelf bed tv coffee coffee_table poster laptop pen
      tree microwave stove fridge sofa human cat window box scissors pinetree pine_tree pine bird
      curtains analog clock analog_clock pie door hammer toothbrush tooth brush tooth_brush recycle
      bin recycle_bin desk ceiling fan light ceiling_fan ceiling_light banana rose vase pencil cardbox
      card box card_box lamp painting picture apple bowl plate footrest foot rest foot_rest holder pencil_holder
      aquarium umbrella floor floor_lamp rocking_chair)

  (noun-obj noun-bw noun-room)

  (noun-total total all)

  (verb be verb-rel)
  (be is are was were)
  (verb-rel touch support connect consist_of sit adjoin flank face
      move put change pick_up rotate place)
  (verb-answer answer answered say said tell told mention mentioned claim claimed 
      reply replied respond responded think thought believe believed know knew)
  (verb-explain explain justify elaborate)

  (noun-explain answer answers response responses reply replies)

  (aux-bw do modal)
  (wh-explanation why how)
  
  (adv-e-number first second third fourth fifth sixth seventh eighth ninth tenth)
  (adv-e previously before originally initially currently now recently ever since last finally adv-e-number)
  (adv-f-number once twice thrice)
  (adv-f always never adv-f-number)
  (adv-history adv-f adv-e)
  (noun-history turn time stage step question utterance iteration move action period start beginning while past
      now second minute hour moment present future)
  (prep-history at in on prep-history-simple)
  (prep-history-simple during within before after when where while prior_to following preceding since from until)
  (prep-history-adj ago before previously after later)
  (adj-history-modifier-number one two three four five six seven eight nine ten twenty thirty forty fifty sixty seventy
      eighty ninety hundred)
  (adj-history-modifier few couple adj-history-modifier-number)
  (adj-history-number first second third fourth fifth sixth seventh eighth ninth tenth)
  (adj-history previous next current initial original following preceding future last final recent
      adj-history-number adj-history-modifier)

  (adv-hist-modifier just right directly most)
  (adv-hist-number one two three four five six seven eight nine ten)
  (adv-hist-word adv-history prep-history adj-history adv-hist-modifier adv-hist-number)
  (adv_ adv adv-history adv-hist-modifier)
  
  (prep prep-bw prep-history prep-where-adv)
  (adj adj-obj adj-history)
  (noun noun-obj noun-history noun-total)

  (np-bw np_ noun-bw corp)
  (np-room np_ noun-room)
  (np-obj np-bw np-room)
))