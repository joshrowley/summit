# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Summit is a Rails 8 application for personal wellness tracking using modern web technologies. It's built with an AI-first development approach, emphasizing rapid iteration and AI-driven workflows.

## Development Commands

### Setup and Installation
```bash
# Initial setup
bundle install && pnpm install
rails db:create db:migrate

# Start development server (uses Procfile.dev)
bin/dev

# Alternative development commands
rails server  # Rails server only
pnpm build --watch  # JavaScript compilation
pnpm build:css --watch  # CSS compilation
```

### Testing
```bash
# Run all tests
rails test

# Run system tests
rails test:system

# Run specific test file
rails test test/models/user_test.rb
```

### Asset Compilation
```bash
# Build JavaScript (esbuild)
pnpm build

# Build CSS (Tailwind)
pnpm build:css
```

### Code Quality
```bash
# Run linter
bin/rubocop

# Security analysis
bin/brakeman
```

## Architecture

### Tech Stack
- **Backend**: Rails 8.0.2, Ruby 3.4.4
- **Database**: PostgreSQL with solid_* gems (solid_cache, solid_queue, solid_cable)
- **Frontend**: Tailwind CSS 4.1.4, esbuild for JavaScript bundling
- **Authentication**: Devise with email restrictions
- **Testing**: Rails system tests with Capybara/Selenium

### Key Components

**Authentication System**
- Uses Devise for user management
- Email registration restricted via `AUTHORIZED_EMAIL` environment variable
- User model validates against authorized email in `app/models/user.rb:11-17`

**Asset Pipeline**
- Modern asset pipeline with Propshaft
- JavaScript bundled with esbuild (config in `package.json:5`)
- CSS compiled with Tailwind CLI (config in `package.json:6`)
- Assets built to `app/assets/builds/`

**Application Structure**
- Minimal Rails app with single `PagesController` for home page
- Modern browser requirement enforced in `ApplicationController`
- Routes configured for Devise + root path to `pages#home`

### Environment Requirements
- Set `AUTHORIZED_EMAIL` environment variable for user registration
- Node.js 24.3.0 with pnpm 9.7.0+ for asset compilation
- PostgreSQL for database

### Development Workflow
The project follows an AI-driven development approach where issues, PRs, and code changes are primarily managed through AI tools like Cursor AI, focusing on rapid prototyping and continuous iteration.