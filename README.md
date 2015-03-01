# BAM! (Benchmark Assessment Mondays) - CRUD with User Authentication

## Setup

Normal setup: Fork and clone this repository, `rake db:create`, etc.

## Steps

In this benchmark, there are 3 feature specs. The file names imply an enumeration that we suggest, but do not mandate, you follow. A reminder/hint that the spec files provide the *specifications of behavior* for the application, so they may be a good starting point.

Again the goal is to remain calm and work your way through errors as they arise. If you hit an absolute brick wall please take note of it and ask an instructor for assistance.

## (very) Quick overview

In this application users will be allow to log in or register from the homepage. An authenticated user can then see an index view for cheeses (which only have a `name` and `price_per_lb`), as well as links to the associated CRUD functionality for cheeses. Unauthenticated users are unable to see or operate on cheeses.

## Hints

A helpful command to know is that you can run an individual RSpec file as so:

```
rspec [relative/path/to/spec]
```

for example in this repository:

```
rspec spec/features/0_user_signup_spec.rb
```

It may be helpful to work through each of the specs in order, rather than trying to work through them all at once.
