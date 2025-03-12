# Mini Client RPC with Sinatra

This project is a minimal Sinatra-based client that interacts with a server using the `forest_admin_rpc_agent` library.

## Prerequisites

- Ruby (>= 3.3.1)
- SQLite3

## Installation

1. Install dependencies:
```bash
bundle install
```

2. Migration & seed database:
```bash
rake db:migrate
rake db:seed
```

3. Start app:
```bash
ruby app.rb
```
