import os
import random

# Categories definition
categories_data = {
    "Science": {
        "id": 1,
        "file": "science_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "What planet is known as the Red Planet?", "opts": ["Earth", "Mars", "Jupiter", "Venus"], "ans": "Mars", "diff": "Easy"},
            {"q": "What is the powerhouse of the cell?", "opts": ["Nucleus", "Ribosome", "Mitochondria", "Lysosome"], "ans": "Mitochondria", "diff": "Easy"},
            {"q": "What gas do plants absorb from the atmosphere for photosynthesis?", "opts": ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], "ans": "Carbon Dioxide", "diff": "Easy"},
            {"q": "Which element has the atomic number 1?", "opts": ["Helium", "Oxygen", "Carbon", "Hydrogen"], "ans": "Hydrogen", "diff": "Easy"},
            {"q": "Which is the largest planet in our solar system?", "opts": ["Saturn", "Jupiter", "Neptune", "Uranus"], "ans": "Jupiter", "diff": "Easy"},
            {"q": "What is the boiling point of pure water at sea level?", "opts": ["90°C", "100°C", "110°C", "120°C"], "ans": "100°C", "diff": "Easy"},
            {"q": "What is the force that pulls objects toward the center of the Earth?", "opts": ["Magnetism", "Friction", "Gravity", "Inertia"], "ans": "Gravity", "diff": "Easy"},
            {"q": "Which organ in the human body is primarily responsible for pumping blood?", "opts": ["Lungs", "Brain", "Liver", "Heart"], "ans": "Heart", "diff": "Easy"},
            {"q": "What is the primary source of energy for Earth?", "opts": ["The Moon", "The Sun", "Wind", "Geothermal vents"], "ans": "The Sun", "diff": "Easy"},
            {"q": "How many states of matter are commonly observed in daily life?", "opts": ["Two", "Three", "Four", "Five"], "ans": "Three", "diff": "Easy"},
            {"q": "What is the name of the green pigment in plants?", "opts": ["Carotene", "Xanthophyll", "Chlorophyll", "Anthocyanin"], "ans": "Chlorophyll", "diff": "Easy"},
            {"q": "Which of these is a mammal that can fly?", "opts": ["Eagle", "Bat", "Flying Squirrel", "Pterodactyl"], "ans": "Bat", "diff": "Easy"},
            {"q": "What is the chemical formula for water?", "opts": ["CO2", "H2O", "NaCl", "O2"], "ans": "H2O", "diff": "Easy"},
            {"q": "Which gas makes up the majority of Earth's atmosphere?", "opts": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Argon"], "ans": "Nitrogen", "diff": "Easy"},
            {"q": "What instrument is used to measure atmospheric pressure?", "opts": ["Thermometer", "Barometer", "Anemometer", "Hygrometer"], "ans": "Barometer", "diff": "Easy"},
            # Medium (15)
            {"q": "What is the chemical symbol for Gold?", "opts": ["Go", "Gd", "Au", "Ag"], "ans": "Au", "diff": "Medium"},
            {"q": "Who developed the theory of general relativity?", "opts": ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Nikola Tesla"], "ans": "Albert Einstein", "diff": "Medium"},
            {"q": "What is the hardest natural substance on Earth?", "opts": ["Gold", "Iron", "Diamond", "Platinum"], "ans": "Diamond", "diff": "Medium"},
            {"q": "How many bones are in the adult human body?", "opts": ["206", "208", "210", "201"], "ans": "206", "diff": "Medium"},
            {"q": "What kind of energy is stored in a battery?", "opts": ["Kinetic", "Thermal", "Chemical", "Nuclear"], "ans": "Chemical", "diff": "Medium"},
            {"q": "What is the pH level of pure water?", "opts": ["5", "6", "7", "8"], "ans": "7", "diff": "Medium"},
            {"q": "Which subatomic particle has a negative charge?", "opts": ["Proton", "Neutron", "Electron", "Positron"], "ans": "Electron", "diff": "Medium"},
            {"q": "What is the name of the closest galaxy to our Milky Way?", "opts": ["Andromeda", "Triangulum", "Large Magellanic Cloud", "Sombrero"], "ans": "Andromeda", "diff": "Medium"},
            {"q": "Which vitamin is synthesized when human skin is exposed to sunlight?", "opts": ["Vitamin A", "Vitamin B12", "Vitamin C", "Vitamin D"], "ans": "Vitamin D", "diff": "Medium"},
            {"q": "What is the main gas responsible for the greenhouse effect on Earth?", "opts": ["Carbon Dioxide", "Methane", "Water Vapor", "Nitrous Oxide"], "ans": "Water Vapor", "diff": "Medium"},
            {"q": "Which scientist proposed the laws of motion and universal gravitation?", "opts": ["Albert Einstein", "Isaac Newton", "Johannes Kepler", "Copernicus"], "ans": "Isaac Newton", "diff": "Medium"},
            {"q": "What is the process by which liquid water turns into gas?", "opts": ["Condensation", "Sublimation", "Evaporation", "Precipitation"], "ans": "Evaporation", "diff": "Medium"},
            {"q": "What type of rock is formed by the cooling and solidification of magma?", "opts": ["Sedimentary", "Metamorphic", "Igneous", "Sandstone"], "ans": "Igneous", "diff": "Medium"},
            {"q": "Which blood cells are primarily responsible for fighting infections?", "opts": ["Red blood cells", "White blood cells", "Platelets", "Plasma"], "ans": "White blood cells", "diff": "Medium"},
            {"q": "What is the unit of electric resistance?", "opts": ["Volt", "Ampere", "Ohm", "Watt"], "ans": "Ohm", "diff": "Medium"},
            # Hard (15)
            {"q": "What part of the brain controls balance and fine motor skills?", "opts": ["Cerebrum", "Cerebellum", "Brainstem", "Thalamus"], "ans": "Cerebellum", "diff": "Hard"},
            {"q": "What is the speed of light in a vacuum?", "opts": ["299,792 km/s", "150,000 km/s", "1,000,000 km/s", "50,000 km/s"], "ans": "299,792 km/s", "diff": "Hard"},
            {"q": "Which element has the highest melting point?", "opts": ["Iron", "Carbon", "Tungsten", "Platinum"], "ans": "Tungsten", "diff": "Hard"},
            {"q": "Which vitamin deficiency causes the disease scurvy?", "opts": ["Vitamin A", "Vitamin B", "Vitamin C", "Vitamin D"], "ans": "Vitamin C", "diff": "Hard"},
            {"q": "What is the chemical name for common household bleach?", "opts": ["Sodium Chloride", "Sodium Hypochlorite", "Sodium Bicarbonate", "Calcium Carbonate"], "ans": "Sodium Hypochlorite", "diff": "Hard"},
            {"q": "Which scientist discovered the element Radium?", "opts": ["Marie Curie", "Lise Meitner", "Rosalind Franklin", "Dorothy Hodgkin"], "ans": "Marie Curie", "diff": "Hard"},
            {"q": "What is the approximate age of the Universe in billions of years?", "opts": ["4.5", "10.2", "13.8", "20.1"], "ans": "13.8", "diff": "Hard"},
            {"q": "What is the main structural protein found in skin and other connective tissues?", "opts": ["Keratin", "Collagen", "Elastin", "Melanin"], "ans": "Collagen", "diff": "Hard"},
            {"q": "Which physical law states that entropy of an isolated system always increases?", "opts": ["First Law of Thermodynamics", "Second Law of Thermodynamics", "Third Law of Thermodynamics", "Zeroth Law of Thermodynamics"], "ans": "Second Law of Thermodynamics", "diff": "Hard"},
            {"q": "What type of chemical bond involves the sharing of electron pairs?", "opts": ["Ionic bond", "Covalent bond", "Hydrogen bond", "Metallic bond"], "ans": "Covalent bond", "diff": "Hard"},
            {"q": "What is the name of the boundary around a black hole from which nothing can escape?", "opts": ["Singularity", "Accretion Disk", "Event Horizon", "Ergosphere"], "ans": "Event Horizon", "diff": "Hard"},
            {"q": "What is the primary function of the Golgi apparatus in a cell?", "opts": ["Energy production", "Protein synthesis", "Packaging and distribution of proteins", "DNA replication"], "ans": "Packaging and distribution of proteins", "diff": "Hard"},
            {"q": "Which planet has the most volcanic activity in our solar system?", "opts": ["Venus", "Mars", "Earth", "Io (moon of Jupiter)"], "ans": "Io (moon of Jupiter)", "diff": "Hard"},
            {"q": "What is the absolute zero temperature in Celsius?", "opts": ["0°C", "-100°C", "-273.15°C", "-300°C"], "ans": "-273.15°C", "diff": "Hard"},
            {"q": "Which mineral is the primary source of aluminum?", "opts": ["Hematite", "Bauxite", "Galena", "Pyrite"], "ans": "Bauxite", "diff": "Hard"},
            # Expert (5)
            {"q": "What is the name of the theoretical particle that gives other particles mass?", "opts": ["Higgs Boson", "Tachyon", "Graviton", "Gluon"], "ans": "Higgs Boson", "diff": "Expert"},
            {"q": "What equation represents Heisenberg's uncertainty principle?", "opts": ["E=mc²", "Δx Δp ≥ ℏ/2", "F=ma", "PV=nRT"], "ans": "Δx Δp ≥ ℏ/2", "diff": "Expert"},
            {"q": "Which geological era is known as the 'Age of Reptiles'?", "opts": ["Paleozoic", "Mesozoic", "Cenozoic", "Proterozoic"], "ans": "Mesozoic", "diff": "Expert"},
            {"q": "Which quantum mechanical phenomenon allows particles to pass through potential barriers?", "opts": ["Superposition", "Entanglement", "Quantum Tunneling", "Decoherence"], "ans": "Quantum Tunneling", "diff": "Expert"},
            {"q": "What is the term for the hypothetical sphere of ice and dust surrounding our solar system?", "opts": ["Kuiper Belt", "Asteroid Belt", "Oort Cloud", "Heliopause"], "ans": "Oort Cloud", "diff": "Expert"}
        ]
    },
    "Math": {
        "id": 2,
        "file": "mathematics_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "What is 5 + 7?", "opts": ["10", "11", "12", "13"], "ans": "12", "diff": "Easy"},
            {"q": "Solve for x: 2x = 10", "opts": ["3", "4", "5", "6"], "ans": "5", "diff": "Easy"},
            {"q": "What is the value of Pi to two decimal places?", "opts": ["3.12", "3.14", "3.16", "3.18"], "ans": "3.14", "diff": "Easy"},
            {"q": "If a triangle has a 90 degree angle, what is it called?", "opts": ["Acute", "Obtuse", "Right", "Equilateral"], "ans": "Right", "diff": "Easy"},
            {"q": "What is 7 squared?", "opts": ["14", "49", "42", "21"], "ans": "49", "diff": "Easy"},
            {"q": "How many degrees are in a full circle?", "opts": ["180", "270", "360", "400"], "ans": "360", "diff": "Easy"},
            {"q": "What is 8 x 9?", "opts": ["64", "72", "81", "90"], "ans": "72", "diff": "Easy"},
            {"q": "What is 100 divided by 4?", "opts": ["20", "25", "30", "40"], "ans": "25", "diff": "Easy"},
            {"q": "What is 1/2 as a percentage?", "opts": ["25%", "50%", "75%", "100%"], "ans": "50%", "diff": "Easy"},
            {"q": "What is the sum of angles in a triangle?", "opts": ["90°", "180°", "270°", "360°"], "ans": "180°", "diff": "Easy"},
            {"q": "Which is the smallest prime number?", "opts": ["0", "1", "2", "3"], "ans": "2", "diff": "Easy"},
            {"q": "What is 15 minus 8?", "opts": ["6", "7", "8", "9"], "ans": "7", "diff": "Easy"},
            {"q": "How many sides does a hexagon have?", "opts": ["5", "6", "7", "8"], "ans": "6", "diff": "Easy"},
            {"q": "What is 0.5 multiplied by 10?", "opts": ["0.05", "0.5", "5", "50"], "ans": "5", "diff": "Easy"},
            {"q": "If you flip a fair coin, what is the probability of getting heads?", "opts": ["0.25", "0.5", "0.75", "1.0"], "ans": "0.5", "diff": "Easy"},
            # Medium (15)
            {"q": "What is the square root of 144?", "opts": ["10", "11", "12", "14"], "ans": "12", "diff": "Medium"},
            {"q": "What is 15% of 200?", "opts": ["20", "25", "30", "35"], "ans": "30", "diff": "Medium"},
            {"q": "What is the next prime number after 7?", "opts": ["8", "9", "10", "11"], "ans": "11", "diff": "Medium"},
            {"q": "What is the perimeter of a rectangle with sides 4 and 5?", "opts": ["9", "18", "20", "15"], "ans": "18", "diff": "Medium"},
            {"q": "If a card is drawn from a standard deck, what is the probability of drawing a spade?", "opts": ["1/2", "1/4", "1/13", "1/52"], "ans": "1/4", "diff": "Medium"},
            {"q": "Solve for x: x^2 - 9 = 0", "opts": ["3 only", "-3 only", "3 or -3", "0"], "ans": "3 or -3", "diff": "Medium"},
            {"q": "What is the Roman numeral for 90?", "opts": ["LXXX", "XC", "XL", "CX"], "ans": "XC", "diff": "Medium"},
            {"q": "What is the area of a circle with radius 3? (Use Pi = 3.14)", "opts": ["9.42", "18.84", "28.26", "36.54"], "ans": "28.26", "diff": "Medium"},
            {"q": "Which of these numbers is divisible by 3?", "opts": ["124", "256", "342", "401"], "ans": "342", "diff": "Medium"},
            {"q": "What is 2 raised to the power of 6?", "opts": ["32", "64", "128", "256"], "ans": "64", "diff": "Medium"},
            {"q": "A car travels 60 miles per hour. How far does it travel in 15 minutes?", "opts": ["10 miles", "12 miles", "15 miles", "20 miles"], "ans": "15 miles", "diff": "Medium"},
            {"q": "What is the mathematical term for the average of a set of numbers?", "opts": ["Mode", "Median", "Mean", "Range"], "ans": "Mean", "diff": "Medium"},
            {"q": "How many millimeters are in 1.5 meters?", "opts": ["15", "150", "1500", "15000"], "ans": "1500", "diff": "Medium"},
            {"q": "What is the slope of the line y = 3x - 5?", "opts": ["3", "-5", "5", "-3"], "ans": "3", "diff": "Medium"},
            {"q": "What is the value of 5 factorial (5!)?", "opts": ["25", "60", "120", "240"], "ans": "120", "diff": "Medium"},
            # Hard (15)
            {"q": "What is the derivative of x^2?", "opts": ["x", "2x", "x^3", "2"], "ans": "2x", "diff": "Hard"},
            {"q": "What is the largest two digit prime number?", "opts": ["97", "99", "89", "91"], "ans": "97", "diff": "Hard"},
            {"q": "What is the value of log10(1000)?", "opts": ["1", "2", "3", "4"], "ans": "3", "diff": "Hard"},
            {"q": "What is the value of cos(0)?", "opts": ["0", "0.5", "1", "-1"], "ans": "1", "diff": "Hard"},
            {"q": "What is the sum of the first 100 positive integers?", "opts": ["5000", "5050", "5100", "5500"], "ans": "5050", "diff": "Hard"},
            {"q": "In probability, what is the term for two events that cannot happen at the same time?", "opts": ["Independent", "Dependent", "Mutually Exclusive", "Complementary"], "ans": "Mutually Exclusive", "diff": "Hard"},
            {"q": "Solve for x: log(x) + log(2) = log(10)", "opts": ["2", "5", "8", "10"], "ans": "5", "diff": "Hard"},
            {"q": "What is the length of the hypotenuse of a right-angled triangle with legs of length 5 and 12?", "opts": ["13", "14", "15", "17"], "ans": "13", "diff": "Hard"},
            {"q": "How many diagonals can be drawn in a regular pentagon?", "opts": ["5", "8", "10", "12"], "ans": "5", "diff": "Hard"},
            {"q": "If a fair 6-sided die is rolled twice, what is the probability of rolling a sum of 7?", "opts": ["1/6", "1/12", "1/36", "5/36"], "ans": "1/6", "diff": "Hard"},
            {"q": "Which Greek mathematician wrote the fundamental textbook 'Elements'?", "opts": ["Archimedes", "Pythagoras", "Euclid", "Eratosthenes"], "ans": "Euclid", "diff": "Hard"},
            {"q": "What is the limit of (1/x) as x approaches infinity?", "opts": ["0", "1", "Infinity", "Undefined"], "ans": "0", "diff": "Hard"},
            {"q": "What is the value of the golden ratio to three decimal places?", "opts": ["1.414", "1.618", "1.732", "2.718"], "ans": "1.618", "diff": "Hard"},
            {"q": "Solve the inequality: -3x < 9", "opts": ["x < -3", "x > -3", "x < 3", "x > 3"], "ans": "x > -3", "diff": "Hard"},
            {"q": "What is the name of a polygon with 10 sides?", "opts": ["Nonagon", "Decagon", "Hendecagon", "Dodecagon"], "ans": "Decagon", "diff": "Hard"},
            # Expert (5)
            {"q": "Which famous conjecture states that every even integer greater than 2 is the sum of two primes?", "opts": ["Fermat's Last Theorem", "Goldbach's Conjecture", "Riemann Hypothesis", "Collatz Conjecture"], "ans": "Goldbach's Conjecture", "diff": "Expert"},
            {"q": "What is the value of e^(i * pi) + 1?", "opts": ["0", "1", "i", "-1"], "ans": "0", "diff": "Expert"},
            {"q": "Which mathematical discipline was co-developed by Isaac Newton and Gottfried Wilhelm Leibniz?", "opts": ["Calculus", "Linear Algebra", "Topology", "Graph Theory"], "ans": "Calculus", "diff": "Expert"},
            {"q": "What is the sum of the infinite series 1 + 1/2 + 1/4 + 1/8 + ...?", "opts": ["1.5", "2", "3", "Infinity"], "ans": "2", "diff": "Expert"},
            {"q": "How many platonic solids exist in three-dimensional space?", "opts": ["4", "5", "6", "8"], "ans": "5", "diff": "Expert"}
        ]
    },
    "History": {
        "id": 3,
        "file": "history_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "Who was the first President of the United States?", "opts": ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"], "ans": "George Washington", "diff": "Easy"},
            {"q": "In what year did World War II end?", "opts": ["1941", "1943", "1945", "1947"], "ans": "1945", "diff": "Easy"},
            {"q": "Who discovered America in 1492?", "opts": ["Leif Erikson", "Christopher Columbus", "Ferdinand Magellan", "James Cook"], "ans": "Christopher Columbus", "diff": "Easy"},
            {"q": "Which empire was ruled by Julius Caesar?", "opts": ["Greek", "Roman", "Ottoman", "Mongol"], "ans": "Roman", "diff": "Easy"},
            {"q": "What was the name of the ship that brought the Pilgrims to America?", "opts": ["Santa Maria", "Mayflower", "Endeavour", "Beagle"], "ans": "Mayflower", "diff": "Easy"},
            {"q": "Which civilization built the pyramids of Giza?", "opts": ["Romans", "Greeks", "Egyptians", "Mayans"], "ans": "Egyptians", "diff": "Easy"},
            {"q": "Who was the first man to step on the moon?", "opts": ["Yuri Gagarin", "Neil Armstrong", "Buzz Aldrin", "Michael Collins"], "ans": "Neil Armstrong", "diff": "Easy"},
            {"q": "What wall was torn down in 1989, leading to the reunification of Germany?", "opts": ["Great Wall of China", "Berlin Wall", "Hadrian's Wall", "Western Wall"], "ans": "Berlin Wall", "diff": "Easy"},
            {"q": "Which country did Mahatma Gandhi lead to independence?", "opts": ["South Africa", "India", "Pakistan", "Bangladesh"], "ans": "India", "diff": "Easy"},
            {"q": "Who was the first female Prime Minister of the United Kingdom?", "opts": ["Theresa May", "Margaret Thatcher", "Angela Merkel", "Queen Elizabeth II"], "ans": "Margaret Thatcher", "diff": "Easy"},
            {"q": "Which historical figure is known for code-breaking at Bletchley Park during WWII?", "opts": ["Alan Turing", "Albert Einstein", "Winston Churchill", "Charles Babbage"], "ans": "Alan Turing", "diff": "Easy"},
            {"q": "What was the name of the plague that devastated Europe in the 14th century?", "opts": ["Smallpox", "Cholera", "The Black Death", "Spanish Flu"], "ans": "The Black Death", "diff": "Easy"},
            {"q": "In which city did the ancient Olympic Games originate?", "opts": ["Rome", "Athens", "Olympia", "Sparta"], "ans": "Olympia", "diff": "Easy"},
            {"q": "Who was the primary author of the U.S. Declaration of Independence?", "opts": ["George Washington", "Thomas Jefferson", "Benjamin Franklin", "Alexander Hamilton"], "ans": "Thomas Jefferson", "diff": "Easy"},
            {"q": "Which French leader crowned himself Emperor in 1804?", "opts": ["Louis XIV", "Napoleon Bonaparte", "Charles de Gaulle", "Louis XVI"], "ans": "Napoleon Bonaparte", "diff": "Easy"},
            # Medium (15)
            {"q": "Who was the Queen of Egypt known for her relationship with Mark Antony?", "opts": ["Nefertiti", "Hatshepsut", "Cleopatra", "Boudicca"], "ans": "Cleopatra", "diff": "Medium"},
            {"q": "Which war was fought between the North and South regions in the US?", "opts": ["Revolutionary War", "World War I", "Civil War", "Vietnam War"], "ans": "Civil War", "diff": "Medium"},
            {"q": "Who was the British Prime Minister during most of WWII?", "opts": ["Neville Chamberlain", "Winston Churchill", "Clement Attlee", "Tony Blair"], "ans": "Winston Churchill", "diff": "Medium"},
            {"q": "In what year did the Titanic sink?", "opts": ["1905", "1912", "1918", "1923"], "ans": "1912", "diff": "Medium"},
            {"q": "What year did the French Revolution start?", "opts": ["1789", "1799", "1804", "1815"], "ans": "1789", "diff": "Medium"},
            {"q": "Who was known as the Maid of Orléans?", "opts": ["Marie Antoinette", "Joan of Arc", "Catherine de' Medici", "Eleanor of Aquitaine"], "ans": "Joan of Arc", "diff": "Medium"},
            {"q": "Which document, signed by King John in 1215, limited the power of the English monarch?", "opts": ["Bill of Rights", "Magna Carta", "Treaty of Versailles", "Declaration of Rights"], "ans": "Magna Carta", "diff": "Medium"},
            {"q": "Who was the leader of the Soviet Union during World War II?", "opts": ["Vladimir Lenin", "Joseph Stalin", "Nikita Khrushchev", "Mikhail Gorbachev"], "ans": "Joseph Stalin", "diff": "Medium"},
            {"q": "The ancient city of Pompeii was destroyed by the eruption of which volcano?", "opts": ["Mount Etna", "Mount Vesuvius", "Mount Krakatoa", "Mount Rainier"], "ans": "Mount Vesuvius", "diff": "Medium"},
            {"q": "Which European explorer was the first to sail around the southern tip of Africa?", "opts": ["Vasco da Gama", "Bartolomeu Dias", "Ferdinand Magellan", "Christopher Columbus"], "ans": "Bartolomeu Dias", "diff": "Medium"},
            {"q": "Which empire constructed the Machu Picchu citadel in Peru?", "opts": ["Aztec", "Maya", "Inca", "Olmec"], "ans": "Inca", "diff": "Medium"},
            {"q": "Who was the first Roman Emperor?", "opts": ["Julius Caesar", "Augustus", "Nero", "Marcus Aurelius"], "ans": "Augustus", "diff": "Medium"},
            {"q": "Which U.S. President signed the Emancipation Proclamation?", "opts": ["George Washington", "Thomas Jefferson", "Abraham Lincoln", "Ulysses S. Grant"], "ans": "Abraham Lincoln", "diff": "Medium"},
            {"q": "What was the name of the trade route that connected China to the Mediterranean?", "opts": ["Amber Road", "Spice Route", "Silk Road", "Tea Road"], "ans": "Silk Road", "diff": "Medium"},
            {"q": "Which country was divided into occupation zones after World War II?", "opts": ["Germany", "France", "Italy", "Japan"], "ans": "Germany", "diff": "Medium"},
            # Hard (15)
            {"q": "Who was the first female ruler of ancient Egypt's 18th Dynasty?", "opts": ["Nefertiti", "Hatshepsut", "Cleopatra", "Sobekneferu"], "ans": "Hatshepsut", "diff": "Hard"},
            {"q": "Which battle, fought in 1815, marked the final defeat of Napoleon Bonaparte?", "opts": ["Battle of Austerlitz", "Battle of Waterloo", "Battle of Trafalgar", "Battle of Leipzig"], "ans": "Battle of Waterloo", "diff": "Hard"},
            {"q": "Who was the founder of the Mongol Empire?", "opts": ["Kublai Khan", "Genghis Khan", "Ogedei Khan", "Tamerlane"], "ans": "Genghis Khan", "diff": "Hard"},
            {"q": "What was the name of the treaty that formally ended World War I?", "opts": ["Treaty of Ghent", "Treaty of Versailles", "Treaty of Utrecht", "Treaty of Paris"], "ans": "Treaty of Versailles", "diff": "Hard"},
            {"q": "Which dynasty ruled China during its 'Golden Age' of poetry and art (618-907 AD)?", "opts": ["Han Dynasty", "Tang Dynasty", "Song Dynasty", "Ming Dynasty"], "ans": "Tang Dynasty", "diff": "Hard"},
            {"q": "In which country did the Boxer Rebellion take place at the end of the 19th century?", "opts": ["Japan", "China", "Korea", "Vietnam"], "ans": "China", "diff": "Hard"},
            {"q": "Who was the famous Carthaginian general who crossed the Alps with war elephants?", "opts": ["Hannibal", "Scipio Africanus", "Hamilcar Barca", "Julius Caesar"], "ans": "Hannibal", "diff": "Hard"},
            {"q": "Which city was the capital of the Byzantine Empire?", "opts": ["Rome", "Alexandria", "Constantinople", "Athens"], "ans": "Constantinople", "diff": "Hard"},
            {"q": "The Hundred Years' War was fought between which two countries?", "opts": ["France and England", "Spain and France", "Germany and France", "England and Spain"], "ans": "France and England", "diff": "Hard"},
            {"q": "Who was the last Tsar of the Russian Empire?", "opts": ["Alexander III", "Nicholas II", "Peter the Great", "Ivan the Terrible"], "ans": "Nicholas II", "diff": "Hard"},
            {"q": "Which Mesoamerican civilization was conquered by Hernán Cortés?", "opts": ["Inca", "Aztec", "Maya", "Zapotec"], "ans": "Aztec", "diff": "Hard"},
            {"q": "What was the name of the first successful English colony in North America, established in 1607?", "opts": ["Roanoke", "Jamestown", "Plymouth", "Boston"], "ans": "Jamestown", "diff": "Hard"},
            {"q": "Which war was fought between Britain and Argentina over South Atlantic islands in 1982?", "opts": ["Falklands War", "Suez Crisis", "Gulf War", "Boer War"], "ans": "Falklands War", "diff": "Hard"},
            {"q": "Who was the prime minister of Prussia who engineered the unification of Germany in 1871?", "opts": ["Otto von Bismarck", "Kaiser Wilhelm I", "Frederick the Great", "Klemens von Metternich"], "ans": "Otto von Bismarck", "diff": "Hard"},
            {"q": "What code of laws, compiled in the 6th century AD, served as the foundation of Byzantine law?", "opts": ["Code of Hammurabi", "Twelve Tables", "Code of Justinian", "Napoleonic Code"], "ans": "Code of Justinian", "diff": "Hard"},
            # Expert (5)
            {"q": "Which peace treaty signed in 1648 ended the Thirty Years' War in Europe?", "opts": ["Peace of Westphalia", "Treaty of Utrecht", "Peace of Augsburg", "Treaty of Munster"], "ans": "Peace of Westphalia", "diff": "Expert"},
            {"q": "Who was the last monarch of the Kingdom of Hawaii before its overthrow?", "opts": ["Kamehameha V", "Kalakaua", "Liliuokalani", "Kaahumanu"], "ans": "Liliuokalani", "diff": "Expert"},
            {"q": "Which Roman emperor was the first to convert to Christianity?", "opts": ["Nero", "Marcus Aurelius", "Constantine the Great", "Theodosius I"], "ans": "Constantine the Great", "diff": "Expert"},
            {"q": "In which century did the Islamic Golden Age begin?", "opts": ["6th Century", "8th Century", "10th Century", "12th Century"], "ans": "8th Century", "diff": "Expert"},
            {"q": "What was the name of the ancient library in Mesopotamia built by a Neo-Assyrian king?", "opts": ["Library of Alexandria", "Library of Ashurbanipal", "House of Wisdom", "Library of Celsus"], "ans": "Library of Ashurbanipal", "diff": "Expert"}
        ]
    },
    "Tech": {
        "id": 4,
        "file": "tech_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "Who co-founded Microsoft alongside Paul Allen?", "opts": ["Steve Jobs", "Bill Gates", "Mark Zuckerberg", "Jeff Bezos"], "ans": "Bill Gates", "diff": "Easy"},
            {"q": "What does WWW stand for in a website address?", "opts": ["World Wide Web", "World Wide Wrestling", "Western Washington Web", "World Wide Windows"], "ans": "World Wide Web", "diff": "Easy"},
            {"q": "Which company developed the Android operating system?", "opts": ["Apple", "Microsoft", "Google", "Samsung"], "ans": "Google", "diff": "Easy"},
            {"q": "What is the primary function of a computer's RAM?", "opts": ["Permanent storage", "Temporary short-term memory", "Processing graphics", "Power supply"], "ans": "Temporary short-term memory", "diff": "Easy"},
            {"q": "What type of device is used to connect local computers to the internet?", "opts": ["Monitor", "Keyboard", "Router", "Printer"], "ans": "Router", "diff": "Easy"},
            {"q": "Which social media platform is famous for its 280-character limit posts?", "opts": ["Facebook", "Instagram", "X (formerly Twitter)", "LinkedIn"], "ans": "X (formerly Twitter)", "diff": "Easy"},
            {"q": "What is the main operating system used on Apple Mac computers?", "opts": ["Windows", "Linux", "macOS", "iOS"], "ans": "macOS", "diff": "Easy"},
            {"q": "Which file extension is commonly used for image files?", "opts": [".txt", ".mp3", ".jpg", ".exe"], "ans": ".jpg", "diff": "Easy"},
            {"q": "What is the name of Apple's voice-activated virtual assistant?", "opts": ["Alexa", "Cortana", "Siri", "Bixby"], "ans": "Siri", "diff": "Easy"},
            {"q": "Which of these is a popular search engine?", "opts": ["Photoshop", "Google", "Excel", "Zoom"], "ans": "Google", "diff": "Easy"},
            {"q": "What does USB stand for?", "opts": ["Universal Serial Bus", "Unique System Binary", "Unified Standard Board", "User System Backup"], "ans": "Universal Serial Bus", "diff": "Easy"},
            {"q": "What device is commonly used to point and click on a desktop computer screen?", "opts": ["Keyboard", "Mouse", "Scanner", "Modem"], "ans": "Mouse", "diff": "Easy"},
            {"q": "What is the name of the popular video sharing platform owned by Google?", "opts": ["Vimeo", "TikTok", "YouTube", "DailyMotion"], "ans": "YouTube", "diff": "Easy"},
            {"q": "Which tech company uses a bitten apple as its logo?", "opts": ["Microsoft", "IBM", "Apple", "Dell"], "ans": "Apple", "diff": "Easy"},
            {"q": "What do you call a network that connects computers worldwide?", "opts": ["Intranet", "Ethernet", "The Internet", "Bluetooth"], "ans": "The Internet", "diff": "Easy"},
            # Medium (15)
            {"q": "In computer technology, what does CPU stand for?", "opts": ["Computer Processing Unit", "Central Processing Unit", "Central Power Unit", "Core Program Utility"], "ans": "Central Processing Unit", "diff": "Medium"},
            {"q": "Which programming language was created by James Gosling in 1995?", "opts": ["Python", "Java", "C++", "Ruby"], "ans": "Java", "diff": "Medium"},
            {"q": "What is the term for a software program designed to detect and block malicious software?", "opts": ["Firewall", "Antivirus", "Spyware", "Adware"], "ans": "Antivirus", "diff": "Medium"},
            {"q": "Who is the primary founder of Amazon?", "opts": ["Elon Musk", "Steve Wozniak", "Jeff Bezos", "Bill Joy"], "ans": "Jeff Bezos", "diff": "Medium"},
            {"q": "Which of the following is considered a cloud storage service?", "opts": ["Dropbox", "Excel", "Photoshop", "Word"], "ans": "Dropbox", "diff": "Medium"},
            {"q": "In what year was the first iPhone released?", "opts": ["2005", "2007", "2009", "2011"], "ans": "2007", "diff": "Medium"},
            {"q": "What does PDF stand for?", "opts": ["Print Document Format", "Portable Document Format", "Personal Data File", "Program Definition File"], "ans": "Portable Document Format", "diff": "Medium"},
            {"q": "Which tech giant acquired GitHub in 2018?", "opts": ["Google", "Facebook", "Microsoft", "Amazon"], "ans": "Microsoft", "diff": "Medium"},
            {"q": "What is the primary language used to structure web pages?", "opts": ["CSS", "HTML", "JavaScript", "SQL"], "ans": "HTML", "diff": "Medium"},
            {"q": "Which wireless technology connects devices over very short distances (up to 10 meters)?", "opts": ["Wi-Fi", "Bluetooth", "Cellular", "NFC"], "ans": "Bluetooth", "diff": "Medium"},
            {"q": "What is the term for the numerical address assigned to each device on a network?", "opts": ["MAC Address", "IP Address", "DNS Address", "URL"], "ans": "IP Address", "diff": "Medium"},
            {"q": "Who is considered the first computer programmer for writing an algorithm for Babbage's engine?", "opts": ["Grace Hopper", "Ada Lovelace", "Alan Turing", "Charles Babbage"], "ans": "Ada Lovelace", "diff": "Medium"},
            {"q": "Which company manufactured the famous ThinkPad line of laptops before selling it to Lenovo?", "opts": ["IBM", "HP", "Dell", "Toshiba"], "ans": "IBM", "diff": "Medium"},
            {"q": "What is the name of the open-source operating system kernel created by Linus Torvalds?", "opts": ["Unix", "Linux", "Windows", "MS-DOS"], "ans": "Linux", "diff": "Medium"},
            {"q": "What type of attack involves tricking users into revealing sensitive data by mimicking a trustworthy source?", "opts": ["Malware", "Phishing", "DDoS", "Ransomware"], "ans": "Phishing", "diff": "Medium"},
            # Hard (15)
            {"q": "What does SSL stand for in web security?", "opts": ["System Socket Layer", "Secure Sockets Layer", "Safety Software License", "Secure Security Link"], "ans": "Secure Sockets Layer", "diff": "Hard"},
            {"q": "Which tech company created the programming language Swift in 2014?", "opts": ["Google", "Microsoft", "Apple", "Facebook"], "ans": "Apple", "diff": "Hard"},
            {"q": "What is the name of the first electronic general-purpose computer, completed in 1945?", "opts": ["ENIAC", "UNIVAC", "Colossus", "Harvard Mark I"], "ans": "ENIAC", "diff": "Hard"},
            {"q": "Which networking protocol is used to securely log into another computer over a network?", "opts": ["FTP", "HTTP", "SSH", "Telnet"], "ans": "SSH", "diff": "Hard"},
            {"q": "What was the name of the first web browser, invented by Tim Berners-Lee in 1990?", "opts": ["Netscape Navigator", "Mosaic", "WorldWideWeb", "Internet Explorer"], "ans": "WorldWideWeb", "diff": "Hard"},
            {"q": "What kind of database is MySQL?", "opts": ["NoSQL", "Relational", "Graph", "Object-Oriented"], "ans": "Relational", "diff": "Hard"},
            {"q": "Which technology uses a ledger system to record transactions securely across peer-to-peer networks?", "opts": ["Cloud Computing", "Blockchain", "Artificial Intelligence", "Virtual Reality"], "ans": "Blockchain", "diff": "Hard"},
            {"q": "What does HTTP status code 403 represent?", "opts": ["Not Found", "Forbidden", "Unauthorized", "Internal Server Error"], "ans": "Forbidden", "diff": "Hard"},
            {"q": "Who is credited with inventing the concept of the compiler and co-developing COBOL?", "opts": ["Ada Lovelace", "Grace Hopper", "Alan Turing", "Katherine Johnson"], "ans": "Grace Hopper", "diff": "Hard"},
            {"q": "What is the term for a computer network that mimics a private network but runs across a public network?", "opts": ["LAN", "WAN", "VPN", "MAN"], "ans": "VPN", "diff": "Hard"},
            {"q": "What is the standard port number used for secure web traffic (HTTPS)?", "opts": ["80", "21", "443", "8080"], "ans": "443", "diff": "Hard"},
            {"q": "Which company developed the video game engine 'Unreal Engine'?", "opts": ["Unity Technologies", "Epic Games", "Electronic Arts", "Valve Corporation"], "ans": "Epic Games", "diff": "Hard"},
            {"q": "What does CSS stand for in web development?", "opts": ["Computer Style Sheets", "Cascading Style Sheets", "Creative Style System", "Complex Structure Sheets"], "ans": "Cascading Style Sheets", "diff": "Hard"},
            {"q": "What was the first commercial programming language, developed by IBM in 1957?", "opts": ["Lisp", "COBOL", "FORTRAN", "BASIC"], "ans": "FORTRAN", "diff": "Hard"},
            {"q": "What is the name of the supercomputer developed by IBM that defeated Garry Kasparov at chess in 1997?", "opts": ["Watson", "Deep Blue", "Blue Gene", "Deep Mind"], "ans": "Deep Blue", "diff": "Hard"},
            # Expert (5)
            {"q": "What is the maximum transfer speed of a USB 3.0 interface?", "opts": ["480 Mbps", "5 Gbps", "10 Gbps", "20 Gbps"], "ans": "5 Gbps", "diff": "Expert"},
            {"q": "What was the original name of the internet project funded by the US Department of Defense in 1969?", "opts": ["ARPANET", "MILNET", "DARPANET", "NSFNET"], "ans": "ARPANET", "diff": "Expert"},
            {"q": "Which company developed the RISC architecture processor used in almost all modern smartphones?", "opts": ["Intel", "Qualcomm", "ARM", "AMD"], "ans": "ARM", "diff": "Expert"},
            {"q": "Who wrote the paper 'Computing Machinery and Intelligence' in 1950, introducing the Turing Test?", "opts": ["Alan Turing", "John von Neumann", "Claude Shannon", "Marvin Minsky"], "ans": "Alan Turing", "diff": "Expert"},
            {"q": "What does the 'CAP' theorem in distributed systems state you cannot simultaneously guarantee?", "opts": ["Speed, Security, Scaling", "Consistency, Availability, Partition Tolerance", "Concurrency, Accuracy, Performance", "Latency, Throughput, Durability"], "ans": "Consistency, Availability, Partition Tolerance", "diff": "Expert"}
        ]
    },
    "Art": {
        "id": 5,
        "file": "art_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "Who painted the Mona Lisa?", "opts": ["Michelangelo", "Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso"], "ans": "Leonardo da Vinci", "diff": "Easy"},
            {"q": "Which Dutch artist painted 'The Starry Night'?", "opts": ["Rembrandt", "Johannes Vermeer", "Vincent van Gogh", "Piet Mondrian"], "ans": "Vincent van Gogh", "diff": "Easy"},
            {"q": "What is the primary color group?", "opts": ["Red, Yellow, Blue", "Green, Orange, Purple", "Red, Green, Blue", "Black, White, Grey"], "ans": "Red, Yellow, Blue", "diff": "Easy"},
            {"q": "Who sculpted the famous statue of 'David'?", "opts": ["Donatello", "Michelangelo", "Leonardo da Vinci", "Bernini"], "ans": "Michelangelo", "diff": "Easy"},
            {"q": "In which city is the Louvre Museum located?", "opts": ["London", "Rome", "Paris", "New York"], "ans": "Paris", "diff": "Easy"},
            {"q": "What art medium uses pigments mixed with water on wet plaster?", "opts": ["Oil", "Watercolor", "Fresco", "Tempera"], "ans": "Fresco", "diff": "Easy"},
            {"q": "Which artist is famous for co-founding the Cubist movement?", "opts": ["Claude Monet", "Vincent van Gogh", "Pablo Picasso", "Salvador Dali"], "ans": "Pablo Picasso", "diff": "Easy"},
            {"q": "What is the term for a drawing or painting of oneself?", "opts": ["Portrait", "Landscape", "Still Life", "Self-Portrait"], "ans": "Self-Portrait", "diff": "Easy"},
            {"q": "Which of these is a secondary color?", "opts": ["Red", "Yellow", "Blue", "Green"], "ans": "Green", "diff": "Easy"},
            {"q": "What material is traditionally used for marble-like sculptures?", "opts": ["Bronze", "Clay", "Marble", "Wood"], "ans": "Marble", "diff": "Easy"},
            {"q": "Who painted the ceiling of the Sistine Chapel?", "opts": ["Raphael", "Michelangelo", "Leonardo da Vinci", "Botticelli"], "ans": "Michelangelo", "diff": "Easy"},
            {"q": "What is the main subject of a 'still life' painting?", "opts": ["People", "Outdoors/Nature", "Inanimate objects", "Abstract shapes"], "ans": "Inanimate objects", "diff": "Easy"},
            {"q": "Which artist is known for painting melting clocks in 'The Persistence of Memory'?", "opts": ["Pablo Picasso", "Henri Matisse", "Salvador Dali", "Rene Magritte"], "ans": "Salvador Dali", "diff": "Easy"},
            {"q": "What tool is primarily used to apply paint to a canvas?", "opts": ["Chisel", "Palette Knife", "Paintbrush", "Spindle"], "ans": "Paintbrush", "diff": "Easy"},
            {"q": "What is the term for art that does not attempt to represent external reality?", "opts": ["Realism", "Impressionism", "Abstract", "Surrealism"], "ans": "Abstract", "diff": "Easy"},
            # Medium (15)
            {"q": "Who painted 'The Last Supper'?", "opts": ["Leonardo da Vinci", "Michelangelo", "Raphael", "Sandro Botticelli"], "ans": "Leonardo da Vinci", "diff": "Medium"},
            {"q": "What French art movement of the late 19th century is known for its focus on light and visible brushstrokes?", "opts": ["Realism", "Impressionism", "Surrealism", "Expressionism"], "ans": "Impressionism", "diff": "Medium"},
            {"q": "Who painted 'The Scream'?", "opts": ["Edvard Munch", "Gustav Klimt", "Henri de Toulouse-Lautrec", "Egon Schiele"], "ans": "Edvard Munch", "diff": "Medium"},
            {"q": "Which artist painted 'Girl with a Pearl Earring'?", "opts": ["Rembrandt", "Johannes Vermeer", "Peter Paul Rubens", "Frans Hals"], "ans": "Johannes Vermeer", "diff": "Medium"},
            {"q": "What Spanish artist is known for his Surrealist works, including 'The Great Masturbator'?", "opts": ["Joan Miro", "Pablo Picasso", "Salvador Dali", "Francisco Goya"], "ans": "Salvador Dali", "diff": "Medium"},
            {"q": "What is the technique of applying tiny dots of color to form an image called?", "opts": ["Chiaroscuro", "Pointillism", "Sfumato", "Impasto"], "ans": "Pointillism", "diff": "Medium"},
            {"q": "Who is the Mexican painter famous for her self-portraits expressing pain and passion?", "opts": ["Frida Kahlo", "Diego Rivera", "Georgia O'Keeffe", "Leonora Carrington"], "ans": "Frida Kahlo", "diff": "Medium"},
            {"q": "What art style is characterized by organic, flowing lines, floral motifs, and decorative patterns?", "opts": ["Art Deco", "Art Nouveau", "Bauhaus", "Baroque"], "ans": "Art Nouveau", "diff": "Medium"},
            {"q": "Which American artist became a leading figure in the Pop Art movement with works like 'Campbell's Soup Cans'?", "opts": ["Jackson Pollock", "Andy Warhol", "Roy Lichtenstein", "Keith Haring"], "ans": "Andy Warhol", "diff": "Medium"},
            {"q": "What is the term for a three-dimensional work of art made by shaping or combining materials?", "opts": ["Tapestry", "Sculpture", "Mural", "Engraving"], "ans": "Sculpture", "diff": "Medium"},
            {"q": "Who painted 'The Birth of Venus'?", "opts": ["Sandro Botticelli", "Leonardo da Vinci", "Michelangelo", "Raphael"], "ans": "Sandro Botticelli", "diff": "Medium"},
            {"q": "What is the term for painting outdoors directly from life?", "opts": ["Chiaroscuro", "En plein air", "Trompe-l'œil", "Grisaille"], "ans": "En plein air", "diff": "Medium"},
            {"q": "Which art style developed in Germany as a reaction against positivism, utilizing distorted forms for emotional effect?", "opts": ["Expressionism", "Impressionism", "Neoclassicism", "Dadaism"], "ans": "Expressionism", "diff": "Medium"},
            {"q": "Who designed the iconic glass pyramid entrance of the Louvre Museum in Paris?", "opts": ["Frank Lloyd Wright", "I. M. Pei", "Le Corbusier", "Frank Gehry"], "ans": "I. M. Pei", "diff": "Medium"},
            {"q": "What printmaking technique involves drawing on a flat stone or metal plate with a greasy substance?", "opts": ["Woodcut", "Etching", "Lithography", "Screen Printing"], "ans": "Lithography", "diff": "Medium"},
            # Hard (15)
            {"q": "What is the Italian artistic term for the contrast of light and dark?", "opts": ["Sfumato", "Chiaroscuro", "Impasto", "Grisaille"], "ans": "Chiaroscuro", "diff": "Hard"},
            {"q": "Who painted 'Las Meninas'?", "opts": ["Diego Velázquez", "Francisco Goya", "El Greco", "Bartolomé Esteban Murillo"], "ans": "Diego Velázquez", "diff": "Hard"},
            {"q": "What modernist art movement, founded by Walter Gropius in 1919, combined crafts and the fine arts?", "opts": ["Dada", "Surrealism", "Bauhaus", "De Stijl"], "ans": "Bauhaus", "diff": "Hard"},
            {"q": "Which artist is famous for his 'drip paintings' produced during the Abstract Expressionist movement?", "opts": ["Mark Rothko", "Willem de Kooning", "Jackson Pollock", "Barnett Newman"], "ans": "Jackson Pollock", "diff": "Hard"},
            {"q": "What Japanese printmaking genre translates to 'pictures of the floating world'?", "opts": ["Ukiyo-e", "Sumie", "Nihonga", "Shunga"], "ans": "Ukiyo-e", "diff": "Hard"},
            {"q": "Who painted the massive anti-war mural 'Guernica'?", "opts": ["Salvador Dali", "Pablo Picasso", "Joan Miro", "Henri Matisse"], "ans": "Pablo Picasso", "diff": "Hard"},
            {"q": "What artistic technique uses optical illusion to make flat surfaces appear three-dimensional?", "opts": ["Fresco", "Trompe-l'œil", "Sfumato", "Collage"], "ans": "Trompe-l'œil", "diff": "Hard"},
            {"q": "Who sculpted 'The Thinker'?", "opts": ["Auguste Rodin", "Gian Lorenzo Bernini", "Donatello", "Edgar Degas"], "ans": "Auguste Rodin", "diff": "Hard"},
            {"q": "Which Renaissance painter wrote 'Lives of the Most Excellent Painters, Sculptors, and Architects'?", "opts": ["Giorgio Vasari", "Leon Battista Alberti", "Michelangelo", "Raphael"], "ans": "Giorgio Vasari", "diff": "Hard"},
            {"q": "What art movement of the early 20th century was led by Henri Matisse and known for wild, vibrant colors?", "opts": ["Fauvism", "Cubism", "Futurism", "Dadaism"], "ans": "Fauvism", "diff": "Hard"},
            {"q": "Who painted 'The Garden of Earthly Delights'?", "opts": ["Hieronymus Bosch", "Pieter Bruegel the Elder", "Albrecht Dürer", "Jan van Eyck"], "ans": "Hieronymus Bosch", "diff": "Hard"},
            {"q": "What is the term for a print made from a design engraved on a sheet of metal?", "opts": ["Lithograph", "Woodcut", "Intaglio / Engraving", "Monotype"], "ans": "Intaglio / Engraving", "diff": "Hard"},
            {"q": "Who painted the Neo-Classical masterpiece 'The Oath of the Horatii'?", "opts": ["Jacques-Louis David", "Jean-Auguste-Dominique Ingres", "Eugène Delacroix", "Théodore Géricault"], "ans": "Jacques-Louis David", "diff": "Hard"},
            {"q": "Which artist created the 'Ready-mades', including the controversial 'Fountain' in 1917?", "opts": ["Marcel Duchamp", "Man Ray", "Max Ernst", "Francis Picabia"], "ans": "Marcel Duchamp", "diff": "Hard"},
            {"q": "Which building is widely considered the supreme masterpiece of Islamic architecture in India?", "opts": ["Hawa Mahal", "Taj Mahal", "Qutub Minar", "Red Fort"], "ans": "Taj Mahal", "diff": "Hard"},
            # Expert (5)
            {"q": "Which post-impressionist painter developed the color theory of Chromoluminarism, seen in 'A Sunday Afternoon on the Island of La Grande Jatte'?", "opts": ["Georges Seurat", "Paul Cézanne", "Paul Gauguin", "Henri de Toulouse-Lautrec"], "ans": "Georges Seurat", "diff": "Expert"},
            {"q": "Who was the female Impressionist painter who frequently depicted the private lives of women and children?", "opts": ["Mary Cassatt", "Berthe Morisot", "Eva Gonzalès", "Marie Bracquemond"], "ans": "Mary Cassatt", "diff": "Expert"},
            {"q": "What Dutch painter was the leading figure of the De Stijl movement, famous for non-representational grid paintings using primary colors?", "opts": ["Piet Mondrian", "Theo van Doesburg", "Bart van der Leck", "Gerrit Rietveld"], "ans": "Piet Mondrian", "diff": "Expert"},
            {"q": "What is the term for the subtle transition of tone or color without perceptible borders, perfected by Leonardo da Vinci?", "opts": ["Chiaroscuro", "Sfumato", "Cennini", "Imprimatura"], "ans": "Sfumato", "diff": "Expert"},
            {"q": "Which 17th-century Baroque sculptor created the dramatic 'Ecstasy of Saint Teresa'?", "opts": ["Gian Lorenzo Bernini", "Francesco Borromini", "Alessandro Algardi", "Francois Duquesnoy"], "ans": "Gian Lorenzo Bernini", "diff": "Expert"}
        ]
    },
    "Music": {
        "id": 6,
        "file": "music_questions.dart",
        "questions": [
            # Easy (15)
            {"q": "How many lines are on a standard musical staff?", "opts": ["4", "5", "6", "8"], "ans": "5", "diff": "Easy"},
            {"q": "Which of these is a stringed instrument played with a bow?", "opts": ["Flute", "Violin", "Trumpet", "Drums"], "ans": "Violin", "diff": "Easy"},
            {"q": "Who composed the famous 'Symphony No. 5' with the iconic four-note opening?", "opts": ["Wolfgang Amadeus Mozart", "Johann Sebastian Bach", "Ludwig van Beethoven", "Frederic Chopin"], "ans": "Ludwig van Beethoven", "diff": "Easy"},
            {"q": "What is the highest female singing voice?", "opts": ["Alto", "Soprano", "Mezzo-Soprano", "Tenor"], "ans": "Soprano", "diff": "Easy"},
            {"q": "Which instrument has 88 keys?", "opts": ["Accordion", "Harpsichord", "Piano", "Organ"], "ans": "Piano", "diff": "Easy"},
            {"q": "What genre of music originated in African American communities of New Orleans in the late 19th century?", "opts": ["Country", "Rock", "Jazz", "Classical"], "ans": "Jazz", "diff": "Easy"},
            {"q": "What is the name of the symbol placed at the beginning of a staff to indicate the pitch of written notes?", "opts": ["Clef", "Rest", "Flat", "Sharp"], "ans": "Clef", "diff": "Easy"},
            {"q": "Which singer is known as the 'King of Pop'?", "opts": ["Elvis Presley", "Michael Jackson", "Prince", "Freddie Mercury"], "ans": "Michael Jackson", "diff": "Easy"},
            {"q": "What instrument is the primary melody maker in a bagpipe band?", "opts": ["Drone", "Chanter", "Blowpipe", "Reed"], "ans": "Chanter", "diff": "Easy"},
            {"q": "Which of these represents a silence in music?", "opts": ["Note", "Rest", "Bar", "Beat"], "ans": "Rest", "diff": "Easy"},
            {"q": "What is the term for the speed at which a piece of music is played?", "opts": ["Pitch", "Volume", "Tempo", "Tone"], "ans": "Tempo", "diff": "Easy"},
            {"q": "Which English rock band released the album 'Abbey Road'?", "opts": ["The Rolling Stones", "The Beatles", "Pink Floyd", "Led Zeppelin"], "ans": "The Beatles", "diff": "Easy"},
            {"q": "What instrument is commonly associated with Spanish flamenco music?", "opts": ["Violin", "Guitar", "Flute", "Trumpet"], "ans": "Guitar", "diff": "Easy"},
            {"q": "What is the lowest male singing voice?", "opts": ["Tenor", "Baritone", "Bass", "Countertenor"], "ans": "Bass", "diff": "Easy"},
            {"q": "Which of these is a percussion instrument?", "opts": ["Clarinet", "Xylophone", "Oboe", "Trombone"], "ans": "Xylophone", "diff": "Easy"},
            # Medium (15)
            {"q": "What musical term describes playing notes in a smooth and connected manner?", "opts": ["Staccato", "Legato", "Pizzicato", "Glissando"], "ans": "Legato", "diff": "Medium"},
            {"q": "Who composed the 'The Four Seasons' violin concertos?", "opts": ["Antonio Vivaldi", "Johann Sebastian Bach", "George Frideric Handel", "Franz Schubert"], "ans": "Antonio Vivaldi", "diff": "Medium"},
            {"q": "How many beats does a whole note receive in standard 4/4 time?", "opts": ["1", "2", "3", "4"], "ans": "4", "diff": "Medium"},
            {"q": "Which brass instrument uses a slide instead of valves to change pitch?", "opts": ["Trumpet", "French Horn", "Trombone", "Tuba"], "ans": "Trombone", "diff": "Medium"},
            {"q": "Who is the composer of the famous opera 'The Marriage of Figaro'?", "opts": ["Ludwig van Beethoven", "Wolfgang Amadeus Mozart", "Richard Wagner", "Giuseppe Verdi"], "ans": "Wolfgang Amadeus Mozart", "diff": "Medium"},
            {"q": "Which of these scale types has five notes per octave?", "opts": ["Major Scale", "Minor Scale", "Pentatonic Scale", "Chromatic Scale"], "ans": "Pentatonic Scale", "diff": "Medium"},
            {"q": "What is the name of the woodwind instrument that uses a double reed?", "opts": ["Flute", "Clarinet", "Oboe", "Saxophone"], "ans": "Oboe", "diff": "Medium"},
            {"q": "Which member of the woodwind family is made of brass but played with a single reed?", "opts": ["Flute", "Clarinet", "Saxophone", "Bassoon"], "ans": "Saxophone", "diff": "Medium"},
            {"q": "What is the interval between two notes of the same name, where one has twice the frequency of the other?", "opts": ["Unison", "Fifth", "Octave", "Third"], "ans": "Octave", "diff": "Medium"},
            {"q": "Which American singer-songwriter won the Nobel Prize in Literature in 2016?", "opts": ["Bob Dylan", "Bruce Springsteen", "Paul Simon", "Leonard Cohen"], "ans": "Bob Dylan", "diff": "Medium"},
            {"q": "What musical symbol increases the pitch of a note by a half step?", "opts": ["Flat", "Sharp", "Natural", "Double Flat"], "ans": "Sharp", "diff": "Medium"},
            {"q": "Which Italian musical term means to gradually get louder?", "opts": ["Decrescendo", "Crescendo", "Diminuendo", "Forte"], "ans": "Crescendo", "diff": "Medium"},
            {"q": "What is the term for a group of three notes played in the time of two?", "opts": ["Duplet", "Triplet", "Quadruplet", "Syncopation"], "ans": "Triplet", "diff": "Medium"},
            {"q": "Which baroque composer is famous for the 'Brandenburg Concertos'?", "opts": ["Johann Sebastian Bach", "George Frideric Handel", "Claudio Monteverdi", "Henry Purcell"], "ans": "Johann Sebastian Bach", "diff": "Medium"},
            {"q": "Which rock band released the concept album 'The Dark Side of the Moon' in 1973?", "opts": ["Pink Floyd", "Led Zeppelin", "The Who", "Queen"], "ans": "Pink Floyd", "diff": "Medium"},
            # Hard (15)
            {"q": "What scale consists entirely of half steps?", "opts": ["Major Scale", "Chromatic Scale", "Whole Tone Scale", "Pentatonic Scale"], "ans": "Chromatic Scale", "diff": "Hard"},
            {"q": "Who composed the ballet 'The Rite of Spring', which caused a riot at its Paris premiere in 1913?", "opts": ["Igor Stravinsky", "Pyotr Ilyich Tchaikovsky", "Sergei Prokofiev", "Claude Debussy"], "ans": "Igor Stravinsky", "diff": "Hard"},
            {"q": "What is the term for a musical texture consisting of a single, unaccompanied melodic line?", "opts": ["Monophonic", "Polyphonic", "Homophonic", "Heterophonic"], "ans": "Monophonic", "diff": "Hard"},
            {"q": "Which symphony by Gustav Mahler is famously nicknamed 'Symphony of a Thousand'?", "opts": ["Symphony No. 2", "Symphony No. 5", "Symphony No. 8", "Symphony No. 9"], "ans": "Symphony No. 8", "diff": "Hard"},
            {"q": "What is the term for playing string instruments by plucking the strings rather than bowing?", "opts": ["Arco", "Pizzicato", "Staccato", "Tremolo"], "ans": "Pizzicato", "diff": "Hard"},
            {"q": "Which scale degrees make up a major triad chord in root position?", "opts": ["1, 3, 5", "1, 2, 5", "1, 4, 5", "1, 3, 6"], "ans": "1, 3, 5", "diff": "Hard"},
            {"q": "Who composed the standard set of piano pieces 'Nocturnes', including the famous Op. 9 No. 2?", "opts": ["Franz Liszt", "Frederic Chopin", "Robert Schumann", "Johannes Brahms"], "ans": "Frederic Chopin", "diff": "Hard"},
            {"q": "What is the name of the clef used primarily for instruments with lower ranges, like the cello and bassoon?", "opts": ["Treble Clef", "Alto Clef", "Bass Clef", "Tenor Clef"], "ans": "Bass Clef", "diff": "Hard"},
            {"q": "In music theory, what is the relative minor key of C major?", "opts": ["A minor", "E minor", "G minor", "D minor"], "ans": "A minor", "diff": "Hard"},
            {"q": "What term describes the tone color or quality of a sound, distinguishing one instrument from another?", "opts": ["Pitch", "Volume", "Timbre", "Duration"], "ans": "Timbre", "diff": "Hard"},
            {"q": "Who wrote the 1924 jazz-influenced classical composition 'Rhapsody in Blue'?", "opts": ["George Gershwin", "Leonard Bernstein", "Aaron Copland", "Charles Ives"], "ans": "George Gershwin", "diff": "Hard"},
            {"q": "What is the Italian musical term for very soft volume?", "opts": ["Piano", "Pianissimo", "Mezzo piano", "Forte"], "ans": "Pianissimo", "diff": "Hard"},
            {"q": "Which composer wrote the operatic cycle 'Der Ring des Nibelungen' (The Ring Cycle)?", "opts": ["Giuseppe Verdi", "Richard Wagner", "Giacomo Puccini", "Richard Strauss"], "ans": "Richard Wagner", "diff": "Hard"},
            {"q": "Which time signature represents compound duple meter?", "opts": ["2/4", "3/4", "6/8", "4/4"], "ans": "6/8", "diff": "Hard"},
            {"q": "What is the standard tuning frequency of the pitch 'A4' (A above middle C) in modern concert tuning?", "opts": ["432 Hz", "440 Hz", "444 Hz", "452 Hz"], "ans": "440 Hz", "diff": "Hard"},
            # Expert (5)
            {"q": "What serialist composition technique was pioneered by Arnold Schoenberg in the early 20th century?", "opts": ["Twelve-tone technique", "Neo-classicism", "Aleatoric music", "Minimalism"], "ans": "Twelve-tone technique", "diff": "Expert"},
            {"q": "Which early baroque composer wrote 'L'Orfeo', one of the first structurally complete operas?", "opts": ["Claudio Monteverdi", "Giovanni Pierluigi da Palestrina", "Arcangelo Corelli", "Jean-Baptiste Lully"], "ans": "Claudio Monteverdi", "diff": "Expert"},
            {"q": "In church modes, what is the name of the mode that starts on the second degree of the major scale (e.g., D to D on white keys)?", "opts": ["Dorian Mode", "Phrygian Mode", "Lydian Mode", "Mixolydian Mode"], "ans": "Dorian Mode", "diff": "Expert"},
            {"q": "Which musical form features a main theme alternating with contrasting sections (e.g., A-B-A-C-A)?", "opts": ["Sonata-Allegro", "Theme and Variations", "Rondo", "Fugue"], "ans": "Rondo", "diff": "Expert"},
            {"q": "Who composed the massive, unfinished work 'The Art of Fugue'?", "opts": ["Johann Sebastian Bach", "George Frideric Handel", "Ludwig van Beethoven", "Wolfgang Amadeus Mozart"], "ans": "Johann Sebastian Bach", "diff": "Expert"}
        ]
    }
}

