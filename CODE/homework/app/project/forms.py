#coding=utf-8
from flask_wtf import FlaskForm
from wtforms import TextAreaField,SubmitField
from wtforms.validators import Required
from wtforms import ValidationError
from ..models import Project

class UpdateProjectForm(FlaskForm):
    introduction = TextAreaField('课题介绍')
    progress = TextAreaField('课题进展')
    submit = SubmitField('提交')
