import pandas as pd
import numpy as np

# Read games data from the specified CSV file
games_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/game.csv')

# Read purchase data from purchase1.csv
purchase_df = pd.read_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/purchase1.csv')

# Generate random purchase and game IDs for purchase_items
random_purchase_ids = np.random.choice(purchase_df['id'], size=len(games_df), replace=True)
random_game_ids = np.random.choice(games_df['appid'], size=len(games_df), replace=True)

# Create a DataFrame for purchase items
purchase_items_df = pd.DataFrame({
    'id': range(0, 0 + len(games_df)),
    'game_id': random_game_ids,
    'purchase_id': random_purchase_ids,
})

# Save the result to a new CSV file named purchase_items.csv
purchase_items_df.to_csv('/home/luka/git/momcilovicluka/seds-projekat/SQLImports/purchase_item1.csv', index=False)