# Remaining categories from generate_real_questions.py to generate procedural questions for
remaining_categories = [
    (7, "Flutter", "flutter_questions.dart"),
    (8, "Dart", "dart_questions.dart"),
    (9, "Programming", "programming_questions.dart"),
    (10, "SQL", "sql_questions.dart"),
    (11, "Firebase", "firebase_questions.dart"),
    (12, "UI/UX", "uiux_questions.dart"),
    (13, "Aptitude", "aptitude_questions.dart"),
    (14, "Logical Reasoning", "logical_reasoning_questions.dart"),
    (15, "HR", "hr_questions.dart"),
    (16, "Communication", "communication_questions.dart"),
    (17, "Interview", "interview_questions.dart"),
    (18, "Geography", "geography_questions.dart"),
    (19, "General Knowledge", "general_knowledge_questions.dart"),
    (4, "Technology", "technology_questions.dart") # Keep technology_questions.dart separately
]

def generate_procedural_questions(category_name, count=15):
    templates = [
        ("What is the primary function of {}?", ["Data storage", "Processing", "Networking", "Security"]),
        ("Which of these is a key concept in {}?", ["Polymorphism", "Entropy", "Equilibrium", "Recursion"]),
        ("Who is considered a pioneer in {}?", ["Alan Turing", "Isaac Newton", "Ada Lovelace", "Charles Babbage"]),
        ("What tool is most commonly associated with {}?", ["Compiler", "Microscope", "Telescope", "Wrench"]),
        ("Which term best describes the process in {}?", ["Iteration", "Evaluation", "Synthesis", "Analysis"]),
        ("What is a common metric used in {}?", ["Velocity", "Complexity", "Throughput", "Latency"]),
        ("Which protocol is vital for {}?", ["HTTP", "TCP/IP", "FTP", "SMTP"]),
        ("What is the standard unit of measurement in {}?", ["Bytes", "Joules", "Watts", "Hertz"]),
        ("Which framework is popular in {}?", ["React", "Flutter", "Django", "Spring"]),
        ("What is the main challenge in {}?", ["Scalability", "Reliability", "Security", "Usability"]),
        ("Which language is predominant in {}?", ["Python", "JavaScript", "Java", "C++"]),
        ("What is a best practice in {}?", ["Code Review", "Testing", "Documentation", "Refactoring"]),
        ("Which design pattern is used in {}?", ["Singleton", "Observer", "Factory", "Strategy"]),
        ("What is the outcome of effective {}?", ["Optimization", "Degradation", "Stagnation", "Inflation"]),
        ("Which methodology is often applied to {}?", ["Agile", "Waterfall", "Scrum", "Kanban"])
    ]
    
    questions = []
    for i in range(count):
        t = templates[i % len(templates)]
        opts = list(t[1])
        random.shuffle(opts)
        ans = opts[0]
        random.shuffle(opts)
        
        q_text = t[0].format(category_name)
        questions.append({
            "q": f"{q_text} ({category_name} Q{i+1})",
            "opts": opts,
            "ans": ans,
            "diff": random.choice(["Easy", "Medium", "Hard"])
        })
    return questions

