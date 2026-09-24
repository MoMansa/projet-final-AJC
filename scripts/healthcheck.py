#!/usr/bin/env python3
"""Controle de sante de l'API capteurs FoodTrack.

Usage :
    python3 healthcheck.py <url>
    FOODTRACK_API_URL=http://... python3 healthcheck.py

Code de sortie : 0 si code HTTP 200, 1 sinon.
"""
import os
import sys
import time
import urllib.error
import urllib.request


def main():
    url = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("FOODTRACK_API_URL")
    if not url:
        print("Usage: healthcheck.py <url>")
        return 1

    debut = time.time()
    try:
        with urllib.request.urlopen(url, timeout=5) as reponse:
            code = reponse.status
    except urllib.error.HTTPError as exc:
        code = exc.code
    except Exception as exc:
        print(f"INJOIGNABLE — {url} — {exc}")
        return 1

    latence_ms = round((time.time() - debut) * 1000, 1)
    ok = code == 200
    print(f"{'OK' if ok else 'ECHEC'} — {url} — code {code} — {latence_ms} ms")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
