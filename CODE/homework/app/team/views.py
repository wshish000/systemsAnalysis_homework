#!/usr/bin/env python
# -*-coding: utf-8 -*-
from flask import render_template,redirect,url_for,abort,flash,request
from flask_login import login_required
from .import team
from .. import db
from ..models import Team,Person
from ..decorators import permission_required

@team.route('/add-team',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def add_team():
    team = Team()
    #form = AddTeam()
    member = Person.query.filter_by(authorization='labuser').all()
    if request.method == 'POST':
        team.name = request.values.get('name')
        team.brief = request.values.get('brief')
        team.task = request.values.get('task')
        db.session.add(team)
        db.session.commit()
        option = request.values.getlist("s_option")
        for s in option:
            selected_person = Person.query.filter_by(username=s).first()
            selected_team = Team.query.filter_by(name=request.values.get('name')).first()
            selected_person.team.append(selected_team)
            db.session.add(selected_person)
        db.session.commit()
        flash('成功添加团队')
        return redirect(url_for('main.index'))
    return render_template('add_team.html', member=member)


@team.route('/show-team',methods=['GET','POST'])
def show_team():
    teams = Team.query.all()
    person = Person.query.filter_by(authorization='labuser').all()
    return render_template('show_team.html',teams=teams,person=person)
@team.route('/manage-team',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def manage_team():
    team = Team.query.all()
    return render_template('manage_team.html',team=team)

@team.route('/edit-team%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def edit_team(id):
    change = Team.query.get_or_404(id)
    selected = change.person.all()
    labuser = Person.query.filter_by(authorization='labuser').all()
    unselected = []
    for x in labuser:
         if x not in selected:
            unselected.append(x)
    if request.method == 'POST':
        option1 = request.values.getlist("delete_option")
        option2 = request.values.getlist("add_option")
        for s in option1:
            remove_person = Person.query.filter_by(username=s).first()
            remove_person.team.remove(change)
            db.session.add(remove_person)
        for t in option2:
            add_person = Person.query.filter_by(username=t).first()
            add_person.team.append(change)
            db.session.add(add_person)
        db.session.commit()
        flash('成功修改团队')
        return redirect(url_for('main.index'))
    return render_template('edit_team.html',change=change,selected=selected,unselected=unselected)

@team.route('/delete-team%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_team(id):
    change = Team.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('删除成功')
    return redirect(url_for('.manage_team'))
