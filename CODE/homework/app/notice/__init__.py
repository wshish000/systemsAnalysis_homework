#!/usr/bin/env python
# coding=utf-8
from flask import Blueprint

notice = Blueprint('notice', __name__)

from . import views

