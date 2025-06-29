FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install getmail6 and OAuth2 libraries
RUN pip install --no-cache-dir getmail6 google-auth-oauthlib msal

# Default locations (can be overridden by environment variables)
ENV GETMAIL_CONFIG=/etc/getmail/getmailrc \
    OAUTH2_CLIENT_ID="" \
    OAUTH2_CLIENT_SECRET="" \
    OAUTH2_REFRESH_TOKEN=""

# Volumes for configuration and mail storage
VOLUME ["/etc/getmail", "/mail"]

WORKDIR /mail

ENTRYPOINT ["getmail"]
CMD ["--help"]
