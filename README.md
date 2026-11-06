# `rust-core-tbsvttr` — Shared Zero-Dependency Rust Foundation

Shared zero-dependency Rust (`std`-only, `[dependencies]` empty, Rust `1.94.0`) foundation powering all three `rust-iouring-tbsvttr` benchmark submissions by `@tbsvttr` on [benchmarks.arjaythedev.com](https://benchmarks.arjaythedev.com/):

1. **Challenge 1 — The \$12 Server Challenge** ([PR #325](https://github.com/arjaythedev/twelve-dollar-server-challenge/pull/325))
2. **Challenge 2 — The Million Users Challenge** ([PR #89](https://github.com/arjaythedev/million-users-challenge/pull/89))
3. **Challenge 3 — The Multicore Server Challenge** ([PR #219](https://github.com/arjaythedev/multicore-server-challenge/pull/219))

## Core Modules (`src/`)

- [`src/reactor.rs`](src/reactor.rs) — Multi-reactor I/O runtime using `SO_REUSEPORT` TCP listeners, Linux `io_uring` (`SYS_IO_URING_SETUP` + multishot `IORING_OP_POLL_ADD` + `SYS_IO_URING_ENTER`) with non-blocking `epoll_wait` event harvesting, zero-allocation HTTP/1.1 request parser, and `writev` scatter-gather response transmission.
- [`src/router.rs`](src/router.rs) — Fast byte-level route classifier for all 19 RealWorld API endpoints (`/api/users`, `/api/user`, `/api/profiles/:username`, `/api/articles`, `/api/articles/feed`, `/api/articles/:slug/comments`, `/api/tags`, `/health`).
- [`src/auth.rs`](src/auth.rs) — Pure-Rust SHA-256 with hardware `x86_64` SHA-NI (`sha256rnds2`, `sha256msg1`, `sha256msg2`) acceleration and scalar fallback, precomputed `HMAC-SHA256` midstates (`Sha256Precomputed`), HS256 JWT generation/verification, and 6-lane SIMD (`u32x8` AVX2) interleaved Eksblowfish (`bcrypt_hash_many`, `bcrypt_verify_many`) with priority-split background workers (`nice 5` watchdog worker + `nice 15` throughput workers).
- [`src/codec.rs`](src/codec.rs) — Strict RFC 8259 JSON parser/validator, zero-allocation byte formatters (`write_i64`, `write_json_escaped`, `format_pg_timestamptz`), and slug generation.
- [`src/wire.rs`](src/wire.rs) — Direct PostgreSQL v3 binary wire protocol client (`PgConn`) supporting `AuthenticationOk`, `AuthenticationCleartextPassword`, and `AuthenticationSASL` (`SCRAM-SHA-256`), pipelined `Parse`/`Bind`/`Execute`/`Sync` batching, and zero-copy binary row decoding.
- [`src/gzip.rs`](src/gzip.rs) — Zero-allocation epoch-based fixed-Huffman + greedy LZ77 RFC 1952 Gzip compressor with O(1) static bit-packing lookup tables and 8-way slice-by-8 CRC32 (Challenge 2).
- [`src/queries.rs`](src/queries.rs) & [`src/engine.rs`](src/engine.rs) — Multi-worker two-phase pipelined read & write engine (`ReadWorker` / `WriteWorker`), deduplicated author-centric feed execution (`feed` + L1-cache merge), and two-phase enrichment (`enrich`) into a shared pre-rendered arena cache (`RenderCache`).
