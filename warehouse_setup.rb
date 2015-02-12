# Get results as hash
DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY 
          KEY, city TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY,
          serial_number INTEGER, description TEXT, quantity INTEGER, cost
          INTEGER, location_id INTEGER, category_id INTEGER)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY
          KEY, name TEXT)")