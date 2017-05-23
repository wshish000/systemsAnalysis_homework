#!/usr/bin/env python
# -*-coding: utf-8 -*-
from flask import render_template,redirect,url_for,abort,flash,request
from flask_login import login_required
from .import news
from .. import db
from ..models import News
from .forms import EditNews
from ..decorators import permission_required


@news.route('/edit-news',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def edit_news():
    news = News() 
    form = EditNews()
    if form.validate_on_submit():
        news.title =  form.title.data
        news.content = form.content.data
        news.ping()
        db.session.add(news)
        db.session.commit()
        flash('新闻已上传')
        return redirect(url_for('news.show_news'))
    return render_template('edit_news.html',form=form)

@news.route('/delete-news%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_news(id):
    change = News.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('删除成功')
    return redirect(url_for('.show_news'))

@news.route('/show-news',methods=['GET','POST'])
def show_news():
    news = News.query.order_by(News.time.desc()).all()
    return render_template('show_news.html',news=news)

@news.route('/news%<int:id>',methods=['GET','POST'])
def news(id):
    change = News.query.get_or_404(id)
    return render_template('news.html',change=change)
