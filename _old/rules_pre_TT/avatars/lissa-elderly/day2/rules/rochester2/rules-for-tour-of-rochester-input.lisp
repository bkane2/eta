(MAPC 'ATTACHFEAT
'(
  (garbage plate plates tahou tahou\'s tahoe tahoe\'s)
  (park parks highland GVP valley woods letchworth)
  (waterways genessee lake river ontario irondequoit)
  (art-gallery memorial art gallery)
  (rochester-restaurant Nick Tahoe\'s Tahou\'s garbage plate Dinosaur Barbecue Aladdin\'s Chipotle Pane Vino Tapas Pita Lounge Tavern Vine Lento Luck Gate Max Owl Golden Port Dim Sum Galleria Rocco LaLuna He\'s Salena\'s Tournedos Tornadoes Tony D\'s Edibles Espada Espada Hot Rosita\'s Rocky\'s Pellegrino\'s Scotland Yard Char Christopher\'s Veneto John\'s Tex-Mex Matthew\'s East End Magnolia\'s Bacco\'s Hogan\'s Hideaway Roncone\'s Panzari\'s Jines nays El Savor de la Isla El Taino Chen\'s Garden Monte Alban Elmwood Inn Sinbad\'s Stromboli\'s Greens Legends Dogtown Sticky Lips Distillery Tropics Stock Exchange Spiro\'s Villa Bill Gray\'s Trata El Latino Mitch\'s mitches Village Phillips Phillip\'s Philip\'s Chophouse Bazil basil Delmonico\'s Taste Ethiopia Mex Wang\'s Fiamma Fong Ristorante Lucano Papa Joe\'s Bee Peppa Pot Havana Cuba Keenan\'s Rizzi\'s Grinnell\'s Latino Antonetta\'s King Foo Choice Remington\'s Rick\'s Prime Rib Eros Nikko Lao Charlie Brown\'s Meda Zeppa Osteria Trinities Yangtze Romeo\'s Henry B\'s Cafe Cibon Carmine\'s Red Front Peppermill Nathaniel\'s Win Sal\'s Birdland Ridge Pomodoro Olympia Valicia\'s Diner Hose McGinnity\'s Mr\. Dominic\'s Shui Pelican\'s Nest CJ\'s Southern Soul Campi\'s campies Jim\'s McDonald\'s King Hut Wendy\'s Chipotle pit Danforth Douglass Douglas Mel Panda Express Tim Horton\'s DiBella\'s Cam\'s Bunga Burger Saha India GrappaF Pura Vida Blimpie Starbucks Subway Brooks Landing Boulder Holley\'s Holly\'s hollies Steve T\'s Jay\'s)
  (see-music music concert)
  (Barbecue BBQ)
	(waterfall falls fall)
	(shopping mall outlet)
	(museum museums)
	(dance dancing)
	(movies theater)  ; show shows
))


(READRULES '*tour-of-rochester-input*
'(
  ; Reciprocal questions
  1 (0 you 0 want to see 0 ?)
    2 (What would I want to see ?) (0 :gist)
  1 (0 what 0 you 0 like 0 ?)
    2 (What would I want to see ?) (0 :gist)

  ; Specific answers
  1 (0 museum 1 play 0)
    2 ((You would take me to the museum of play \.) (Rochester-tour)) (0 :gist)
  1 (0 eastman house 0)
    2 ((You would take me to george eastman house \.) (Rochester-tour)) (0 :gist)
  1 (0 eastman school 0)
    2 ((You would take me to the eastman school \.) (Rochester-tour)) (0 :gist)
  1 (0 art-gallery 0)
    2 ((You would take me to an art gallery \.) (Rochester-tour)) (0 :gist)
  1 (0 park 0)
    2 ((You would take me to a park \.) (Rochester-tour)) (0 :gist)
  1 (0 waterfall 0)
    2 ((You would take me to a waterfall \.) (Rochester-tour)) (0 :gist)  
  1 (0 shopping 0)
    2 ((You would take me to shopping \.) (Rochester-tour)) (0 :gist)
  1 (0 ice skating 0)
    2 ((You would take me to ice skating \.) (Rochester-tour)) (0 :gist)
  1 (0 cemetery 0)
    2 ((You would take me to cemetery \.) (Rochester-tour)) (0 :gist)
  1 (0 see-music 0)
    2 ((You would take me to see music \.)  (Rochester-tour)) (0 :gist)
  1 (0 museum 0)
    2 ((You would take me to see a museum \.) (Rochester-tour)) (0 :gist)
  1 (0 dance 0)
    2 ((You would take me to dance \.) (Rochester-tour)) (0 :gist)
  1 (0 movies 0)
    2 ((You would take me to movies \.) (Rochester-tour)) (0 :gist)
  1 (0 rochester-restaurant rochester-restaurant-t 0)
    2 ((You would take me to 2 3 \.) (Rochester-tour)) (0 :gist)
  1 (0 rochester-restaurant 0)
    2 ((You would take me to 2 \.) (Rochester-tour)) (0 :gist)

  ; Unbidden answers
  1 (0 dinosaur 0)
    2 ((You have been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 garbage 0)
    2 ((You like garbage plate \.) (Garbage-plate)) (0 :gist)
  1 (0 rochester-restaurant 0)
    2 ((Your favorite place to eat is 2 \.) (Rochester-eateries)) (0 :gist)

  1 (0) 
    2 ((NIL gist \: Nothing found for where you would take me \.) (Rochester-tour)) (0 :gist)
))


(READRULES '*thematic-tour-of-rochester-input*
'(
  1 (0 waterways 0)
    2 ((You would take me to the water \.) (Rochester-tour)) (0 :gist)
  1 (0 restaurant-type 0)
    2 ((You would take me to a restaurant \.) (Rochester-tour)) (0 :gist)
))


(READRULES '*reaction-to-tour-of-rochester-input*  
'(
  1 (0 rochester-restaurant 0)
    2 (That sounds delicious \!) (100 :out)
  1 (0 eastman school 0)
    2 (Oh\, cool\. I have heard a lot about eastman school\!) (100 :out)
  1 (0 eastman house 0)
    2 (Oh\, cool\. I love to see the museum and learn more about the kodak founder\!) (100 :out)
  1 (0 art gallery 0)
    2 (Oh\, you have an artistic taste\!) (100 :out)
  1 (0 park 0)
    2 (Oh\, I love nature\!) (100 :out)
  1 (0 water 0)
    2 (Oh\, I love nature\!) (100 :out)
  1 (0 waterfall 0)
    2 (Oh\, I would love to see the waterfall\!) (100 :out)
  1 (0 ice skating 0)
    2 (Oh\, I love ice skating\! That would be fun\!) (100 :out)
  1 (0 see music 0)
    2 (Oh\, I love music\, that would be great\.) (100 :out)
  1 (0 museum 0)
    2 (That\'s a great idea\. I love museums\.) (100 :out)
  1 (0 dance 0)
    2 (Oh\, I love dancing\, that would be great\.) (100 :out)
  1 (0 movies 0)
    2 (I would like that\. I used to go to theater a lot when I was younger \.) (100 :out)

  1 (0 NIL gist 0)
    2 (That sounds like a nice way to spend the day\.) (100 :out)
)); end of *reaction-to-tour-of-rochester-input*
