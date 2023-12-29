import pandas as pd
import numpy as np

# Read games data from the specified CSV file
games_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/game.csv')

# Read purchase data from purchase1.csv
purchase_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/purchase.csv')

# Sort games by rating in descending order
games_df = games_df.sort_values('rating', ascending=False)

# Select the top 500 games
games_df = games_df.head(500)

# Generate random purchase and game IDs for purchase_items
random_purchase_ids = np.random.choice(purchase_df['id'], size=1500, replace=True)
random_game_ids = np.random.choice(games_df['appid'], size=1500, replace=True)

# Create a DataFrame for purchase items
purchase_items_df = pd.DataFrame({
    'id': range(8000, 8000 + 1500),
    'game_id': random_game_ids,
    'purchase_id': random_purchase_ids,
})

# Save the result to a new CSV file named purchase_items.csv
purchase_items_df.to_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/purchase_item_best.csv', index=False)