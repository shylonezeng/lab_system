from datetime import datetime

from django.contrib.auth.models import User
from django.db import models


# begin my data models
class Book(models.Model):
    name = models.CharField(max_length=100)
    author = models.CharField(max_length=100)
    publisher= models.CharField(max_length=100)
    pub_time=models.DateField(null=False)
    status=models.CharField(max_length=15)  # three status : nomal ,ordered, borrowed,recommended 
    
    def __unicode__(self):
        return self.name
#can be igonred, because of unsing django build-in system     
# class User(models.Model):
#     name = models.CharField(max_length=50)
#     email = models.EmailField()
#     
#     def __unicode__(self):
#         return self.name

class Borrow_item(models.Model):  
    user = models.ForeignKey(User)
    book = models.ForeignKey(Book)
    borrow_time = models.DateTimeField(default=datetime.now())
    return_time = models.DateTimeField()
    
    def _unicode_(self):
        return self.book.name
    
#two other models
class Event(models.Model):
    etime=models.DateTimeField()
    title=models.CharField(max_length=100)
    detail=models.TextField()
    
    def __unicode__(self):
        return self.title

class News(models.Model):
    title = models.CharField(max_length=100)
    detail = models.TextField()
    picture = models.ImageField(upload_to='upload',null=True)

    def __unicode__(self):
        return self.title   #u'%s %s' % (self.first_name, self.last_name)

    
    
    
    
    
    
    