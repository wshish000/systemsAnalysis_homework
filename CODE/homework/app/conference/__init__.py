#!/usr/bin/env python
# coding=utf-8
from flask import Blueprint

conference = Blueprint('conference', __name__)

from . import views

