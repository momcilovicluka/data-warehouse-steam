import pandas as pd

# Read game data from the specified CSV file
games_df = pd.read_csv('/home/luka/Downloads/SEDS/archive/steamShort.csv')

# Read developer data from developers.csv
developers_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/developer.csv')

# Read publisher data from publishers.csv
publishers_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/publisher.csv')

# Extract relevant columns from games_df
result_df = games_df[['appid', 'name', 'release_date', 'price', 'achievements', 'developers', 'publishers']].copy()

# If the game is of type dlc, store the appid of the basegame as gameid, else set it to 0
result_df['gameid'] = games_df['fullgame'].str.extract(r"'appid': '(\d+)'", expand=False).fillna(0)

# Extract the first entry from developers and publishers columns
result_df['developers'] = result_df['developers'].str.split(',').str[0]
result_df['developers'] = result_df['developers'].str.replace('[\[\],\']', '', regex=True)
result_df['publishers'] = result_df['publishers'].str.split(',').str[0]
result_df['publishers'] = result_df['publishers'].str.replace('[\[\],\']', '', regex=True)

# Merge with developers_df to get developer_id
result_df = pd.merge(result_df, developers_df[['id', 'name']], how='left', left_on='developers', right_on='name')
result_df = result_df.rename(columns={'id': 'developer_id'})
result_df = result_df.drop(['name_y'], axis=1, errors='ignore')

# Merge with publishers_df to get publisher_id
result_df = pd.merge(result_df, publishers_df[['id', 'name']], how='left', left_on='publishers', right_on='name')
result_df = result_df.rename(columns={'id': 'publisher_id'})
result_df = result_df.drop(['name'], axis=1, errors='ignore')


# Remove rows with NaN values in 'developer_id' and 'publisher_id' columns
result_df = result_df.dropna(subset=['developer_id', 'publisher_id'])

# Convert 'developer_id' and 'publisher_id' to integers
result_df[['developer_id', 'publisher_id', 'achievements']] = result_df[['developer_id', 'publisher_id', 'achievements']].astype(int)

# Remove unnecessary columns and save the result to a new CSV file named games.csv
result_df = result_df[['appid', 'name_x', 'release_date', 'price', 'achievements', 'developer_id', 'publisher_id', 'gameid']]
result_df.to_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/game.csv', index=False)
