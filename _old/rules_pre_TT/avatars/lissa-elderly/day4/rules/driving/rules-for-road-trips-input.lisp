;;	Have you ever taken a fun road trip ?
;;	(0 I 1 never taken 2 road trip 0)  (0 I took 2 road trip 0) 
;;	road-trips
;;	gist-question: (1 have you 4 road trip 4)

(MAPC 'ATTACHFEAT
'(
   (countryside mountain lake river sea beach rural cabin)
   (transportation highway tunnel tunnels motel motels)
   (camping hiking Yellowstone Grand Canyon Yosemite National Park Parks Adirondacks Adirondack)
   (state Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii
      Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota
      Mississippi Missouri Montana Nebraska Nevada New Hampshire New Jersey New Mexico New York North Dakota
      Ohio Oklahoma Oregon Pennsylvania Rhode Island South Carolina South Dakota Tennessee Texas Utah Vermont
      Virginia Washington West Virginia Wisconsin Wyoming)
   (city LA NYC SF DC SD Los Angeles San Francisco New York City Washinton DC San Diego Houston Chicago
      Dallas Phoenix Boston Seattle Nashivlle Portland Las Vegas Detroit Philadelphia Miami Atlanta Rochester
      Pittsburgh Montana)
   (Philadelphia Philly)
   (country USA United States Mexico Canada Germany Italy France Switzerland Austria Vienna Belgium Poland Netherland
      Amsterdam Denmark Czechia UK United Kingdom)
   (country-city Toronto Muncih Berlin Frankfurt Rome Milan Paris Strasburg Vienna Amsterdam)
   (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
   (friend friends)
   (unplanned surprises surprise surprising surprised unexpected discover discovery discoveries)
))
  

(READRULES '*road-trips-input*
'(
   ; Questions
   1 (0 what 2 you 0 ?)
      2 (Have I ever taken a fun road trip ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (Have I ever taken a fun road trip ?) (0 :gist)
   1 (0 wh_ 4 hobbies 0 ?)
      2 (Have I ever taken a fun road trip ?) (0 :gist)

   ; Specific answers
   1 (0 city city city 0) ;; e.g. New York City
      2 ((You took a road trip to 2 3 4 \.)  (Road-trips)) (0 :gist)
   1 (0 city city 0) 
      2 ((You took a road trip to 2 3 \.)  (Road-trips)) (0 :gist)
   1 (0 city 0) 
      2 ((You took a road trip to 2 \.)  (Road-trips)) (0 :gist)
   1 (0 state state 0) 
      2 ((You took a road trip to 2 3 \.)  (Road-trips)) (0 :gist)
   1 (0 state 0) 
      2 ((You took a road trip to 2 \.)  (Road-trips)) (0 :gist) 
   1 (0 country country 0)  ;; e.g. United States
      2 ((You took a road trip to 2 3 \.)  (Road-trips)) (0 :gist)
   1 (0 country-city 0)
      2 ((You took a road trip to 2 \.)  (Road-trips)) (0 :gist)
   1 (0 country 0)
      2 ((You took a road trip to 2 \.)  (Road-trips)) (0 :gist)
   1 (0 family 0) 
      2 ((You took a road trip with your 2 \.)  (Road-trips)) (0 :gist)
   1 (0 friend 0) 
      2 ((You took a road trip with your 2 \.)  (Road-trips)) (0 :gist)
   1 (0 stranger 0) 
      2 ((You took a road trip with 2 \.)  (Road-trips)) (0 :gist)
   1 (0 unplanned 0)
      2 ((You took 2 road trips \.)  (Road-trips)) (0 :gist)
   1 (0 Yosemite National Park 0)
      2 ((You took a road trip to 2 3 4 \.)  (Road-trips)) (0 :gist)
   1 (0 National Park 0)
      2 ((You took a road trip to 2 3 \.)  (Road-trips)) (0 :gist)
   1 (0 camping 0)
      2 ((You took a road trip to 2 \.)  (Road-trips)) (0 :gist)
   1 (1 NEG 3 road trip 0) 
      2 ((You have never taken any road trip \.)  (Road-trips)) (0 :gist)
   1 (1 NEG 3 road trips 0) 
      2 ((You have never taken any road trip \.)  (Road-trips)) (0 :gist)
   1 (1 NEG 3 remember 0) 
      2 ((You have never taken any road trip \.)  (Road-trips)) (0 :gist)

   1 (1 NEG 2 unplanned 0) ;; e.g. I don't really like unplanned road trips
      2 ((You have never taken any 4 road trip \.)  (Road-trips)) (0 :gist)
   1 (1 NEG 3 family 0) 
      2 ((You have never taken any road trip with your 4 \.)  (Road-trips)) (0 :gist)

   1 (0)
      2 ((NIL gist \: Nothing found for if you took any road trip \.) (Road-trips)) (0 :gist)
))


