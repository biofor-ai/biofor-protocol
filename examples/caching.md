# Caching

Machine-readable identity endpoints use HTTP caching to enable efficient, deterministic ingestion by AI agents.

## Why Cacheability Matters

AI agents need to:
- **Revalidate efficiently**: Check for updates without transferring full responses
- **Ingest deterministically**: Know when data has changed
- **Reduce crawl cost**: Minimize bandwidth and server load

Without proper caching, agents must fetch complete responses on every check, increasing latency and resource usage.

## Cache-Control

The `Cache-Control` header specifies caching directives.

Example:
```
Cache-Control: public, max-age=300
```

- `public`: Response can be cached by any cache
- `max-age=300`: Fresh for 300 seconds

## ETag

The `ETag` header provides a stable identifier for a specific version of a resource.

Example:
```
ETag: "abc123def456"
```

ETags enable conditional requests. If the resource hasn't changed, the server can return `304 Not Modified` instead of the full response.

## Conditional Requests

Clients can use `If-None-Match` to check if a cached version is still valid:

```
GET /llm/alex-example HTTP/1.1
If-None-Match: "abc123def456"
```

If the ETag matches the current resource version, the server responds:

```
HTTP/1.1 304 Not Modified
ETag: "abc123def456"
```

No response body is sent, reducing bandwidth.

## Revalidation Pattern

1. Client requests resource → receives `200 OK` with `ETag`
2. Client caches response with `ETag`
3. On next request, client sends `If-None-Match` with cached `ETag`
4. If unchanged → `304 Not Modified` (no body)
5. If changed → `200 OK` with new `ETag` and updated content

This pattern enables efficient polling: agents can check for updates frequently without high bandwidth cost.
