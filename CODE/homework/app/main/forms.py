#!/usr/bin/env python
# coding=utf-8
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, BooleanField, SelectField,\
    SubmitField,FileField,PasswordField
from wtforms.validators import Required, Length, Email, Regexp,EqualTo
from wtforms import ValidationError
from ..models import Person,Notice

class EditProfileForm(FlaskForm):
    name = StringField('姓名',validators=[Length(0,64)])
    tel = StringField('联系方式',validators=[Length(0,64)])
    gender = SelectField('性别',choices=[('man','男'),('woman','女')],default = 'woman')
    introduction = TextAreaField('介绍')
    submit = SubmitField('提交')

class EditProfileForm_admin(FlaskForm):
    name = StringField('姓名',validators=[Length(0,64)])
    tel = StringField('联系方式',validators=[Length(0,64)])
    gender = SelectField('性别',choices=[('man','男'),('woman','女')],default = 'woman')
    introduction = TextAreaField('介绍')
    authorization = SelectField('权限',choices=[('labuser','实验室用户'),('registeruser','注册用户')],default='registeruser')
    submit = SubmitField('提交')

class EditProfileForm_su(FlaskForm):
    name = StringField('姓名',validators=[Length(0,64)])
    tel = StringField('联系方式',validators=[Length(0,64)])
    gender = SelectField('性别',choices=[('man','男'),('woman','女')],default = 'woman')
    introduction = TextAreaField('介绍')
    authorization = SelectField('权限',choices=[('generalad','普通管理员'),('labuser','实验室用户'),('registeruser','注册用户')],default='registeruser')
    submit = SubmitField('提交')

class ModifyPassword(FlaskForm):
    password = PasswordField('旧密码',validators=[Required()])
    new_password = PasswordField('新密码',validators=[Required(),EqualTo('password2',message='密码不匹配')])
    password2 = PasswordField('确认新密码',validators=[Required()])
    submit = SubmitField('提交')


class AddUser(FlaskForm):
    email = StringField('邮箱',validators=[Required(),Length(1,64) ,Email()])
    username = StringField('用户名',validators=[Required(),Length(1,64),Regexp('^[A-Za-z][A-Za-z0-9_.]*$',0,'Usernames must have only letters,numbers,dots or underscores')])
    password = PasswordField('密码',validators=[Required()],default='88888888')
    authorization = SelectField('权限',choices=[('generalad','普通管理员'),('labuser','实验室用户'),('registeruser','注册用户')],default='registeruser')
    submit = SubmitField('提交')

    def validate_email(self,field):
        if Person.query.filter_by(email=field.data).first():
            raise ValidationError('Email already registered.')

    def validate_username(self,field):
        if Person.query.filter_by(username=field.data).first():
            raise ValidationError('用户名已存在')