(READRULES '*reaction-to-road-trips-input*
'(
   1 (1 have never taken 0) 
      2 (Oh\. Road trip is much fun in my opinion\. However\, some people find it boring or tiring \.) (100 :out)
   1 (0 city city city 0) 
      2 (I have taken a road trip to 2 3 4 with my friends\. They played music during the ride and I have wonderful memories\.) (100 :out)
   1 (0 state state 0) 
      2 (0 new york 0)
         3 (I have taken a road trip to 2 3 city with my friends\. They played music during the ride and I have wonderful memories\.) (100 :out)
      2 (0 state state 0)
         3 (I have never been to 2 3 \, but it must be nice there\.) (100 :out)
   1 (0 city city 0) 
      2 (0 los angeles 0)
         3 (I have been to la just last month\. The weather is great there\.) (100 :out)
      2 (0 san francisco 0)
         3 (There are a lot of beautiful places along the coastline between la and san francisco \. Really want to take a road trip there\.) (100 :out)
      2 (0 las vegas 0)
         3 (I really want to take a road trip from sf to las vegas with my friends\. They would have so much fun\.) (100 :out)
      2 (0 city city 0)
         3 (I have never been to 2 3 \, but it\'s in my wish list\.) (100 :out)
   1 (0 city 0) 
      2 (0 boston 0)
         3 (I\'ve taken a road trip to boston with college friends\. I thought boston is a nice place to live\.) (100 :out)
      2 (0 philadelphia 0)
         3 (I\'ve taken a road trip to philly\. I love the restraunts there\.) (100 :out)
      2 (0 la 0)
         3 (I have been to la just last month\. The weather is great there\.) (100 :out)
      2 (0 sf 0)
         3 (There are a lot of beautiful places along the coastline between la and sf\. Really want to take a road trip there\.) (100 :out)
      2 (0 nyc 0)
         3 (I have taken a road trip to nyc with your friends\. They played music during the ride and you have wonderful memories\.) (100 :out)
      2 (0 city 0)
         3 (I have never been to 2 \, but it\'s in my wish list\.) (100 :out)
   1 (0 state 0) 
      2 (0 california 0)
         3 (There are a lot of beautiful places along the coastline between la and san franci\. Really want to take a road trip there\.) (100 :out)
      2 (0 pennsylvania 0)
         3 (I have taken a road trip to philly\. I love the restraunts there\.) (100 :out)
      2 (0 state 0)
         3 (I have never been to 2 \, but it\'s in my wish list\.) (100 :out)
   1 (0 country country 0) 
      ;; 2 (0 united states 0)
      ;;    3 (Nice to take road trips in your own country\.) (100 :out)
      2 (0 united kingdom 0)
         3 (I wish I could take a road trip in uk\, but it\'s too far away for me \.) (100 :out)
      2 (0 city city 0)
         3 (I have never been to 2 3 \, but it\'s in my wish list\.) (100 :out)
   1 (0 country 0) 
      2 (0 germany 0)
         3 (I have been to germany several times\. Love their beers\.) (100 :out)
      2 (0 france 0)
         3 (Love french cuisines\. You must had a good time there\.) (100 :out)
      2 (0 italy 0)
         3 (Love their great artworks\. Wish I could take a few road trips there and also enjoy their countryside scenes\.) (100 :out)
      2 (0 country 0)
         3 (I have never been to 2 3 \, but it\'s in my wish list\.) (100 :out)
   1 (0 country-city 0) 
      2 (0 munich 0)
         3 (I have been to munich several times\. It is a diverse and beautiful city\.) (100 :out)
      2 (0 paris 0)
         3 (Have I visited the eiffel tower\? You had a great time there with your husband\.) (100 :out)
      2 (0 rome 0)
         3 (Love their great artworks\. Wish I could take a few road trips there and also enjoy their countryside scenes\.) (100 :out)
      2 (0 counrty-cities 0)
         3 (I have never been to 2 \, but it\'s in my wish list\.) (100 :out)
   1 (1 neg 1 like unexpected road trips 0)
      2 (An unprepared road trip can be very dangerous\.) (100 :out)
   1 (0 unexpected 0)
      2 (One can always learn something from new discoveries\.) (100 :out)
   1 (0 family 0)
      2 (Taking a road trip together is a great way to create unforgettable family memories\.) (100 :out)
   1 (0 friend 0)
      2 (I love to take road trips with my friends\. They would talk along the drive and it\'s a lot of fun\.) (100 :out)
   1 (0 yosemite national park 0)
      2 (Going to 2 3 4 can be a wonderful experience\. You just should make sure you have a good map with you \.) (100 :out)
   1 (0 national park 0)
      2 (Going to 2 3 can be a wonderful experience\. You just should make sure you have a good map with you \.) (100 :out)
   1 (0 camping 0)
      2 (Going to 2 can be a wonderful experience\. You just should make sure you have a good map with you \.) (100 :out)
      
   1 (0 NIL gist 0)
      2 (I never liked being stuck in a car for a while\, but it sounds like road trips can be fun\.) (100 :out)
))
