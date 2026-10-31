#!/usr/bin/env python3
"""Builds packages/dummyjson_api/spec/dummyjson.json from the live spec.

Patches, each because the published spec falls short of what the app calls:
  1. /auth/products and /auth/products/{id} are not documented upstream. The
     server mirrors the public product routes behind a bearer token, so they
     are derived from /products and /products/{id}. Only the auth-protected
     routes can answer 401, which is what makes the refresh flow real.
  2. /auth/me points at AuthUser. Upstream's User schema carries dozens of
     unused nested objects (bank, crypto, company) the app never reads.
  3. Both product routes get the bearer security requirement and a 401.
"""
import copy
import json
import sys
import urllib.request

SOURCE = "https://dummyjson.com/openapi.json"
OUT = sys.argv[1]

request = urllib.request.Request(SOURCE, headers={"User-Agent": "curl/8"})
spec = json.load(urllib.request.urlopen(request))
paths, schemas, params = spec["paths"], spec["components"]["schemas"], spec["components"]["parameters"]

KEEP_PARAMS = ["limit", "skip", "select", "id"]

def unauthorized():
    return {
        "description": "Missing, invalid or expired access token",
        "content": {"application/json": {"schema": {"$ref": "#/components/schemas/Error"}}},
    }

def protected(operation, operation_id):
    op = copy.deepcopy(operation)
    op["operationId"] = operation_id
    op["tags"] = ["Auth"]
    op["security"] = [{"bearerAuth": []}]
    op["parameters"] = [p for p in op["parameters"] if p["$ref"].rsplit("/", 1)[1] in KEEP_PARAMS]
    op["responses"]["401"] = unauthorized()
    return op

paths["/auth/products"] = {"get": protected(paths["/products"]["get"], "authGetProducts")}
paths["/auth/products/{id}"] = {"get": protected(paths["/products/{id}"]["get"], "authGetProductById")}

me = paths["/auth/me"]["get"]["responses"]["200"]["content"]["application/json"]["schema"]
me["$ref"] = "#/components/schemas/AuthUser"

keep_paths = ["/auth/login", "/auth/refresh", "/auth/me", "/auth/products", "/auth/products/{id}"]
keep_schemas = ["AuthUser", "LoginResponse", "Tokens", "Error", "Product", "ProductList"]

spec["paths"] = {p: paths[p] for p in keep_paths}
spec["components"] = {
    "parameters": {k: params[k] for k in KEEP_PARAMS},
    "schemas": {k: schemas[k] for k in keep_schemas},
    "securitySchemes": {"bearerAuth": spec["components"]["securitySchemes"]["bearerAuth"]},
}
spec["tags"] = [t for t in spec.get("tags", []) if t["name"] == "Auth"] or [{"name": "Auth"}]

with open(OUT, "w") as f:
    json.dump(spec, f, indent=2)
    f.write("\n")
