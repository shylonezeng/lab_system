from django.db import models
from datetime import datetime

# begin my data models
class Book(models.Model):
    name = models.CharField(max_length=100)
    author = models.CharField(max_length=50)
    publisher= models.CharField(max_length=50)
    pub_time=models.DateField(null=False)
    status=models.CharField(max_length=10)
    
    def __unicode__(self):
        return self.name
    
class User(models.Model):
    name = models.CharField(max_length=50)
    email = models.EmailField()
    
    def __unicode__(self):
        return self.name

class Borrow_item(models.Model):  
    user = models.ForeignKey(User)
    book = models.ForeignKey(Book)
    borrow_time = models.DateTimeField()
    return_time = models.DateTimeField('party datetime',default=datetime.now())
    
    def _unicode_(self):
        return self.book.name
    
#two other models
class Event(models.Model):
    etime=models.DateTimeField()
    title=models.CharField(max_length=100)
    detail=models.CharField(max_length=500)
    
    def __unicode__(self):
        return self.title

class News(models.Model):
    title = models.CharField(max_length=100)
    detail = models.CharField(max_length=2000)
    picture = models.ImageField(upload_to='upload',null=True)

    def __unicode__(self):
        return self.title   #u'%s %s' % (self.first_name, self.last_name)

    
    
    
    
    
    
    