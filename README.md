# Resque-Web and Resque-Scheduler-Web in Docker
Installs a rails based version of `resque-web` which is compatible with Resque 2.
This container is compatible with `resque-scheduler`.
The container is based on `ruby:2.3` and sinatra 2.

## DISCLAIMER
Uses Sinatra `2.0.0`.
Available versions of this container are quite big (to be solved in next versions).

## NOTICE
Note this is NOT the old sinatra interface that comes with Resque 1-x.
This is a new project based on rails.
Note that the sinatra web interface will be gone in Resque 2.0 and this is meant to be the replacement.

## About Resque
Resque (pronounced like "rescue") is a Redis-backed library for creating background jobs, placing those jobs on multiple queues, and processing them later.

## About Resque-Web
A Rails-based frontend to the [Resque](https://github.com/resque/resque) job queue system.
This provides a similar interface to the existing Sinatra application that comes bundled with Resque, but deploys like a Rails application and leverages Rails conventions for factoring things like controllers, helpers, and views.

## About Resque-Scheduler-Web
Provides tabs in Resque Web for managing Resque Scheduler.
It works with any version of Resque and Resque Scheduler.
This gem is a port of the old Sinatra code to the new Resque Web plugin architecture and has better test coverage and a number of bug fixes compared to the older Resque Scheduler Sinatra code which it is based on.

# Configuration

The container is configured to use a resque server on the host `redis`, port `6379`, database `0`.
If you need a non-default resque server, use this environment variable:
```
RAILS_RESQUE_REDIS=<host>:<port>:<database>
```

This container is configured to serve Resque-Web on the `/resque_web` path which allows simple reverse proxy configuration.