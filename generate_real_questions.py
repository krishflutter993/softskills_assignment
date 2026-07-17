import os

categories = [
    {
        "id": 1,
        "name": "Science",
        "file": "science_questions.dart",
        "questions": [
            {"q": "What planet is known as the Red Planet?", "opts": ["Earth", "Mars", "Jupiter", "Venus"], "ans": "Mars", "diff": "Easy"},
            {"q": "What is the powerhouse of the cell?", "opts": ["Nucleus", "Ribosome", "Mitochondria", "Lysosome"], "ans": "Mitochondria", "diff": "Easy"},
            {"q": "What is the chemical symbol for Gold?", "opts": ["Go", "Gd", "Au", "Ag"], "ans": "Au", "diff": "Medium"},
            {"q": "Who developed the theory of relativity?", "opts": ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Nikola Tesla"], "ans": "Albert Einstein", "diff": "Medium"},
            {"q": "What gas do plants absorb from the atmosphere?", "opts": ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], "ans": "Carbon Dioxide", "diff": "Easy"},
            {"q": "What is the speed of light?", "opts": ["300,000 km/s", "150,000 km/s", "1,000,000 km/s", "50,000 km/s"], "ans": "300,000 km/s", "diff": "Hard"},
            {"q": "What part of the brain controls balance?", "opts": ["Cerebrum", "Cerebellum", "Brainstem", "Thalamus"], "ans": "Cerebellum", "diff": "Hard"},
            {"q": "Which element has the atomic number 1?", "opts": ["Helium", "Oxygen", "Carbon", "Hydrogen"], "ans": "Hydrogen", "diff": "Easy"},
            {"q": "What is the hardest natural substance on Earth?", "opts": ["Gold", "Iron", "Diamond", "Platinum"], "ans": "Diamond", "diff": "Medium"},
            {"q": "How many bones are in the adult human body?", "opts": ["206", "208", "210", "201"], "ans": "206", "diff": "Medium"},
            {"q": "What is the main organ of the human cardiovascular system?", "opts": ["Lungs", "Brain", "Heart", "Liver"], "ans": "Heart", "diff": "Easy"},
            {"q": "Which planet is closest to the sun?", "opts": ["Venus", "Earth", "Mars", "Mercury"], "ans": "Mercury", "diff": "Easy"},
            {"q": "What kind of energy is stored in a battery?", "opts": ["Kinetic", "Thermal", "Chemical", "Nuclear"], "ans": "Chemical", "diff": "Medium"},
            {"q": "What is the pH level of pure water?", "opts": ["5", "6", "7", "8"], "ans": "7", "diff": "Medium"},
            {"q": "Which subatomic particle has a negative charge?", "opts": ["Proton", "Neutron", "Electron", "Nucleus"], "ans": "Electron", "diff": "Easy"}
        ]
    },
    {
        "id": 2,
        "name": "Math",
        "file": "mathematics_questions.dart",
        "questions": [
            {"q": "What is 5 + 7?", "opts": ["10", "11", "12", "13"], "ans": "12", "diff": "Easy"},
            {"q": "What is the square root of 144?", "opts": ["10", "11", "12", "14"], "ans": "12", "diff": "Medium"},
            {"q": "Solve for x: 2x = 10", "opts": ["3", "4", "5", "6"], "ans": "5", "diff": "Easy"},
            {"q": "What is the value of Pi to two decimal places?", "opts": ["3.12", "3.14", "3.16", "3.18"], "ans": "3.14", "diff": "Easy"},
            {"q": "What is 15% of 200?", "opts": ["20", "25", "30", "35"], "ans": "30", "diff": "Medium"},
            {"q": "If a triangle has a 90 degree angle, what is it called?", "opts": ["Acute", "Obtuse", "Right", "Equilateral"], "ans": "Right", "diff": "Easy"},
            {"q": "What is 7 squared?", "opts": ["14", "49", "42", "21"], "ans": "49", "diff": "Easy"},
            {"q": "What is the next prime number after 7?", "opts": ["8", "9", "10", "11"], "ans": "11", "diff": "Medium"},
            {"q": "How many degrees are in a full circle?", "opts": ["180", "270", "360", "400"], "ans": "360", "diff": "Easy"},
            {"q": "What is 8 x 9?", "opts": ["64", "72", "81", "90"], "ans": "72", "diff": "Easy"},
            {"q": "What is the derivative of x^2?", "opts": ["x", "2x", "x^3", "2"], "ans": "2x", "diff": "Hard"},
            {"q": "What is 100 divided by 4?", "opts": ["20", "25", "30", "40"], "ans": "25", "diff": "Easy"},
            {"q": "What is the perimeter of a rectangle with sides 4 and 5?", "opts": ["9", "18", "20", "15"], "ans": "18", "diff": "Medium"},
            {"q": "What is the largest two digit prime number?", "opts": ["97", "99", "89", "91"], "ans": "97", "diff": "Hard"},
            {"q": "What is 1/2 as a percentage?", "opts": ["25%", "50%", "75%", "100%"], "ans": "50%", "diff": "Easy"}
        ]
    },
    {
        "id": 3,
        "name": "History",
        "file": "history_questions.dart",
        "questions": [
            {"q": "Who was the first President of the United States?", "opts": ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"], "ans": "George Washington", "diff": "Easy"},
            {"q": "In what year did World War II end?", "opts": ["1941", "1943", "1945", "1947"], "ans": "1945", "diff": "Medium"},
            {"q": "Who discovered America in 1492?", "opts": ["Leif Erikson", "Christopher Columbus", "Ferdinand Magellan", "James Cook"], "ans": "Christopher Columbus", "diff": "Easy"},
            {"q": "Which empire was ruled by Julius Caesar?", "opts": ["Greek", "Roman", "Ottoman", "Mongol"], "ans": "Roman", "diff": "Easy"},
            {"q": "What was the name of the ship that brought the Pilgrims to America?", "opts": ["Santa Maria", "Mayflower", "Endeavour", "Beagle"], "ans": "Mayflower", "diff": "Medium"},
            {"q": "Who was the Queen of Egypt known for her relationship with Mark Antony?", "opts": ["Nefertiti", "Hatshepsut", "Cleopatra", "Boudicca"], "ans": "Cleopatra", "diff": "Medium"},
            {"q": "Which war was fought between the North and South regions in the US?", "opts": ["Revolutionary War", "World War I", "Civil War", "Vietnam War"], "ans": "Civil War", "diff": "Easy"},
            {"q": "Who was the British Prime Minister during most of WWII?", "opts": ["Neville Chamberlain", "Winston Churchill", "Clement Attlee", "Tony Blair"], "ans": "Winston Churchill", "diff": "Medium"},
            {"q": "In what year did the Titanic sink?", "opts": ["1905", "1912", "1918", "1923"], "ans": "1912", "diff": "Hard"},
            {"q": "What wall was torn down in 1989?", "opts": ["Great Wall of China", "Berlin Wall", "Hadrian's Wall", "Western Wall"], "ans": "Berlin Wall", "diff": "Easy"},
            {"q": "Who wrote the Declaration of Independence?", "opts": ["George Washington", "Thomas Jefferson", "Benjamin Franklin", "John Adams"], "ans": "Thomas Jefferson", "diff": "Medium"},
            {"q": "Which civilization built the pyramids of Giza?", "opts": ["Romans", "Greeks", "Egyptians", "Mayans"], "ans": "Egyptians", "diff": "Easy"},
            {"q": "Who was the first man to step on the moon?", "opts": ["Yuri Gagarin", "Neil Armstrong", "Buzz Aldrin", "Michael Collins"], "ans": "Neil Armstrong", "diff": "Easy"},
            {"q": "What year did the French Revolution start?", "opts": ["1789", "1799", "1804", "1815"], "ans": "1789", "diff": "Hard"},
            {"q": "Who was known as the Maid of Orléans?", "opts": ["Marie Antoinette", "Joan of Arc", "Catherine de' Medici", "Eleanor of Aquitaine"], "ans": "Joan of Arc", "diff": "Hard"}
        ]
    }
]

import random

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

remaining = [
    (4, "Tech", "technology_questions.dart"),
    (5, "Art", "art_questions.dart"),
    (6, "Music", "music_questions.dart"),
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
    (19, "General Knowledge", "general_knowledge_questions.dart")
]

for cat_id, name, filename in remaining:
    categories.append({
        "id": cat_id,
        "name": name,
        "file": filename,
        "questions": generate_procedural_questions(name, 15)
    })

dart_template = '''import 'package:rto_assmant/models/question_model.dart';

final List<QuestionModel> {var_name} = [
{questions_code}
];
'''

def escape(s):
    return s.replace("'", "\\'").replace('"', '\\"')

all_var_names = []

os.makedirs('lib/data/categories', exist_ok=True)

for cat in categories:
    var_name = cat['file'].replace('.dart', '')
    all_var_names.append(var_name)
    
    q_codes = []
    for i, q in enumerate(cat['questions']):
        q_codes.append(f'''  QuestionModel(
    id: {i+1},
    categoryId: {cat['id']},
    category: "{cat['name']}",
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
    
    file_content = dart_template.format(var_name=var_name, questions_code=",\n".join(q_codes))
    
    with open(f"lib/data/categories/{cat['file']}", "w") as f:
        f.write(file_content)

all_q_content = ""
for cat in categories:
    all_q_content += f"import 'package:rto_assmant/data/categories/{cat['file']}';\n"
all_q_content += "\nfinal List<QuestionModel> allQuestions = [\n"
for var in all_var_names:
    all_q_content += f"  ...{var},\n"
all_q_content += "];\n"

with open("lib/data/categories/all_questions.dart", "w") as f:
    f.write(all_q_content)

print("Generated all 19 category files successfully!")
