from django import forms
from django.contrib.auth.models import User

from core.models import Book, Borrow_item


class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput())

    class Meta:
        model = User
        fields = ('name', 'email', 'password')
    
class BookForm(forms.ModelForm):
    class Meta:
        model =Book
        
class BorrowItemForm(forms.ModelForm):
    class Meta:
        model = Borrow_item