from flask import Blueprint

# auth = Blueprint('auth', __name__, url_prefix='/auth')
auth = Blueprint('auth', __name__)

from . import views, errors
