# Example Design: Order Management API

> This is a **template** showing how feature specs should be structured.
> Replace the content below with your actual design.

## Context

We need an API for managing customer orders. The system supports multiple dealers with hierarchical relationships (manufacturer → dealer). Each dealer has a credit limit and can place orders against it.

## Chosen Approach

**REST API over HTTP** with resource-oriented endpoints.

Rationale:

- Fits the existing web stack (no new protocols)
- Broad client compatibility (web, mobile, third-party)
- Stateless — scales horizontally

## Key Design Decisions

| Decision        | Choice                     | Why                                               |
| --------------- | -------------------------- | ------------------------------------------------- |
| Auth            | JWT in httpOnly cookie     | Prevents XSS token theft; sameSite strict         |
| Validation      | Zod schemas                | Type-safe, composable, generates TypeScript types |
| Database access | Prisma ORM                 | Type-safe queries, migrations, existing schema    |
| Error format    | RFC 7807 (Problem Details) | Standard machine-readable error format            |

## Data Model

```prisma
model Order {
  id          String   @id @default(cuid())
  dealerId    String
  customerId  String
  items       OrderItem[]
  total       Decimal
  status      OrderStatus @default(PENDING)
  createdAt   DateTime   @default(now())
  updatedAt   DateTime   @updatedAt
}

model OrderItem {
  id        String  @id @default(cuid())
  orderId   String
  productId String
  quantity  Int
  unitPrice Decimal
}

enum OrderStatus {
  PENDING
  CONFIRMED
  SHIPPED
  CANCELLED
}
```

## API Endpoints

| Method | Path                   | Auth  | Description                                   |
| ------ | ---------------------- | ----- | --------------------------------------------- |
| GET    | /api/orders            | JWT   | List orders (dealer sees own; admin sees all) |
| POST   | /api/orders            | JWT   | Create order (validates dealer credit limit)  |
| GET    | /api/orders/:id        | JWT   | Get order detail                              |
| PATCH  | /api/orders/:id/status | Admin | Update order status                           |

## Open Questions

1. Should partial shipments be allowed? (Currently: all-or-nothing)
2. What's the cancellation window — before confirmation only?
3. Should order totals include tax or be net-only?
