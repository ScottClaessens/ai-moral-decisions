# Data README file

**Project title:** Should AI Make Moral Decisions?

**Principal investigator:** Dr. Scott Claessens (scott.claessens@gmail.com)

**Head researcher:** Dr. Jim Everett (j.a.c.everett@kent.ac.uk)

**Institution:** University of Kent

**Data collection platform:** Prolific

**Data collected on:** 25th September 2025

**Data collection country:** United Kingdom

**File formats:** CSV files

**Files:** 

- `data_participants.csv` - participant-level data
- `data_decisions.csv` - decisions in the main game
- `data_perceptions.csv` - perceptions of different moral decisions

**Columns in `data_participants.csv`:**

- `id` - numeric, participant identification number
- `age` - numeric, participant's reported age in years
- `gender` - character, participant's self-reported gender identity
- `attention` - character, response to the attention check question. The
question was "When an important event is happening or is about to happen, many 
people try to get informed about the development of the situation. In such 
situations, where do you get your information from?" On the previous page,
participants are asked to respond to this question by saying "TikTok"
- `enjoy` - numeric, 1-7 Likert scale, response to the question "How much did 
you enjoy answering the questions?" from (1) Not At All to (7) Very Much
- `length` - numeric, 1-5 Likert scale, response to the question "From the 
point of view of your interest and patience, how was the game length?" with the
options (1) Far too long, (2) Slightly too long, (3) The right length, (4) Could
be a bit longer, and (5) Could be a lot longer
- `feedback` - character, response to the open-ended question "Do you have any 
other feedback about the game?"
- `openended` - character, response to the open-ended question "Do you have any
remarks or comments about today's study?"

**Columns in `data_decisions.csv`:**

- `id` - numeric, participant identification number
- `verb` - character, verb presented to participants, either "Decide" or 
"Advise" (randomly counterbalanced)
- `domain` - character, the domain of the moral decision, options include 
Transport, Justice, Healthcare, Business, Military, Disaster relief, Social 
media, Government, Finance, and Education
- `item` - character, the particular moral decision in that domain
- `decision` - character, response to the question "Should AI decide / advise on
[item]?", either "Yes" or "No"

**Columns in `data_perceptions.csv`:**

- `id` - numeric, participant identification number
- `domain` - character, the domain of the moral decision, options include 
Transport, Justice, Healthcare, Business, Military, Disaster relief, Social 
media, Government, Finance, and Education
- `item` - character, the particular moral decision in that domain
- `intelligence` - numeric, 1-7 Likert scale, response to the question "Does
making this decision require intelligence?" from (1) Not At All to (7) Very Much
- `empathy` - numeric, 1-7 Likert scale, response to the question "Does making 
this decision require empathy?" from (1) Not At All to (7) Very Much
- `quickly` - numeric, 1-7 Likert scale, response to the question "Does this 
decision need to be made quickly?" from (1) Not At All to (7) Very Much
- `transparently` - numeric, 1-7 Likert scale, response to the question "Does
this decision need to be made transparently?" from (1) Not At All to (7) Very
Much
- `difficult` - numeric, 1-7 Likert scale, response to the question "Is this a 
difficult decision to make?" from (1) Not At All to (7) Very Much
- `good_outcomes` - numeric, 1-7 Likert scale, response to the question "Could 
this decision produce good outcomes?" from (1) Not At All to (7) Very Much
- `harm` - numeric, 1-7 Likert scale, response to the question "Could this 
decision result in harm?" from (1) Not At All to (7) Very Much
- `unfair_outcomes` - numeric, 1-7 Likert scale, response to the question "Could
this decision lead to unfair outcomes?" from (1) Not At All to (7) Very Much
