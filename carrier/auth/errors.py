# -*- coding:utf-8 -*-
import traceback

import sqlalchemy.exc

from carrier import constant as cs
from carrier.info import logger
from carrier.service.public_service import resq_wrapper as rw
from . import auth
from .. import db


@auth.errorhandler(sqlalchemy.exc.DBAPIError)
def db_exception(e):
        logger.error('Db Exception: %s', (e))
        logger.error("meet fails when the execution of a database operation")
        db.session.rollback()
        return rw(cs.DB_ERROR), 500


@auth.errorhandler(Exception)
def unhandled_exception(e):
        logger.error('Unhandled Exception: %s', (e))
        logger.error(traceback.format_exc())
        return rw(cs.SERVER_ERR), 500