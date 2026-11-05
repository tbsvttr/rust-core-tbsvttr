# `rust-core-tbsvttr` — Shared Zero-Dependency Rust Foundation

Shared zero-dependency Rust (`std`-only, `[dependencies]` empty, Rust `1.94.0`) foundation powering all three `rust-iouring-tbsvttr` benchmark submissions by `@tbsvttr` on [benchmarks.arjaythedev.com](https://benchmarks.arjaythedev.com/):

1. **Challenge 1 — The \$12 Server Challenge** ([PR #313](https://github.com/arjaythedev/twelve-dollar-server-challenge/pull/313))
2. **Challenge 2 — The Million Users Challenge** ([PR #89](https://github.com/arjaythedev/million-users-challenge/pull/89))
3. **Challenge 3 — The Multicore Server Challenge** ([PR #214](https://github.com/arjaythedev/multicore-server-challenge/pull/214) & [PR #218](https://github.com/arjaythedev/multicore-server-challenge/pull/218))

## Core Modules (`src/`)

- [`src/sys.rs`](src/sys.rs) — Raw Linux `io_uring`, `epoll`, `SO_REUSEPORT`, `TCP_NODELAY`, `unshare(CLONE_FILES)`, and `SCHED_BATCH` (`sched_setscheduler`) FFI declarations without `libc`.
- [`src/buf.rs`](src/buf.rs) — Zero-allocation byte buffer, integer formatting, and Howard Hinnant civil-from-days UTC ISO-8601 timestamp formatting (`put_int`, `put_timestamp`, `put_json_string`).
- [`src/jwt.rs`](src/jwt.rs) — FIPS 180-4 SHA-256 with precomputed HMAC-SHA256 `ipad`/`opad` midstates, Base64URL codec, and zero-allocation HS256 JWT verifier/signer with mandatory `exp` validation.
- [`src/json.rs`](src/json.rs) — Single-pass JSON scanner, string unescaper/escaper, and UTF-8 codepoint validator.
- [`src/pg.rs`](src/pg.rs) — Direct PostgreSQL v3 binary wire-protocol client (`Parse`, `Bind`, `Execute`, `Sync`) and SCRAM-SHA-256 authentication state machine (Challenges 2 & 3).
- [`src/gzip.rs`](src/gzip.rs) — Zero-allocation epoch-based fixed-Huffman + greedy LZ77 RFC 1952 Gzip compressor with 8-way slice-by-8 CRC32 (Challenge 2).
- [`build.rs`](build.rs), [`src/blowfish.rs`](src/blowfish.rs) & [`src/bcrypt.rs`](src/bcrypt.rs) — 6-lane word-sliced OpenBSD `$2a$`/`$2b$` EksBlowfish bcrypt over 64-byte cache-line aligned 4,224-byte `BfLane` states (eliminating 4K L1D aliasing) with runtime auto-calibrated x86-64 BMI2 (`SHRX`, `BEXTR`, `AH`-register) assembly kernels (`bc_cost10_{ah,bextr,shrx}_{1..6}`) generated at build time (Challenge 3).
- [`src/server.rs`](src/server.rs) & [`src/main.rs`](src/main.rs) — Multi-worker `SO_REUSEPORT` HTTP/1.1 engine, cross-worker database batch coordinator (`DbEngine`) with parallel `Feed`/`Pages` lanes, `HashAggregate` `PAGES` CTEs, group-commit pipelined writes (`pg_queue_write_group`), `HttpPayload::Shared(Arc<[u8]>)` zero-copy within-batch response sharing, and tiered `BcryptPool`.
