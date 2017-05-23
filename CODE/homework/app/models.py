from werkzeug.security import generate_password_hash, check_password_hash
from flask import current_app,request
from flask_login import UserMixin
from . import db,login_manager
from datetime import datetime

relation = db.Table('relation', \
                    db.Column('person_id', db.Integer,db.ForeignKey('person.id')), \
                    db.Column('team_id', db.Integer,db.ForeignKey('team.id')))
relation_project = db.Table('relation_project', \
                            db.Column('team_id', db.Integer, db.ForeignKey('team.id')), \
                            db.Column('project_id', db.Integer, db.ForeignKey('project.id')))
class Person(UserMixin, db.Model):
    __tablename__ = 'person'
    id = db.Column(db.Integer,primary_key=True)
    username = db.Column(db.String(64),unique=True,index=True)
    email = db.Column(db.String(30),unique=True,index=True)
    authorization = db.Column(db.String(64),unique=False)
    name = db.Column(db.String(64))
    tel = db.Column(db.String(11))
    gender = db.Column(db.String(8))
    target = db.Column(db.String(8))
    password_hash = db.Column(db.String(128))
    introduction = db.Column(db.Text())
    articles = db.relationship('Article',backref='person',lazy='dynamic')
    team = db.relationship('Team', \
                           secondary=relation, \
                           backref=db.backref('person',lazy='dynamic'), \
                           lazy='dynamic')

    @property
    def password(self):
        raise AttributeError('password is a readable attribute')

    @password.setter
    def password(self,password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self,password):
        return check_password_hash(self.password_hash,password)

    def __repr__(self):
        return '<Person %r>' % self.username

@login_manager.user_loader
def load_user(user_id):
    return Person.query.get(int(user_id))


class News(db.Model):
    __tablename__ = 'news'
    id = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(64),unique=True,index=True)
    content = db.Column(db.Text())
    connect = db.Column(db.String(128))
    time = db.Column(db.DateTime(),default=datetime.utcnow)

    def ping(self):
        self.time = datetime.utcnow()
        db.session.add(self)

    def __repr__(self):
        return '<News %r>' % self.title

class Notice(db.Model):
    __tablename__ = 'notice'
    id = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(64),unique=True,index=True)
    content = db.Column(db.Text())
    time = db.Column(db.DateTime(),default=datetime.now)

    def ping(self):
        self.time = datetime.now()
        db.session.add(self)

    def __repr__(self):
        return '<Notice %r>' % self.title

class Project(db.Model):
    __tablename__ = 'project'
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(64),unique=True,index=True)
    starttime = db.Column(db.DateTime())
    endtime = db.Column(db.DateTime())
    introduction = db.Column(db.Text())
    progress = db.Column(db.Text())
    major = db.Column(db.String(64))

    def __repr__(self):
        return '<Project %r>' % self.name

class Team(db.Model):
    __tablename__ = 'team'
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(128),unique=True,index=True)
    brief = db.Column(db.Text())
    project = db.relationship('Project', \
                              secondary=relation_project, \
                              backref=db.backref('team',lazy='dynamic'), \
                              lazy='dynamic')
    task = db.Column(db.Text())
    
    def __repr__(self):
        return '<Team %r>' % self.name

class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(128),unique=True,index=True)
    uploadperson = db.Column(db.Integer,db.ForeignKey('person.id'))
    uploadtime = db.Column(db.DateTime(),default=datetime.now)
    about = db.Column(db.String(128))
    target = db.Column(db.String(8)) 
    brief = db.Column(db.Text())
    link = db.Column(db.Text())

    def ping(self):
        self.uploadtime = datetime.now() 
        db.session.add(self)

    def __repr__(self):
        return '<Article %r>' % self.title

class Conference(db.Model):
    __tablename__ = 'conference'
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(128),unique=True,index=True)
    starttime = db.Column(db.DateTime())
    endtime = db.Column(db.DateTime())
    spot = db.Column(db.Text())
    link = db.Column(db.String(128))

    def __repr__(self):
        return '<Conference %r>' % self.name

