StockIO v2
Production-Style Inventory Management System
Rails 8 · Turbo / Hotwire · PostgreSQL · JSON API

StockIO v2 is a full-stack inventory management application rebuilt from the ground up using Ruby on Rails 8, Turbo / Hotwire, and PostgreSQL.

This project is intentionally designed as a real, production-style Rails application, not a tutorial demo.
It emphasizes correctness, observability, clean architecture, and real-time behavior without frontend complexity.

Project Goals
Build a real inventory system with correct CRUD behavior
Use Turbo Frames and Turbo Streams properly
Support both HTML (web) and JSON (API) consumers
Track system mutations with an audit log
Maintain a clean, scalable, production-ready codebase
Features
Inventory (Items)
Full CRUD lifecycle
Quantity tracking
Category association
Safe deletes
Turbo Stream updates for create, update, and destroy
Zero page reloads for item mutations
Categories
Full category CRUD
Category management dashboard
Category-scoped item views
Proper ActiveRecord relationships
Search, Filter, Sort
Search items by name
Filter items by category
Sort by:
Name (ASC / DESC)
Quantity (ASC / DESC)
CSV Import / Export
Export inventory to CSV
Import inventory from CSV
CSV operations exposed via API
Turbo explicitly bypassed where full requests are required
Production-safe parsing and updates
API v1 (JSON)
RESTful JSON API under /api/v1

Items
GET /api/v1/items
GET /api/v1/items/:id
POST /api/v1/items
PATCH /api/v1/items/:id
DELETE /api/v1/items/:id
GET /api/v1/items/export
POST /api/v1/items/import
Categories
Full REST support
The API shares models and business logic with the web layer while remaining stateless and JSON-only.

Audit Logging (System Observability)
StockIO includes a dedicated audit logging system to track all system mutations.

Tracked Events
Item creation
Item updates
Item deletion
API-initiated changes
Stored Data
Action type (item_create, api_create, api_update, etc.)
Record type
Record ID
Change details stored as jsonb
Timestamp
Audit logs are viewable through a dedicated Activity Log UI.

Analytics Dashboard
Total item count
Total quantity in stock
Most stocked item
Lowest stock item
All metrics are computed directly from persisted inventory data.

UI / UX
TailwindCSS
Glassmorphism-style cards
Responsive layouts
Reusable partials and components
Turbo Frames wrapping item cards
Turbo Streams used for all mutations
The UI is intentionally minimal to keep focus on data and behavior.

Architecture
Stack
Ruby on Rails 8
PostgreSQL
Turbo / Hotwire
TailwindCSS
Controllers
Web controllers for HTML flows
API controllers under Api::V1
Thin controllers with logic pushed to models
Models
Item
Category
AuditLog
Database
PostgreSQL
jsonb columns for audit details
Strong parameters enforced across controllers
Setup Instructions
Requirements
Ruby (see .ruby-version)
PostgreSQL
Bundler
Installation
git clone https://github.com/ZsmithWork777/stockio_rails.git
cd stockio_rails
bundle install

Database Setup

rails db:create
rails db:migrate

Run the Application

Visit:
http://localhost:3000


What’s Next
	•	Authentication and role-based permissions
	•	AI-assisted inventory insights and recommendations
	•	Deeper analytics and forecasting
	•	Background jobs for imports and audits
	•	Production deployment


Author

Built by Zachary Smith

Focused on backend engineering, Rails architecture, and production-ready systems.
