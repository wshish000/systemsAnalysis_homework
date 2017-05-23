#!/usr/bin/env python
# coding=utf-8
from flask import render_template,redirect,request,url_for,flash
from flask_login import login_user,logout_user,login_required,current_user
from . import auth
from .. import db
from ..models import Person
from .forms import LoginForm,RegistrationForm

#@auth.before_app_request
#def before_request():
#    if current_user.is_authenticated():
#        current_user.ping()

@auth.route('/login',methods=['GET','POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = Person.query.filter_by(email=form.email.data).first()
        if user is not None and user.verify_password(form.password.data):
            login_user(user,form.remember_me.data)
            print current_user.email,current_user.authorization
            return redirect(request.args.get(next) or url_for('main.index'))
        flash('用户名或密码错误')
    return render_template('login.html',form=form)

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    flash('您已成功登出')
    return redirect(url_for('main.index'))

@auth.route('/register',methods=['GET','POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        user=Person(email=form.email.data,username=form.username.data,authorization='registeruser',password=form.password.data)
        db.session.add(user)
        db.session.commit()
        flash('您已注册成功，可以登录')
        return redirect(url_for('auth.login'))
    return render_template('register.html',form=form)
