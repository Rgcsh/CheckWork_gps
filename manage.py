import os
from carrier.models import User
from carrier import db, create_app
from flask.ext.script import Manager, Shell
from flask.ext.migrate import Migrate, MigrateCommand
import datetime
app = create_app(os.getenv('FLASK_CONFIG') or 'kai')
# app = create_app(os.getenv('FLASK_CONFIG') or 'dev')

app.secret_key = os.urandom(24)
app.permanent_session_lifetime = datetime.timedelta(seconds=24*60*60)
manager = Manager(app)
migrate = Migrate(app, db)

def make_shell_context():
    return dict(app=app,User=User)

manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)

@manager.command
def test():
    pass

if __name__ == '__main__':
    manager.run()
#runserver -h120.27.110.143 -p3000