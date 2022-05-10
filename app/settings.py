# -*- coding: utf-8 -*-
"""Application configuration.
Most configuration is set via environment variables.
For local development, use a .env file to set
environment variables.
"""
from environs import Env

env = Env()
env.read_env()
ENV = env.str("FLASK_ENV", default="production")
DEBUG = ENV == "development"
SQLALCHEMY_DATABASE_URI = env.str("DATABASE_URL")
SECRET_KEY = env.str("SECRET_KEY")
SQLALCHEMY_TRACK_MODIFICATIONS = False