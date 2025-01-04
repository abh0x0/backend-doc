# Database Documentation

## Primary Database

### Configuration
```go
Configuration {
    Host:      primary_db_host (default: localhost)
    Port:      primary_db_port (default: 5432)
    Database:  primary_db_database (default: primary)
    User:      primary_db_user
    MaxConnections: 100
    SSL:       Optional
}
```

### Core Tables

#### User Management
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    kyc_status VARCHAR(20)
);

CREATE TABLE accounts (
    user_id UUID REFERENCES users(id),
    type VARCHAR(20),
    status VARCHAR(20)
);

CREATE TABLE kyc_details (
    user_id UUID REFERENCES users(id),
    level VARCHAR(10),
    status VARCHAR(20)
);
```

#### Trading System
```sql
CREATE TABLE market_orders (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    status VARCHAR(20),
    side VARCHAR(10),
    amount DECIMAL,
    price DECIMAL
);

CREATE TABLE market_order_fills (
    order_id UUID REFERENCES market_orders(id),
    fill_price DECIMAL,
    fill_amount DECIMAL
);
```

#### Balance Management
```sql
CREATE TABLE balances (
    user_id UUID REFERENCES users(id),
    currency_id VARCHAR(10),
    amount DECIMAL,
    PRIMARY KEY (user_id, currency_id)
);

CREATE TABLE balance_changes (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    amount DECIMAL,
    type VARCHAR(50)
);
```

### Key Models
```go
User Related:
- usermodel/
- kycmodel/
- accountmodel/

Trading Related:
- marketordermodel/
- balancemodel/
- assetmodel/

Payment Related:
- paymentmodel/
- payoutmodel/
```

### Redis Usage
```go
Key Patterns:
- Session: session:{userId}
- Price: price:{asset}
- Cache: cache:{key}
```

### Database Migrations
```sql
001_init - Base schema
002_add_market_order_fills - Order management
003_add_table_exchanges - Exchange support
070_add_balance_change_id_in_payouts - Payment tracking
087_add_table_account_based_turbo_deposit_orders - Deposit handling
131_create_kyc_type_enum - KYC improvements
```

### Module Organization
```go
Primary Models:
- Balance management (balancemodel)
- User management (usermodel)
- Trading operations (marketordermodel)
- Payment processing (paymentmodel)
- KYC handling (kycmodel)

Support Models:
- Asset management (assetmodel)
- System configuration (systeminfomodel)
- Price management (pricecachemodel)
```