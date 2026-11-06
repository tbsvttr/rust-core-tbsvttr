#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_BENCH="$(cd "$ROOT_DIR/.." && pwd)"

echo "==> Syncing shared modules between rust-core-tbsvttr and Challenge 3 (multicore-server-challenge)..."
cp "$WEB_BENCH/multicore-server-challenge/submissions/rust-iouring-tbsvttr"/src/{auth,codec,engine,main,queries,reactor,router,wire}.rs \
   "$ROOT_DIR/src/"

echo "==> Syncing gzip.rs from Challenge 2 (million-users-challenge)..."
cp "$WEB_BENCH/million-users-challenge/submissions/rust-iouring-tbsvttr/src/gzip.rs" \
   "$ROOT_DIR/src/gzip.rs"

echo "==> Running cargo test across all 4 projects..."
(cd "$ROOT_DIR" && cargo test)
(cd "$WEB_BENCH/twelve-dollar-server-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
(cd "$WEB_BENCH/million-users-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
(cd "$WEB_BENCH/multicore-server-challenge/submissions/rust-iouring-tbsvttr" && cargo test)
echo "==> All 4 zero-dependency test suites passed!"