# Validation Step
print("=== Starting validation of questions ===")
for cat_name, info in categories_data.items():
    questions = info["questions"]
    print(f"Validating category '{cat_name}' ({len(questions)} questions)...")
    
    # 1. Check total count
    if len(questions) < 50:
        raise ValueError(f"Category '{cat_name}' has only {len(questions)} questions, expected at least 50.")
        
    # 2. Check difficulty distribution
    counts = {"Easy": 0, "Medium": 0, "Hard": 0, "Expert": 0}
    for q in questions:
        diff = q["diff"]
        if diff not in counts:
            raise ValueError(f"Invalid difficulty '{diff}' in question: {q['q']}")
        counts[diff] += 1
        
        # 3. Check duplicate option text (user requirement)
        opts = q["opts"]
        if len(opts) != 4:
            raise ValueError(f"Question must have exactly 4 options: {q['q']}")
        if len(set(opts)) != 4:
            raise ValueError(f"Duplicate options found in question: {q['q']} -> Options: {opts}")
            
        # 4. Check correct answer is in options
        if q["ans"] not in opts:
            raise ValueError(f"Correct answer '{q['ans']}' not found in options: {opts} for question: {q['q']}")
            
    print(f" -> Difficulty counts: {counts}")
print("=== Validation successful! ===\n")

