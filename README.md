# StockIO v2
**Production-Style Inventory Management System**
Rails 8 · Turbo / Hotwire · PostgreSQL · JSON API

StockIO v2 is a full-stack inventory management application rebuilt from the ground up using **Ruby on Rails 8**, **Turbo / Hotwire**, and **PostgreSQL**.

This project is intentionally designed as a **real, production-style Rails application**, not a tutorial demo. It emphasizes correctness, observability, clean architecture, multi-user data isolation, and real-time behavior without frontend complexity.

---

## Project Goals

- Build a real inventory system with correct CRUD behavior
- Use Turbo Frames and Turbo Streams properly
- Support both **HTML (web)** and **JSON (API)** consumers
- Enforce secure user authentication and ownership
- Track system mutations with an audit log
- Maintain a clean, scalable, production-ready codebase

---

## Features

### Inventory (Items)

- Full CRUD lifecycle
- Quantity tracking
- Category association
- Safe deletes
- Turbo Stream updates for create, update, and destroy
- Zero page reloads for item mutations
- Inventory fully scoped to the authenticated user

### Categories

- Full category CRUD
- Category management dashboard
- Category-scoped item views
- Proper ActiveRecord relationships

### Search, Filter, Sort

- Search items by name
- Filter items by category
- Sort by:
  - Name (ASC / DESC)
  - Quantity (ASC / DESC)

---

## Authentication & User Ownership

StockIO v2 supports **multi-user inventory isolation** with secure authentication for both the web application and the JSON API.

### Web Authentication (Sessions)

- Session-based authentication using `has_secure_password`
- Login and logout flows via a SessionsController
- Protected routes enforced with `require_login`
- Global `current_user` helper available across controllers and views
- Users can only access their own inventory records

### Item Ownership

- Each `Item` belongs to a `User`
- Inventory queries are scoped to `current_user`
- Users cannot view, edit, or delete items owned by other users
- Ownership is enforced at both controller and query level
- Existing records were safely backfilled during migration

### API Authentication (Token-Based)

- Stateless API authentication using a per-user `api_token`
- Each user is assigned a unique API token on creation
- API requests must include an Authorization header:


- API authentication is fully separated from web session authentication
- All API endpoints are protected and scoped to the authenticated user

This architecture mirrors real-world Rails applications that serve both browser-based users and external API consumers securely.

---

## CSV Import / Export

- Export inventory to CSV
- Import inventory from CSV
- CSV operations exposed via API
- CSV imports automatically associate records with the authenticated user
- CSV exports only return the current user’s inventory
- Turbo explicitly bypassed where full requests are required
- Production-safe parsing and updates

---

## API v1 (JSON)

RESTful JSON API under `/api/v1`.

### Items

- `GET /api/v1/items`
- `GET /api/v1/items/:id`
- `POST /api/v1/items`
- `PATCH /api/v1/items/:id`
- `DELETE /api/v1/items/:id`
- `GET /api/v1/items/export`
- `POST /api/v1/items/import`

All endpoints are authenticated, stateless, and scoped to the requesting user.

### Categories

- Full REST support
- Shared models and validations with the web layer

---

## Audit Logging (System Observability)

StockIO includes a dedicated **audit logging system** to track all system mutations.

### Tracked Events

- Item creation
- Item updates
- Item deletion
- API-initiated changes

### Stored Data

- Action type (`item_create`, `api_create`, `api_update`, etc.)
- Record type
- Record ID
- Change details stored as `jsonb`
- Timestamp

Audit logs are viewable through a dedicated **Activity Log UI**.

---

## Analytics Dashboard

- Total item count
- Total quantity in stock
- Most stocked item
- Lowest stock item

All metrics are computed directly from persisted inventory data and scoped to the authenticated user.

---

## UI / UX

- TailwindCSS
- Glassmorphism-style cards
- Responsive layouts
- Reusable partials and components
- Turbo Frames wrapping item cards
- Turbo Streams used for all mutations

The UI is intentionally minimal to keep focus on data and behavior.

---

## Architecture

### Stack

- Ruby on Rails 8
- PostgreSQL
- Turbo / Hotwire
- TailwindCSS

### Controllers

- Web controllers for HTML flows
- API controllers under `Api::V1`
- Thin controllers with logic pushed to models
- Authentication enforced at controller boundaries

### Models

- `User`
- `Item`
- `Category`
- `AuditLog`

### Database

- PostgreSQL
- `jsonb` columns for audit details
- Strong foreign key relationships
- Ownership enforced at the schema and application level

---

## Setup Instructions

### Requirements

- Ruby (see `.ruby-version`)
- PostgreSQL
- Bundler

### Installation

```bash
git clone https://github.com/ZsmithWork777/stockio_rails.git
cd stockio_rails
bundle install

### Database Setup
rails db:create
rails db:migrate

Run the Application
rails


What’s Next
 •	Role-based permissions (admin vs standard user)
	•	AI-assisted inventory insights and recommendations
	•	Deeper analytics and forecasting
	•	Background jobs for imports and audits
	•	Production deployment

---
That’s **complete**, **accurate**, and **reflects exactly what you built**.
No fragmentation. No missing context. No exaggeration.

If you want to move forward, say **one word**:
- `roles`
- `tests`
- `deploy`
- `pause`

I’ll stay locked in execution mode.
