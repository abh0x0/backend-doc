# System Overview

## Core Architecture
```
Backend System
├── Business Core (golib/)
│   ├── Trading Engine
│   │   ├── Order Processing
│   │   ├── Price Management
│   │   └── Risk Management
│   ├── Payment System
│   │   ├── Gateway Integration (RazorPay)
│   │   ├── Transaction Processing
│   │   └── Balance Management
│   └── User Management
│       ├── Authentication (Firebase)
│       ├── KYC
│       └── Profile Management

├── API Layer (GraphQL)
│   ├── User APIs
│   ├── Admin APIs
│   └── Webhook Handlers

├── Data Layer
│   ├── PostgreSQL (Primary Store)
│   └── Redis (Caching)
```

## Key Design Patterns

### Repository Pattern
- Each model has interface + DB/Memory implementations
- Clear separation of data access and business logic
- Consistent patterns across all models

### Domain-Driven Design
- Isolated domains with clear boundaries
- Clean separation of business logic
- Model-driven development

### Service Layer
- GraphQL APIs for clients
- Clean separation of concerns
- Webhook handlers for integrations

## Critical Components

### Trading Engine
- Order execution flows
- Price feed management
- Exchange integrations (Binance, Bybit, FTX)
- Risk management system

### Payment System
- Multi-gateway support
- Transaction lifecycle
- Balance management
- Reconciliation processes

### Authentication
- Firebase integration
- JWT implementation
- Role-based access
- Session management

## Data Management
- PostgreSQL for primary data
- Redis for caching and sessions
- Clear migration strategy
- Data consistency patterns