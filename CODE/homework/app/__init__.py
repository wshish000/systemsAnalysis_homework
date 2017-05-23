import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from flask_moment import Moment
from config import config
from flask_login import LoginManager

moment = Moment()
bootstrap = Bootstrap()
db = SQLAlchemy()

login_manager = LoginManager()
login_manager.session_protection = 'strong'
login_manager.login_view = 'auth.login'

def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    config[config_name].init_app(app)

    bootstrap.init_app(app)
    db.init_app(app)
    moment.init_app(app)
    login_manager.init_app(app)

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    from .project import project as project_blueprint
    app.register_blueprint(project_blueprint)

    from .team import team as team_blueprint
    app.register_blueprint(team_blueprint)

    from .notice import notice as notice_blueprint
    app.register_blueprint(notice_blueprint)

    from .article import article as article_blueprint
    app.register_blueprint(article_blueprint)

    from .news import news as news_blueprint
    app.register_blueprint(news_blueprint)

    from .conference import conference as conference_blueprint
    app.register_blueprint(conference_blueprint)


    return app
