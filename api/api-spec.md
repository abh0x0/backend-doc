# API Documentation

## GraphQL APIs

### Common Types

#### Amount
```graphql
type Amount {
    value: Decimal!
    currency: Currency!
}
```

#### Auth
```graphql
type AuthResponse {
    token: String!
    user: User!
}
```

#### Balance
```graphql
type Balance {
    amount: Amount!
    lastUpdated: DateTime!
}

type BalanceHistoryEvent {
    amount: Amount!
    timestamp: DateTime!
    type: String!
}
```

### User Facing APIs

```graphql
type Query {
    profile: User!
    balances: [Balance!]!
    marketOrders: [MarketOrder!]!
    orderBook(symbol: String!): OrderBook!
    paymentHistory: [Payment!]!
}

type Mutation {
    login(input: LoginInput!): AuthResponse!
    createMarketOrder(input: MarketOrderInput!): MarketOrder!
    initiatePayment(input: PaymentInput!): Payment!
}
```

### Admin APIs

```graphql
type Query {
    users(filter: UserFilter): [User!]!
    systemMetrics: SystemMetrics!
}

type Mutation {
    updateUserStatus(input: UpdateUserStatusInput!): User!
    updateSystemConfig(input: SystemConfigInput!): Boolean!
}
```

## Webhook Handlers

### Payment Gateway (RazorPay)
```typescript
POST /webhooks/payment
{
    "event": "payment.success",
    "paymentId": string,
    "amount": number,
    "status": string
}
```

### Blockchain Transactions
```typescript
POST /webhooks/tx
{
    "type": "transaction",
    "data": {
        "txHash": string,
        "blockNumber": number,
        "amount": string
    }
}
```

## Integration Points

### Exchange Integrations
```go
Supported Exchanges:
- Binance (binanceapi/)
- Bybit (bybitapi/)
- FTX (ftxapi/)
```

### Payment Integration
```go
Primary: RazorPay
Test: Fixed API for testing
```

### Authentication
```go
Primary: Firebase
JWT: Internal token management
```