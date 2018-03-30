import os
from carrier.models import User,Check_work
from carrier import db, create_app
from flask_script import Manager, Shell
from flask_migrate import Migrate, MigrateCommand

# app = create_app(os.getenv('FLASK_CONFIG') or 'kai')
app = create_app(os.getenv('FLASK_CONFIG') or 'dev')

manager = Manager(app)
migrate = Migrate(app, db)

def make_shell_context():
    return dict(app=app,db=db, User=User, Check_work=Check_work)

manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)

@manager.command
def test1():
    print 'runserver success!!!'
    app.run()


if __name__ == '__main__':
    manager.run()
    # runserver -h120.27.110.143 -p3000
    # runserver -h127.0.0.1 -p3100
