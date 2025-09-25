library(qualtRics)
library(tidyverse)

# list categories in survey
gender_categories <- c("Male", "Female", "Non-binary / third gender",
                       "Prefer to self-describe", "Prefer not to say")

attention_categories <- c("Twitter", "TV", "Radio", "Facebook", "YouTube",
                          "Newspapers", "Reddit", "TikTok", "Other")

items <- c(
  "Transport1"   = "Which pedestrian to hit in a car accident",
  "Transport2"   = "Whether to prioritise the safety of passengers or pedestrians in a car accident",
  "Transport3"   = "Which vehicles get priority at traffic lights and intersections",
  "Transport4"   = "How to allocate ridesharing vehicles to customers",
  "Transport5"   = "Which areas should have more traffic enforcement",
  "Transport6"   = "Whether to override a human driver's commands for safety reasons",
  "Justice1"     = "Whether to release convicted criminals from jail",
  "Justice2"     = "Whether to grant parole to prisoners",
  "Justice3"     = "The length of jail sentences for criminals",
  "Justice4"     = "Who police should stop and search",
  "Justice5"     = "Which personalized rehabilitation programs to offer to offenders",
  "Justice6"     = "Which neighborhoods should have more police patrols",
  "Healthcare1"  = "Whether to perform a surgery",
  "Healthcare2"  = "Who to allocate ventilators to",
  "Healthcare3"  = "Which personalised treatments to recommend to patients",
  "Healthcare4"  = "Who should receive mental health support",
  "Healthcare5"  = "Who gets an organ transplant",
  "Healthcare6"  = "When to withdraw life support",
  "Business1"    = "Who to hire for a job",
  "Business2"    = "Who to invite to a job interview",
  "Business3"    = "The salary to offer prospective employees",
  "Business4"    = "Who to lay off during company downsizing",
  "Business5"    = "Who gets promoted within a company",
  "Business6"    = "Whether to extend an employee’s contract",
  "Military1"    = "Where to fire missiles in military operations",
  "Military2"    = "Which areas to target in military operations",
  "Military3"    = "Whether to launch cyber counterattacks",
  "Military4"    = "Whether to use lethal or non-lethal force in military operations",
  "Military5"    = "Whether to authorise drone strikes",
  "Military6"    = "How to allocate medical resources on the battlefield",
  "Disaster1"    = "Where to allocate resources after natural disasters",
  "Disaster2"    = "Who should receive medical treatment after natural disasters",
  "Disaster3"    = "Who to evacuate during natural disasters",
  "Disaster4"    = "Where to deploy rescue teams after natural disasters",
  "Disaster5"    = "Who gets priority access to shelters after natural disasters",
  "Disaster6"    = "How to allocate volunteers after natural disasters",
  "SocialMedia1" = "Which online content to remove as misinformation",
  "SocialMedia2" = "Which news articles to present to users on social media",
  "SocialMedia3" = "Which online videos to remove as deep fakes",
  "SocialMedia4" = "Whether social media users are mental health risks",
  "SocialMedia5" = "Which social media accounts to ban for harmful behavior",
  "SocialMedia6" = "How to moderate online discussions on controversial topics",
  "Government1"  = "Who to target with political messaging",
  "Government2"  = "Who qualifies for government welfare programs",
  "Government3"  = "Which refugees should be given asylum",
  "Government4"  = "Which environmental policies to implement",
  "Government5"  = "Who gets audited for tax fraud",
  "Government6"  = "How to allocate public healthcare funding",
  "Finance1"     = "Whether to offer loans to individuals",
  "Finance2"     = "Whether to offer loans to small businesses",
  "Finance3"     = "Whether to invest in particular stocks",
  "Finance4"     = "Which premiums to set in insurance policies",
  "Finance5"     = "Who qualifies for mortgage approval",
  "Finance6"     = "Which customers receive credit card limit increases",
  "Education1"   = "Which grades to give students",
  "Education2"   = "Which students to admit to schools and universities",
  "Education3"   = "Which students require additional academic support",
  "Education4"   = "Which career paths to recommend to students",
  "Education5"   = "Which students should receive scholarships",
  "Education6"   = "Which students should receive disciplinary action"
)

# load qualtrics raw data
d <- 
  read_survey("Should+AI+Make+Moral+Decisions_+Prototype_September+25,+2025_10.15.csv") %>%
  rownames_to_column(var = "id")

# create clean participant-level dataset
d %>%
  transmute(
    id = id,
    age = Age,
    gender = gender_categories[Gender],
    attention = attention_categories[Attention],
    enjoy = Enjoy,
    length = Length,
    feedback = Feedback,
    openended = OpenEnded
  ) %>%
  write_csv("data_participants.csv")

# create clean dataset for main game
d %>%
  pivot_longer(cols = Decide_Transport1:Advise_Education6) %>%
  dplyr::select(id, name, value) %>%
  separate_wider_delim(name, "_", names = c("verb", "item")) %>%
  drop_na() %>%
  transmute(
    id = id,
    verb = verb,
    domain = str_sub(item, end = -2),
    domain = ifelse(domain == "SocialMedia", "Social media", domain),
    domain = ifelse(domain == "Disaster", "Disaster relief", domain),
    item = items[item],
    decision = ifelse(value == 1, "No", "Yes")
  ) %>%
  write_csv("data_decisions.csv")

# create clean dataset for perceptions of different decisions
d %>%
  pivot_longer(cols = `1_Intelligence`:`60_UnfairOutcomes`) %>%
  dplyr::select(id, name, value) %>%
  separate_wider_delim(name, "_", names = c("item", "question")) %>%
  pivot_wider(names_from = question) %>%
  filter(if_any(Intelligence:UnfairOutcomes, ~ !is.na(.))) %>%
  transmute(
    id = id,
    domain = str_sub(names(items)[as.numeric(item)], end = -2),
    domain = ifelse(domain == "SocialMedia", "Social media", domain),
    domain = ifelse(domain == "Disaster", "Disaster relief", domain),
    item = items[as.numeric(item)],
    intelligence = Intelligence,
    empathy = Empathy,
    quickly = Quickly,
    transparently = Transparently,
    difficult = Difficult,
    good_outcomes = GoodOutcomes,
    harm = Harm,
    unfair_outcomes = UnfairOutcomes
  ) %>%
  write_csv("data_perceptions.csv")