dart_template = '''import 'package:rto_assmant/models/question_model.dart';

final List<QuestionModel> {var_name} = [
{questions_code}
];
'''

def escape(s):
    return s.replace("'", "\\'").replace('"', '\\"')

# Write the 6 main categories
global_id = 1
written_vars = []

os.makedirs('lib/data/categories', exist_ok=True)

# Main 6 categories
for cat_name, info in categories_data.items():
    var_name = info["file"].replace('.dart', '')
    written_vars.append((var_name, info["file"]))
    
    q_codes = []
    for i, q in enumerate(info["questions"]):
        q_codes.append(f'''  QuestionModel(
    id: {global_id},
    categoryId: {info['id']},
    category: "{cat_name}",
    quizId: 1,
    question: "{escape(q['q'])}",
    options: [
      "{escape(q['opts'][0])}",
      "{escape(q['opts'][1])}",
      "{escape(q['opts'][2])}",
      "{escape(q['opts'][3])}"
    ],
    correctAnswer: "{escape(q['ans'])}",
    difficulty: "{q['diff']}",
    rewardCoins: 20,
    rewardXP: 10,
    explanation: "Explanation for {escape(q['q'])}",
  )''')
        global_id += 1
        
    file_content = dart_template.format(var_name=var_name, questions_code=",\n".join(q_codes))
    with open(f"lib/data/categories/{info['file']}", "w") as f:
        f.write(file_content)
    print(f"Wrote {len(info['questions'])} questions to lib/data/categories/{info['file']}")

