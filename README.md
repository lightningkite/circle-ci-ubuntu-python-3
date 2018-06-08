# CircleCI Build Image

An Ubuntu 18.04 based Docker image that [meets the requirements](https://circleci.com/docs/2.0/custom-images/#required-tools) of a CircleCI 2.0 primary image. This image is centered around Python 3 and was created as a standin for an Ubuntu based image in a compose setup. The image also contains Node 8 for building static files, though this image could be used for just Node.

# Usage

List this image as the primary in `.circleci/config.yml`.

The following example derives from a `docker-compose.yml` file.

```yaml
version: 2
jobs:
  build:
    docker:
      - image: 722c/circle-ci-ubuntu-python3
        environment:
          - DATABASE_URL=postgres://django:django@db/django
      - image: postgres
        name: db  # Map to the name of the container in docker-compose.yml
        environment:
          - POSTGRES_USER=django
          - POSTGRES_PASSWORD=django

    working_directory: /app

    steps:
      - checkout

      - run:
          name: Install Python dependencies
          command: pip3 install -r requirements.txt

      - run:
          name: Install Node dependencies
          command: npm install

      - run:
          name: Build static files
          command: npm run build

      - run:
          name: Run tests
          command: pytest
```
