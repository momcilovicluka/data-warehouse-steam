import ast
import pandas as pd
import random as ra
import numpy as np

# read csv
df = pd.read_csv('/home/luka/Downloads/SEDS/archive/steamShort.csv')

# drop everything except genres
df = df.drop(['appid', 'type', 'name', 'required_age', 'dlc', 'fullgame', 'supported_languages', 'publishers', 'packages', 'platforms', 'categories', 'developers', 'achievements', 'release_date', 'supported_audio', 'coming_soon', 'price', 'review_score', 'total_positive', 'total_negative', 'rating', 'owners', 'average_forever', 'median_forever', 'genres'], axis=1)

# Fill NaN values in 'genres' with an empty list
df['tags'] = df['tags'].fillna('[]')

# Convert the string representation of a list to a Python list
df['tags'] = df['tags'].apply(ast.literal_eval)

# Explode the 'genres' column to create new rows for each genre
df_exploded = df.explode('tags')

# Drop duplicates
df_exploded = df_exploded.drop_duplicates()

# Filter out rows where 'name' is an empty string or NaN
df_exploded = df_exploded[df_exploded['tags'].notna() & (df_exploded['tags'] != '')]

# Reset the index
df_exploded = df_exploded.reset_index(drop=True)

# Rename the 'genres' column to 'name'
df_exploded = df_exploded.rename(columns={'tags': 'name'})

# Export to CSV index by one
df_exploded.to_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/tag.csv', index=True)
