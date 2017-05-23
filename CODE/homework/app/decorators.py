from functools import wraps
from flask import abort
from flask_login import current_user

def permission_required(permission):
    def decorator(f):
        @wraps(f) 
        def decorated_function(*args,**kwargs):
            if not current_user.authorization in permission:
                abort(403)
            return f(*args,**kwargs)
        return decorated_function
    return decorator

