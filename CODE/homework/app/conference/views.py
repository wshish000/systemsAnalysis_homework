#!/usr/bin/env python
# -*-coding: utf-8 -*-
from flask import render_template,redirect,url_for,abort,flash,request
from flask_login import login_required
from .import conference
from .. import db
from ..models import Conference
from ..decorators import permission_required


@conference.route('/add-conference',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def add_conference():
    conference = Conference()
    if request.method == 'POST':
        conference.name = request.values.get("name")
        conference.spot = request.values.get("spot")
        conference.starttime = request.values.get("starttime")
        conference.endtime = request.values.get("endtime")
        conference.link = request.values.get("link")
        db.session.add(conference)
        db.session.commit()
        flash("成功添加会议")
        return redirect(url_for('main.index'))
    return render_template('add_conference.html')

@conference.route('/delete-conference%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_conference(id):
    change = Conference.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('删除成功')
    return redirect(url_for('.manage_conference'))

@conference.route('/show-conference',methods=['GET','POST'])
def show_conference():
    conference = Conference.query.order_by(Conference.starttime.desc()).all()
    return render_template('show_conference.html',conference=conference)
@conference.route('/manage_conference',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def manage_conference():
    conference = Conference.query.order_by(Conference.starttime.desc()).all()
    return render_template('manage_conference.html',conference=conference)
@conference.route('/conference%<int:id>',methods=['GET','POST'])
def conference(id):
    change = Conference.query.get_or_404(id)
    return render_template('conference.html',change=change)
