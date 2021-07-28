# Find all words which contain exactly two vowels in any list in the table.


# Import your libraries
import pandas as pd

# Start writing code
df = google_word_lists
df['split1']=df.words1.apply(lambda x: x.split(','))
df['split2']=df.words2.apply(lambda x: x.split(','))
df['both_splits'] = df['split1']+df['split2']
list_of_words = df['both_splits'].explode().value_counts().index

def has_two_vowells(list_words):
    list_of_vowels = 'a,e,i,o,u'.split(',')
    two_vowell_words = []
    for word in list_words:
        if len([val for val in word if val.lower() in list_of_vowels]) == 2:
            two_vowell_words.append(word)
    return two_vowell_words

has_two_vowells(list_of_words)

# counts = total.str.count(r'a|e|i|o|u')
