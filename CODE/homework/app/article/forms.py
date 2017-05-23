#!/usr/bin/env python
# coding=utf-8
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, BooleanField, SelectField,\
    SubmitField,FileField
from wtforms.validators import Required, Length, Email, Regexp
from wtforms import ValidationError
from ..models import Person,Notice,Project,Article

class UploadArticle(FlaskForm):
    brief = TextAreaField('摘要')
    about = StringField('关于',validators=[Length(0,64)])
    article = FileField('文件')
    link = StringField('外网链接',validators=[Length(0,64)])
    submit = SubmitField('提交')

    def validate_about(self,field):
        if not Project.query.filter_by(name=field.data).first():
            raise ValidationError('没有此项目')

