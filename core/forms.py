from django import forms
from django.contrib.auth.forms import User

from core.models import Book, Borrow_item



    
class BookForm(forms.ModelForm):
#    name = forms.CharField(max_length=100)
#     author = forms.CharField(max_length=50)
#     publisher= forms.CharField(max_length=50)
#     pub_time=forms.DateField(null=False)
#     status=forms.CharField(max_length=10)  # three status : nomal ,ordered, borrowed,recommended 
    
    class Meta:
        model = Book
        #fields = ('name', 'author','publisher','pub_time')
        
class BorrowItemForm(forms.ModelForm):
    class Meta:
        model = Borrow_item