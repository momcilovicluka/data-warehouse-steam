import pandas as pd

# Load the genres.csv file
genres_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/genre.csv')

# Read the original CSV file
df = pd.read_csv('/home/luka/Downloads/SEDS/archive/steamShort.csv')

# Drop unnecessary columns
df = df.drop(['type', 'required_age', 'dlc', 'fullgame', 'supported_languages', 'publishers', 'packages', 'platforms', 'categories', 'developers', 'achievements', 'release_date', 'supported_audio', 'coming_soon', 'price', 'review_score', 'total_positive', 'total_negative', 'rating', 'owners', 'average_forever', 'median_forever', 'tags'], axis=1)

# Convert the string representation of a list to a Python list using a lambda function
df['genres'] = df['genres'].apply(lambda x: eval(x) if isinstance(x, str) else [])

# Explode the 'genres' column to create new rows for each genre
df_exploded = df.explode('genres')

# Merge with genres_df to get genre IDs
merged_df = pd.merge(df_exploded, genres_df, how='left', left_on='genres', right_on='name')

# Drop unnecessary columns
merged_df = merged_df[['appid', 'id']].rename(columns={'id': 'genre_id'}).dropna().astype({'genre_id': 'int'})

# Export to CSV
merged_df.to_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/genreofgame.csv', index=False)
