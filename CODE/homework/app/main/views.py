#!/usr/bin/env python
# -*-coding: utf-8 -*-
import os
from flask import render_template,redirect,url_for,abort,flash,request,send_from_directory,current_app
from werkzeug.utils import secure_filename
from flask_login import login_required,current_user
from . import main
from .. import db
from ..models import Person,Notice,Article,Team,Project,News
from .forms import EditProfileForm,ModifyPassword,AddUser,EditProfileForm_su,EditProfileForm_admin
from ..decorators import permission_required


dir = os.path.abspath(os.path.dirname(__file__))
basedir = dir.split('/main')[0]
UPLOAD_FOLDER = basedir+'/static/uploads/'

@main.route('/', methods=['GET', 'POST'])
def index():
    #print UPLOAD_FOLDER
    #print current_app.config['UPLOAD_FOLDER']
    #print current_app.config['PER_PAGE']
    news = News.query.order_by(News.time.desc()).all()[:3]
    notice = Notice.query.order_by(Notice.time.desc()).all()[:3]
    return render_template('index.html',notice=notice,news=news)

@main.route('/user%<username>')
def user(username):
    user = Person.query.filter_by(username=username).first()
    if user is None:
        abort(404)
    articles = user.articles.order_by(Article.uploadtime.desc()).all()
    return render_template('user.html',user=user,articles=articles)

@main.route('/edit-profile',methods=['GET','POST'])
@login_required
def edit_profile():
    form = EditProfileForm()
    if form.validate_on_submit():
        current_user.name = form.name.data
        current_user.tel = form.tel.data
        current_user.gender = form.gender.data
        current_user.introduction = form.introduction.data
        db.session.add(current_user)
        db.session.commit()
        flash('个人信息已经更新')
        return redirect(url_for('.index'))
    form.name.date = current_user.name
    form.tel.data = current_user.tel
    form.gender.data = current_user.gender
    return render_template('edit_profile.html',form=form,change=current_user)
@main.route('/edit-profile%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def edit_profile_1(id):
    change = Person.query.get_or_404(id)
    if current_user.authorization == 'superad':
        form = EditProfileForm_su()
    else:
        form = EditProfileForm_admin()
    if form.validate_on_submit():
        change.name = form.name.data
        change.tel = form.tel.data
        change.gender = form.gender.data
        change.introduction = form.introduction.data
        change.authorization = form.authorization.data
        db.session.add(change)
        db.session.commit()
        flash('信息更新成功')
        return redirect(url_for('.show_user'))
    form.name.data = change.name
    form.tel.data = change.tel
    form.gender.data = change.gender
    form.introduction.data = change.introduction
    return render_template('edit_profile.html',form=form,change=change)

@main.route('/show-user',methods=['GET','POST'])
@login_required
def show_user():
    generalad = Person.query.filter_by(authorization='generalad').all()
    registeruser = Person.query.filter_by(authorization='registeruser').all()
    labuser = Person.query.filter_by(authorization='labuser').all()
    if current_user.authorization == 'superad':
        return render_template('show_user.html',registeruser=registeruser,labuser=labuser,generalad=generalad)
    elif current_user.authorization == 'generalad':
        return render_template('show_user.html',registeruser=registeruser,labuser=labuser)



@main.route('/delete%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete(id):
    change = Person.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('成功删除')
    return redirect(url_for('.show_user'))

@main.route('/agree%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def agree(id):
    change = Person.query.get_or_404(id)
    change.target = ''
    change.authorization = 'labuser'
    db.session.add(change)
    db.session.commit()
    return redirect(url_for('.show_user'))

@main.route('/refuse%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def refuse(id):
    change = Person.query.get_or_404(id)
    change.target = ''
    db.session.add(change)
    db.session.commit()
    return redirect(url_for('.show_user'))

@main.route('/modify-password',methods=['GET','POST'])
@login_required
def modify_password():
    form = ModifyPassword()
    if form.validate_on_submit():
        if current_user.verify_password(form.password.data):
            current_user.password = form.new_password.data
            db.session.add(current_user)
            db.session.commit()
            flash('密码修改成功')
            return redirect(url_for('main.index'))
        else:
            flash('密码错误')
            return redirect(url_for('main.modify_password'))
    return render_template('modify_password.html',form=form)
@main.route('/upgrade',methods=['GET','POST'])
@login_required
def upgrade():
    current_user.target = '1'
    db.session.add(current_user)
    db.session.commit()
    flash('申请提交成功')
    return redirect(url_for('main.index'))


@main.route('/add-user',methods=['GET','POST'])
@login_required
@permission_required(['superad'])
def add_user():
    form = AddUser()
    if form.validate_on_submit():
        user=Person(email=form.email.data,username=form.username.data,authorization=form.authorization.data,password=form.password.data)
        db.session.add(user)
        db.session.commit()
        flash('添加用户成功')
        return redirect(url_for('main.index'))
    return render_template('add_user.html',form=form)
