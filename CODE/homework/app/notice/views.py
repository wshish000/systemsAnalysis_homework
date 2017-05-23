#!/usr/bin/env python
# -*-coding: utf-8 -*-
from flask import render_template,redirect,url_for,abort,flash,request
from flask_login import login_required
from .import notice
from .. import db
from ..models import Notice
from .forms import EditNotice
from ..decorators import permission_required


@notice.route('/edit-notice',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def edit_notice():
    notice = Notice()
    form = EditNotice()
    if form.validate_on_submit():
        notice.title = form.title.data
        notice.content = form.content.data
        notice.ping()
        db.session.add(notice)
        db.session.commit()
        flash('A new notice  has been updated.')
        return redirect(url_for('main.index'))
    return render_template('edit_notice.html',form=form)

@notice.route('/delete-notice%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_notice(id):
    change = Notice.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('Delete successfully!')
    return redirect(url_for('.show_notice'))

@notice.route('/show-notice',methods=['GET','POST'])
def show_notice():
    notice = Notice.query.order_by(Notice.time.desc()).all()
    return render_template('show_notice.html',notice=notice)

@notice.route('/notice%<int:id>',methods=['GET','POST'])
def notice(id):
    change = Notice.query.get_or_404(id)
    return render_template('notice.html',change=change)
