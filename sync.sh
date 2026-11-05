#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_BENCH="$(cd "$ROOT_DIR/.." && pwd)"

echo "==> Syncing shared modules from rust-core-tbsvttr to Challenge 3 (multicore-server-challenge)..."
cp "$ROOT_DIR"/src/{bcrypt,blowfish,buf,json,jwt,main,pg,server,sys}.rs \
   "$WEB_BENCH/multicore-server-challenge/submissions/rust-iouring-tbsvttr/src/"

echo "==> Syncing gzip.rs from Challenge 2 (million-users-challenge)..."
cp "$WEB_BENCH/million-users-challenge/submissions/rust-iouring-tbsvttr/src/gzip.rs" \
   "$ROOT_DIR/src/gzip.rs"

echo "==> Running cargo test across all 4 projects..."
(cd "$ROOT_DIR" && cargo test)
(cd "$WEB_BENCH/twelve-dollar-server-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
(cd "$WEB_BENCH/million-users-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
(cd "$WEB_BENCH/multicore-server-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
echo "==> All 4 zero-dependency test suites passed!"

