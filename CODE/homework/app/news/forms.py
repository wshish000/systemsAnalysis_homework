#!/usr/bin/env python
# coding=utf-8
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, BooleanField, SelectField,\
    SubmitField,FileField
from wtforms.validators import Required, Length, Email, Regexp
from wtforms import ValidationError
from ..models import Person,Notice,News


class EditNews(FlaskForm):
    title = StringField('标题',validators=[Length(0,64)])
    content = TextAreaField('内容')
    submit = SubmitField('提交')


