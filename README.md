# nginx-https
Docker config for a nginx with https setup

## Installation

1. Edit `nginx/start.sh`
Replace `www.domain.com` with your own domain

2. Edit `nginx/sslIssuing.sh`
Replace `www.domain.com` and `domain.com` with your own domain

3. Add your website in `src/`

4. Rebuild your docker container with `./build.sh`

5. Run your docker `./start.sh`
