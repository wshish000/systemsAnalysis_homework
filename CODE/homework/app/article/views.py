#!/usr/bin/env python
# -*-coding: utf-8 -*-
import os
from flask import render_template,redirect,url_for,abort,flash,request,send_from_directory,current_app
from werkzeug.utils import secure_filename
from flask_login import login_required,current_user
from . import article
from .. import db
from ..models import Article
from .forms import UploadArticle
from ..decorators import permission_required


dir = os.path.abspath(os.path.dirname(__file__))
basedir = dir.split('/article')[0]
UPLOAD_FOLDER = basedir+'/static/uploads/'

@article.route('/upload',methods=['GET','POST'])
@login_required
@permission_required(['labuser','generalad'])
def upload():
    form = UploadArticle()
    if form.validate_on_submit():
        filename = form.article.data.filename
        form.article.data.save(UPLOAD_FOLDER + filename)
        brief = form.brief.data
        about = form.about.data
        link = form.link.data
        if Article.query.filter_by(title=filename).first():
            flash('文件已存在，不需要重复上传')
            filename = None
            return render_template('upload.html',form=form,filename=filename)

        article = Article(title=filename,brief=brief,about=about,link=link,target='0',person=current_user._get_current_object())
        article.ping()
        db.session.add(article)
        db.session.commit()
        flash('上传成功')
    else:
        filename = None
    return render_template('upload.html',form=form,filename=filename)

@article.route('/verify%<int:id>',methods=['GET','POST'])
@permission_required(['generalad'])
@login_required
def verify(id):
    change = Article.query.get_or_404(id)
    change.target = '1'
    db.session.add(change)
    db.session.commit()
    return redirect(url_for('.articles')) 


@article.route('/article',methods=['GET','POST'])
@login_required
def articles():
        titles = Article.query.filter_by(target='0').order_by(Article.uploadtime.desc()).all()
        titles1 = Article.query.filter_by(target='1').order_by(Article.uploadtime.desc()).all()
        return render_template('article.html',titles = titles,titles1=titles1,path = UPLOAD_FOLDER)

@article.route('/download%<filename>',methods=['GET','POST'])
@login_required
def download(filename):
    if request.method=="GET":
        if os.path.isfile(os.path.join(UPLOAD_FOLDER,filename)):
            return send_from_directory(UPLOAD_FOLDER,filename,as_attachment=True)
        abort(404)

@article.route('/delete-article%<filename>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_article(filename):
    change = Article.query.filter_by(title=filename).first()
    change2 = UPLOAD_FOLDER + filename
    db.session.delete(change)
    db.session.commit()
    if os.path.exists(change2):
        os.remove(change2)
    flash('成功删除')
    titles = Article.query.order_by(Article.uploadtime.desc()).all()
    return render_template('article.html',titles = titles,path = UPLOAD_FOLDER) 
