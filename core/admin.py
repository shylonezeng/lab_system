from django.contrib import admin
from core.models import Book, User, Borrow_item ,Event, News

admin.site.register(Book)
admin.site.register(User)
admin.site.register(Borrow_item)
admin.site.register(Event)
admin.site.register(News)