#!/usr/bin/env python
# coding=utf-8
from flask import Blueprint

team = Blueprint('team', __name__)

from . import views