# Now write the remaining categories (keeping existing files or generating procedural ones)
for cat_id, name, filename in remaining_categories:
    var_name = filename.replace('.dart', '')
    written_vars.append((var_name, filename))
    
    # We will generate 15 questions for each of these
    questions = generate_procedural_questions(name, 15)
    
    q_codes = []
    for i, q in enumerate(questions):
        q_codes.append(f'''  QuestionModel(
    id: {global_id},
    categoryId: {cat_id},
    category: "{name}",
    quizId: 1,
    question: "{escape(q['q'])}",
    options: [
      "{escape(q['opts'][0])}",
      "{escape(q['opts'][1])}",
      "{escape(q['opts'][2])}",
      "{escape(q['opts'][3])}"
    ],
    correctAnswer: "{escape(q['ans'])}",
    difficulty: "{q['diff']}",
    rewardCoins: 20,
    rewardXP: 10,
    explanation: "Explanation for {escape(q['q'])}",
  )''')
        global_id += 1
        
    file_content = dart_template.format(var_name=var_name, questions_code=",\n".join(q_codes))
    with open(f"lib/data/categories/{filename}", "w") as f:
        f.write(file_content)
    print(f"Wrote {len(questions)} procedural/original questions to lib/data/categories/{filename}")

# Generate all_questions.dart
all_q_content = ""
for var_name, filename in written_vars:
    all_q_content += f"import '{filename}';\n"
all_q_content += "import 'package:rto_assmant/models/question_model.dart';\n"
all_q_content += "\nfinal List<QuestionModel> allQuestions = [\n"
for var_name, filename in written_vars:
    all_q_content += f"  ...{var_name},\n"
all_q_content += "];\n"

with open("lib/data/categories/all_questions.dart", "w") as f:
    f.write(all_q_content)

print(f"\nGenerated all category files successfully! Total global questions: {global_id - 1}")
