This is a 3 musketeers based starter repo.

I found I was always trying to write the same functionality from scratch or copy/paste files from my other repos. I want to reduce the time I spend setting up new projects.

You can use these files as a starting point for your next project.

# Demo

![demo](demo-large.gif)

# Features

## Setup script

Setup script runs automatically if `~/configs.env` doesn't exist.

It helps you create `~/configs.env` interactivity. It has `VAR_1`,`VAR_2`,`VAR_3` as example environment vars which you can leave as-is to being with and update them as you need to inject environemnet vars into your containers.

It helps you check and configure an AWS CLI profile.

## Makefile

The Makefile is our interface to all other things.

It displays the list of things we can run.

Make targets are group and colored to make it easy to understand what commands can and should be run.

Targets:
- Shell into a development container for any adhoc commands
- Rebuild all images used by compose
- Configure AWS Profile
- Clean project files
- Check for built dependencies in a certain folder, so they're not rebuilt each time
- Run application locally, exposing nessasary ports

## Compose file

This contains the logic for all the containers we need. Includes the container to shell into, local app, and configuring AWS.

## Dockerfile

This is a quick example file that has python, pip and aws-cli. This should be changed for whatever your proejct needs.

## .gitignore

Ignore the config file so it's never checked in

# Next steps

I'd like to allow for some variations (ie removing AWS if it's not required) so I may go down the path of a yeoman generator.

As I set this up quickly I don't have any testing, and my example files don't produce a functional app, I'd like to have a very basic but functional python app, and possibly some other common examples to get even closer to a valid starting point for new projects.


