from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.redis import FlaskRedis
from flask_debugtoolbar import DebugToolbarExtension
from config import config

db = SQLAlchemy()
redis_store = FlaskRedis()
toolbar = DebugToolbarExtension()

def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    config[config_name].init_app(app)

    db.init_app(app)
    redis_store.init_app(app)
    toolbar.init_app(app)

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)


    return app
