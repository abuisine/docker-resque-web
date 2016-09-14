#!/bin/bash
set -e

rm /resque-scheduler-web/tmp/pids/server.pid || true

exec "$@"