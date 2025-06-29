# getmail6 container

This repository provides a minimal Docker image for [getmail6](https://github.com/getmail6/getmail6) so that emails from external providers can be aggregated and stored locally. The image is intended to be used in a Kubernetes environment managed by ArgoCD and the Stalwart mail server.

## Features

- Based on `python:3.11-slim` for a small footprint.
- Installs `getmail6` and OAuth2 dependencies (`google-auth-oauthlib`, `msal`).
- Designed for configuration via environment variables so secrets can be managed with Kubernetes ConfigMaps and Secrets.
- GitHub Actions workflow builds and publishes the image to GitHub Container Registry.

## Usage

Mount your `getmailrc` configuration file and a directory to store retrieved mail:

```bash
docker run \
  -v /path/to/getmailrc:/etc/getmail/getmailrc:ro \
  -v /path/to/mail:/mail \
  -e OAUTH2_CLIENT_ID=your-client-id \
  -e OAUTH2_CLIENT_SECRET=your-client-secret \
  -e OAUTH2_REFRESH_TOKEN=your-refresh-token \
  ghcr.io/your-user/your-repo:latest
```

`getmail` will run with the provided configuration and store mail under `/mail`.

## GitHub Actions

The included workflow (`.github/workflows/docker-image.yml`) automatically builds the Docker image and pushes it to GitHub Container Registry when changes are pushed to the `main` branch.

## Next Steps

- Configure OAuth2 credentials for Gmail or Outlook and supply them via environment variables or Kubernetes secrets.
- Set up scheduled execution (e.g., using CronJob in Kubernetes) to run `getmail` periodically.
- Integrate the container with your Stalwart mail server for local delivery.
