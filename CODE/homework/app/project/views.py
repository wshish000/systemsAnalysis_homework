#!/usr/bin/env python
# -*-coding: utf-8 -*-
from flask import render_template,redirect,url_for,abort,flash,request
from flask_login import login_required
from .import project
from .. import db
from ..models import Team,Project,Article
from .forms import UpdateProjectForm
from ..decorators import permission_required

@project.route('/add-project', methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def add_project():
    project = Project()
    participant = Team.query.all()
    if request.method == 'POST':
        project.name = request.values.get("name")
        project.introduction = request.values.get('introduction')
        choice = request.values.getlist("b_option")
        project.major = request.values.get("a_option")
        project.starttime = request.values.get("starttime")
        project.endtime = request.values.get("endtime")
        db.session.add(project)
        db.session.commit()
        if project.major not in choice:
            choice.append(project.major)
        for x in choice:
            selected_teams = Team.query.filter_by(name=x).first()
            selected_project = Project.query.filter_by(name=request.values.get('name')).first()
            selected_teams.project.append(selected_project)
            db.session.add(selected_teams)
        db.session.commit()
        flash("Add project successfully!")
        return redirect(url_for('main.index'))
    return render_template('add_project.html', participant=participant)

@project.route('/show-project',methods=['GET','POST'])
def show_project():
    projects = Project.query.all()
    article = Article.query.all()
    return render_template('show_project.html',projects=projects,article=article)
@project.route('/manage-project',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def manage_project():
    project = Project.query.all()
    return render_template('manage_project.html',project=project)

@project.route('/update_project%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def update_project(id):
    change = Project.query.get_or_404(id)
    form = UpdateProjectForm()
    if form.validate_on_submit():
        change.introduction = form.introduction.data
        change.progress = form.progress.data
        db.session.add(change)
        db.session.commit()
        flash('信息更新成功')
        return redirect(url_for('.manage_project'))
    form.introduction.data = change.introduction
    form.progress.data = change.progress
    return render_template('update_project.html',form=form,change=change)


@project.route('/edit-project%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def edit_project(id):
    change = Project.query.get_or_404(id)
    selected = change.team.all()
    teams = Team.query.all()
    unselected = []
    for x in teams:
         if x not in selected:
            unselected.append(x)
    if request.method == 'POST':
        option1 = request.values.getlist("delete_option")
        option2 = request.values.getlist("add_option")
        for s in option1:
            remove_team = Team.query.filter_by(name=s).first()
            remove_team.project.remove(change)
            db.session.add(remove_team)
        for t in option2:
            add_team = Team.query.filter_by(name=t).first()
            add_team.project.append(change)
            db.session.add(add_team)
        db.session.commit()
        flash('Edit project successfully!')
        return redirect(url_for('main.index'))
    return render_template('edit_project.html',change=change,selected=selected,unselected=unselected)

@project.route('/delete-project%<int:id>',methods=['GET','POST'])
@login_required
@permission_required(['superad','generalad'])
def delete_project(id):
    change = Project.query.get_or_404(id)
    db.session.delete(change)
    db.session.commit()
    flash('删除成功')
    return redirect(url_for('.manage_project'))
